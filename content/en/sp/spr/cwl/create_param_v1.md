---
title: "createParam V1" 
editor_options: 
  chunk_output_type: console
type: docs
weight: 3
---


```r
suppressPackageStartupMessages({
    library(systemPipeR)
})
```

`createParam` by default uses the version 1 syntax, so there is no need to 
provide additional version argument. We will see in the [next section](../create_param_v2) how to 
use `syntaxVersion` to change to the v2 syntax.


## Input

Imagine we want to create CWL for command: 


```bash
hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz
```

To use `createParam`, simply write the command in a pseudo-bash script format:


```r
command <- "
    hisat2 \
    -S <F, out: ./results/M1A.sam> \
    -x <F: ./data/tair10.fasta> \
     -k <int: 1> \
    -min-intronlen <int: 30> \
    -max-intronlen <int: 3000> \
    -threads <int: 4> \
    -U <F: ./data/SRR446027_1.fastq.gz>
"
```

### Format

What does the string above mean?

- First line is the base command. Each line is an argument with its default value.

- For argument lines (starting from the second line), any word before the first 
  space with leading `-` or `--` in each will be treated as a prefix, like `-S` or 
  `--min`. Any line without this first word will be treated as no prefix. 
  
- All defaults are placed inside `<...>`.

- First argument is the input argument type. "File" (or "F") for files, "int" for integers, "string" for character strings.

- Optional: use the keyword `out` followed the type with a `,` comma separation to 
  indicate if this argument is also an CWL output.
  
- Then, use `:` to separate keywords and default values, any non-space value after the `:`
  will be treated as the default value. 
  
- If any argument has no default value, just a flag, like `--verbose`, there is no need to add any `<...>`

## run `createParam` Function

The string above that we just defined will be used as input for `createParam`. 

If the format is correct, after parsing, the function will print the three components of the `cwl` file:
    - `BaseCommand`: Specifies the program to execute. 
    - `Inputs`: Defines the input parameters of the process.
    - `Outputs`: Defines the parameters representing the output of the process.
    
The fourth printed component is the translated command-line from CWL.

If in you are using R interactively, the function will verify that everything is correct and 
will ask you to proceed. Here, the user can answer "no" and provide more 
information at the string level. Another question is to save the param created here.

If running the workflow in non-interactive mode, the `createParam` function will 
consider "yes" and returning the container.


```r
cmd <- createParam(command, writeParamFiles = FALSE)
```

```
## *****BaseCommand*****
## hisat2 
## *****Inputs*****
## S:
##     type: File
##     preF: -S
##     yml: ./results/M1A.sam
## x:
##     type: File
##     preF: -x
##     yml: ./data/tair10.fasta
## k:
##     type: int
##     preF: -k
##     yml: 1
## min-intronlen:
##     type: int
##     preF: -min-intronlen
##     yml: 30
## max-intronlen:
##     type: int
##     preF: -max-intronlen
##     yml: 3000
## threads:
##     type: int
##     preF: -threads
##     yml: 4
## U:
##     type: File
##     preF: -U
##     yml: ./data/SRR446027_1.fastq.gz
## *****Outputs*****
## output1:
##     type: File
##     value: ./results/M1A.sam
## *****Parsed raw command line*****
## hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz
```

If the user chooses not to save the `param` files on the above operation, 
later, one can use the `writeParamFiles` function.


```r
writeParamFiles(cmd, overwrite = TRUE)
```

```
## 	 Written content of 'commandLine' to file: 
##  param/cwl/hisat2/hisat2.cwl 
## 	 Written content of 'commandLine' to file: 
##  param/cwl/hisat2/hisat2.yml
```

By default, the files will be saved inside `./param/cwl/base_cmd`. It means a 
child folder under _param_ then _cwl_, and create a new folder named by the base command
of the command-line. 

## Access and edit param files

### Print a component


```r
printParam(cmd, position = "baseCommand") ## Print a baseCommand section
```

```
## *****BaseCommand*****
## hisat2
```

```r
printParam(cmd, position = "outputs")
```

```
## *****Outputs*****
## output1:
##     type: File
##     value: ./results/M1A.sam
```

```r
printParam(cmd, position = "inputs", index = 1:2) ## Print by index
```

```
## *****Inputs*****
## S:
##     type: File
##     preF: -S
##     yml: ./results/M1A.sam
## x:
##     type: File
##     preF: -x
##     yml: ./data/tair10.fasta
```

```r
printParam(cmd, position = "inputs", index = -1:-2) ## Negative indexing printing to exclude certain indices in a position
```

```
## *****Inputs*****
## k:
##     type: int
##     preF: -k
##     yml: 1
## min-intronlen:
##     type: int
##     preF: -min-intronlen
##     yml: 30
## max-intronlen:
##     type: int
##     preF: -max-intronlen
##     yml: 3000
## threads:
##     type: int
##     preF: -threads
##     yml: 4
## U:
##     type: File
##     preF: -U
##     yml: ./data/SRR446027_1.fastq.gz
```

### Subsetting the command-line


```r
cmd2 <- subsetParam(cmd, position = "inputs", index = 1:2, trim = TRUE)
```

```
## *****Inputs*****
## S:
##     type: File
##     preF: -S
##     yml: ./results/M1A.sam
## x:
##     type: File
##     preF: -x
##     yml: ./data/tair10.fasta
## *****Parsed raw command line*****
## hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta
```

```r
cmdlist(cmd2)
```

```
## $defaultid
## $defaultid$hisat2
## [1] "hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta"
```

```r
cmd2 <- subsetParam(cmd, position = "inputs", index = c("S", "x"), trim = TRUE)
```

```
## *****Inputs*****
## S:
##     type: File
##     preF: -S
##     yml: ./results/M1A.sam
## x:
##     type: File
##     preF: -x
##     yml: ./data/tair10.fasta
## *****Parsed raw command line*****
## hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta
```

```r
cmdlist(cmd2)
```

```
## $defaultid
## $defaultid$hisat2
## [1] "hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta"
```

### Replacing a existing argument in the command-line


```r
cmd3 <- replaceParam(cmd, "base", index = 1, replace = list(baseCommand = "bwa"))
```

```
## Replacing baseCommand
## *****BaseCommand*****
## bwa 
## *****Parsed raw command line*****
## bwa -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz
```

```r
cmdlist(cmd3)
```

```
## $defaultid
## $defaultid$hisat2
## [1] "bwa -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz"
```


```r
new_inputs <- new_inputs <- list(
    "new_input1" = list(type = "File", preF="-b", yml ="myfile"),
    "new_input2" = "-L <int: 4>"
)
cmd4 <- replaceParam(cmd, "inputs", index = 1:2, replace = new_inputs)
```

```
## Replacing inputs
## *****Inputs*****
## new_input1:
##     type: File
##     preF: -b
##     yml: myfile
## new_input2:
##     type: int
##     preF: -L
##     yml: 4
## k:
##     type: int
##     preF: -k
##     yml: 1
## min-intronlen:
##     type: int
##     preF: -min-intronlen
##     yml: 30
## max-intronlen:
##     type: int
##     preF: -max-intronlen
##     yml: 3000
## threads:
##     type: int
##     preF: -threads
##     yml: 4
## U:
##     type: File
##     preF: -U
##     yml: ./data/SRR446027_1.fastq.gz
## *****Parsed raw command line*****
## hisat2 -b myfile -L 4 -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz
```

```r
cmdlist(cmd4)
```

```
## $defaultid
## $defaultid$hisat2
## [1] "hisat2 -b myfile -L 4 -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz"
```

### Adding new arguments


```r
newIn <- new_inputs <- list(
    "new_input1" = list(type = "File", preF="-b1", yml ="myfile1"),
    "new_input2" = list(type = "File", preF="-b2", yml ="myfile2"),
    "new_input3" = "-b3 <F: myfile3>"
)
cmd5 <- appendParam(cmd, "inputs", index = 1:2, append = new_inputs)
```

```
## Replacing inputs
## *****Inputs*****
## S:
##     type: File
##     preF: -S
##     yml: ./results/M1A.sam
## x:
##     type: File
##     preF: -x
##     yml: ./data/tair10.fasta
## k:
##     type: int
##     preF: -k
##     yml: 1
## min-intronlen:
##     type: int
##     preF: -min-intronlen
##     yml: 30
## max-intronlen:
##     type: int
##     preF: -max-intronlen
##     yml: 3000
## threads:
##     type: int
##     preF: -threads
##     yml: 4
## U:
##     type: File
##     preF: -U
##     yml: ./data/SRR446027_1.fastq.gz
## new_input1:
##     type: File
##     preF: -b1
##     yml: myfile1
## new_input2:
##     type: File
##     preF: -b2
##     yml: myfile2
## new_input3:
##     type: File
##     preF: -b3
##     yml: myfile3
## *****Parsed raw command line*****
## hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz -b1 myfile1 -b2 myfile2 -b3 myfile3
```

```r
cmdlist(cmd5)
```

```
## $defaultid
## $defaultid$hisat2
## [1] "hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz -b1 myfile1 -b2 myfile2 -b3 myfile3"
```

```r
cmd6 <- appendParam(cmd, "inputs", index = 1:2, after=0, append = new_inputs)
```

```
## Replacing inputs
## *****Inputs*****
## new_input1:
##     type: File
##     preF: -b1
##     yml: myfile1
## new_input2:
##     type: File
##     preF: -b2
##     yml: myfile2
## new_input3:
##     type: File
##     preF: -b3
##     yml: myfile3
## S:
##     type: File
##     preF: -S
##     yml: ./results/M1A.sam
## x:
##     type: File
##     preF: -x
##     yml: ./data/tair10.fasta
## k:
##     type: int
##     preF: -k
##     yml: 1
## min-intronlen:
##     type: int
##     preF: -min-intronlen
##     yml: 30
## max-intronlen:
##     type: int
##     preF: -max-intronlen
##     yml: 3000
## threads:
##     type: int
##     preF: -threads
##     yml: 4
## U:
##     type: File
##     preF: -U
##     yml: ./data/SRR446027_1.fastq.gz
## *****Parsed raw command line*****
## hisat2 -b1 myfile1 -b2 myfile2 -b3 myfile3 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz
```

```r
cmdlist(cmd6)
```

```
## $defaultid
## $defaultid$hisat2
## [1] "hisat2 -b1 myfile1 -b2 myfile2 -b3 myfile3 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz"
```

### Editing `output` param


```r
new_outs <- list(
    "sam_out" = "<F: $(inputs.results_path)/test.sam>"
) 
cmd7 <- replaceParam(cmd, "outputs", index = 1, replace = new_outs)
```

```
## Replacing outputs
## *****Outputs*****
## sam_out:
##     type: File
##     value: $(inputs.results_path)/test.sam
## *****Parsed raw command line*****
## hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz
```

```r
output(cmd7) 
```

```
## $defaultid
## $defaultid$hisat2
## [1] "./results/test.sam"
```

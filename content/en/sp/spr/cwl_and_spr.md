---
title: "SPR and CWL" 
author: "Author: Daniela Cassol (danielac@ucr.edu)"
date: "Last update: 06 December, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex.bib
editor_options: 
  chunk_output_type: console
type: docs
weight: 7
---

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("h1").className = "title";
});
</script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  var links = document.links;  
  for (var i = 0, linksLength = links.length; i < linksLength; i++)
    if (links[i].hostname != window.location.hostname)
      links[i].target = '_blank';
});
</script>

## How to connect CWL description files within *`systemPipeR`*

This section will demonstrate how to connect CWL parameters files to create
workflows. In addition, we will show how the workflow can be easily scalable
with *`systemPipeR`*.

`SYSargsList` container stores all the information and instructions needed for processing
a set of input files with a single or many command-line steps within a workflow
(i.e. several components of the software or several independent software tools).
The `SYSargsList` object is created and fully populated with the `SYSargsList` construct
function.
Full documentation of `SYSargsList` management instances can be found [here](#sysargslist)
and [here](#appendstep).

The following imports a `.cwl` file (here `example.cwl`) for running the `echo Hello World!`
example.

``` r
HW <- SYSargsList(wf_file = "example/workflow_example.cwl", input_file = "example/example_single.yml",
    dir_path = system.file("extdata/cwl", package = "systemPipeR"))
HW
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. Step_x --> Status: Pending 
    ##            Total Files: 1 | Existing: 0 | Missing: 1 
    ##          1.1. echo
    ##              cmdlist: 1 | Pending: 1
    ## 

``` r
cmdlist(HW)
```

    ## $Step_x
    ## $Step_x$defaultid
    ## $Step_x$defaultid$echo
    ## [1] "echo Hello World! > results/M1.txt"

However, we are limited to run just one command-line or one sample in this example.
To scale the command-line over many samples, a simple solution offered by `systemPipeR`
is to provide a `variable` for each of the parameters that we want to run with multiple samples.

Let’s explore the example:

``` r
dir_path <- system.file("extdata/cwl", package = "systemPipeR")
yml <- yaml::read_yaml(file.path(dir_path, "example/example.yml"))
yml
```

    ## $message
    ## [1] "_STRING_"
    ## 
    ## $SampleName
    ## [1] "_SAMPLE_"
    ## 
    ## $results_path
    ## $results_path$class
    ## [1] "Directory"
    ## 
    ## $results_path$path
    ## [1] "./results"

For the `message` and `SampleName` parameter, we are passing a variable connecting
with a third file called `targets.`

Now, let’s explore the `targets` file structure:

``` r
targetspath <- system.file("extdata/cwl/example/targets_example.txt", package = "systemPipeR")
read.delim(targetspath, comment.char = "#")
```

    ##               Message SampleName
    ## 1        Hello World!         M1
    ## 2          Hello USA!         M2
    ## 3 Hello Bioconductor!         M3

The `targets` file defines all input files or values and sample ids of an analysis workflow.
For this example, we have defined a string message for the `echo` command-line tool,
in the first column that will be evaluated, and the second column is the
`SampleName` id for each one of the messages.
Any number of additional columns can be added as needed.

Users should note here, the usage of `targets` files is optional when using
`systemPipeR's` new CWL interface. Since for organizing experimental variables targets
files are extremely useful and user-friendly. Thus, we encourage users to keep using them.

### How to connect the parameter files and `targets` file information?

The constructor function creates an `SYSargsList` S4 class object connecting three input files:

-   CWL command-line specification file (`wf_file` argument);
-   Input variables (`input_file` argument);
-   Targets file (`targets` argument).

As demonstrated above, the latter is optional for workflow steps lacking input files.
The connection between input variables (here defined by `input_file` argument)
and the `targets` file are defined under the `inputvars` argument.
A named vector is required, where each element name needs to match with column
names in the `targets` file, and the value must match the names of the *.yml*
variables. This is used to replace the CWL variable and construct all the command-line
for that particular step.

The variable pattern `_XXXX_` is used to distinguish CWL variables that target
columns will replace. This pattern is recommended for consistency and easy identification
but not enforced.

The following imports a `.cwl` file (same example demonstrated above) for running
the `echo Hello World` example. However, now we are connecting the variable defined
on the `.yml` file with the `targets` file inputs.

``` r
HW_mul <- SYSargsList(step_name = "echo", targets = targetspath, wf_file = "example/workflow_example.cwl",
    input_file = "example/example.yml", dir_path = dir_path, inputvars = c(Message = "_STRING_",
        SampleName = "_SAMPLE_"))
HW_mul
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. echo --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          1.1. echo
    ##              cmdlist: 3 | Pending: 3
    ## 

``` r
cmdlist(HW_mul)
```

    ## $echo
    ## $echo$M1
    ## $echo$M1$echo
    ## [1] "echo Hello World! > results/M1.txt"
    ## 
    ## 
    ## $echo$M2
    ## $echo$M2$echo
    ## [1] "echo Hello USA! > results/M2.txt"
    ## 
    ## 
    ## $echo$M3
    ## $echo$M3$echo
    ## [1] "echo Hello Bioconductor! > results/M3.txt"

<div class="figure" style="text-align: center">

<img src="/home/dcassol/src/R-4.1.0/library/systemPipeR/extdata/images/SPR_CWL_hello.png" alt="WConnectivity between CWL param files and targets files." width="100%" />
<p class="caption">
Figure 1: WConnectivity between CWL param files and targets files.
</p>

</div>

## Creating the CWL param files from the command-line

Users need to define the command-line in a pseudo-bash script format:

``` r
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

### Define prefix and defaults

-   First line is the base command. Each line is an argument with its default value.

-   For argument lines (starting from the second line), any word before the first
    space with leading `-` or `--` in each will be treated as a prefix, like `-S` or
    `--min`. Any line without this first word will be treated as no prefix.

-   All defaults are placed inside `<...>`.

-   First argument is the input argument type. `F` for “File,” “int,” “string” are unchanged.

-   Optional: use the keyword `out` followed the type with a `,` comma separation to
    indicate if this argument is also an CWL output.

-   Then, use `:` to separate keywords and default values, any non-space value after the `:`
    will be treated as the default value.

-   If any argument has no default value, just a flag, like `--verbose`, there is no need to add any `<...>`

### `createParam` Function

`createParam` function requires the `string` as defined above as an input.

First of all, the function will print the three components of the `cwl` file:
- `BaseCommand`: Specifies the program to execute.
- `Inputs`: Defines the input parameters of the process.
- `Outputs`: Defines the parameters representing the output of the process.

The four component is the original command-line.

If in interactive mode, the function will verify that everything is correct and
will ask you to proceed. Here, the user can answer “no” and provide more
information at the string level. Another question is to save the param created here.

If running the workflow in non-interactive mode, the `createParam` function will
consider “yes” and returning the container.

``` r
cmd <- createParam(command, writeParamFiles = FALSE)
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

If the user chooses not to save the `param` files on the above operation,
it can use the `writeParamFiles` function.

``` r
writeParamFiles(cmd, overwrite = TRUE)
```

### How to access and edit param files

#### Print a component

``` r
printParam(cmd, position = "baseCommand")  ## Print a baseCommand section
```

    ## *****BaseCommand*****
    ## hisat2

``` r
printParam(cmd, position = "outputs")
```

    ## *****Outputs*****
    ## output1:
    ##     type: File
    ##     value: ./results/M1A.sam

``` r
printParam(cmd, position = "inputs", index = 1:2)  ## Print by index
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

``` r
printParam(cmd, position = "inputs", index = -1:-2)  ## Negative indexing printing to exclude certain indices in a position
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

#### Subsetting the command-line

``` r
cmd2 <- subsetParam(cmd, position = "inputs", index = 1:2, trim = TRUE)
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

``` r
cmdlist(cmd2)
```

    ## $defaultid
    ## $defaultid$hisat2
    ## [1] "hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta"

``` r
cmd2 <- subsetParam(cmd, position = "inputs", index = c("S", "x"), trim = TRUE)
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

``` r
cmdlist(cmd2)
```

    ## $defaultid
    ## $defaultid$hisat2
    ## [1] "hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta"

#### Replacing a existing argument in the command-line

``` r
cmd3 <- replaceParam(cmd, "base", index = 1, replace = list(baseCommand = "bwa"))
```

    ## Replacing baseCommand
    ## *****BaseCommand*****
    ## bwa 
    ## *****Parsed raw command line*****
    ## bwa -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz

``` r
cmdlist(cmd3)
```

    ## $defaultid
    ## $defaultid$hisat2
    ## [1] "bwa -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz"

``` r
new_inputs <- new_inputs <- list(new_input1 = list(type = "File", preF = "-b", yml = "myfile"),
    new_input2 = "-L <int: 4>")
cmd4 <- replaceParam(cmd, "inputs", index = 1:2, replace = new_inputs)
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

``` r
cmdlist(cmd4)
```

    ## $defaultid
    ## $defaultid$hisat2
    ## [1] "hisat2 -b myfile -L 4 -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz"

#### Adding new arguments

``` r
newIn <- new_inputs <- list(new_input1 = list(type = "File", preF = "-b1", yml = "myfile1"),
    new_input2 = list(type = "File", preF = "-b2", yml = "myfile2"), new_input3 = "-b3 <F: myfile3>")
cmd5 <- appendParam(cmd, "inputs", index = 1:2, append = new_inputs)
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

``` r
cmdlist(cmd5)
```

    ## $defaultid
    ## $defaultid$hisat2
    ## [1] "hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz -b1 myfile1 -b2 myfile2 -b3 myfile3"

``` r
cmd6 <- appendParam(cmd, "inputs", index = 1:2, after = 0, append = new_inputs)
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

``` r
cmdlist(cmd6)
```

    ## $defaultid
    ## $defaultid$hisat2
    ## [1] "hisat2 -b1 myfile1 -b2 myfile2 -b3 myfile3 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz"

#### Editing `output` param

``` r
new_outs <- list(sam_out = "<F: $(inputs.results_path)/test.sam>")
cmd7 <- replaceParam(cmd, "outputs", index = 1, replace = new_outs)
```

    ## Replacing outputs
    ## *****Outputs*****
    ## sam_out:
    ##     type: File
    ##     value: $(inputs.results_path)/test.sam
    ## *****Parsed raw command line*****
    ## hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz

``` r
output(cmd7)
```

    ## $defaultid
    ## $defaultid$hisat2
    ## [1] "./results/test.sam"

---
title: "createParam V2" 
editor_options: 
  chunk_output_type: console
type: docs
weight: 4
---



`createParam` has a second different set of input syntax version 2. To use this new 
version `createParam(..., syntaxVersion = "v2")` must be provided. 


## New in v2
What new features are included in the v2?

- Support duplicated argument flags. Some programs uses the same flag, like 
  `-f file1 -f file2 -f file3` for multiple files. This feature is added in v2.
- [CWL argument](https://www.commonwl.org/user_guide/03-input/index.html) component support. 
- [CWL positions](https://www.commonwl.org/user_guide/03-input/index.html) in inputs and arguments components support. 
- positional argument without any prefix. 
- Prefix other than dash `-` or `--`. Some programs do not use dash as flags, for example some 
  uses `@`. This is supported in v2.
- [CWL standard out](https://www.commonwl.org/user_guide/05-stdout/index.html)
- [more types](https://www.commonwl.org/user_guide/03-input/index.html) support, long, float, double, boolean


## Input

Imagine we want to create CWL for command: 


```r
suppressPackageStartupMessages({
    library(systemPipeR)
})
```



```bash
mycmd -s sample1.txt -s sample2.txt --c -o myout.txt  a.fasta --nn 12 > abc.txt
```

To use `createParam`, simply write the command in a pseudo-bash script format:


```r
command <- '
mycmd \
    p: -s; File; sample1.txt \
    p: -s; File; sample2.txt \
    p: --c; ; \
    p: -o; File; out: myout.txt \
    ref_genome; File; a.fasta \
    p: --nn; int; 12 \
    mystdout; File; stdout: abc.txt
'
```

### Format

- First line of the command-line object will be treated as the `baseCommand`;

- Each line specifies one argument and its default value.

- Each line is composed with exact **2** `;` to separate **3** columns. Some 
  columns can leave empty

- Text before first `;` will be will used as prefix/names. If it starts with keyword "`p:`", 
  anything after "`p:`" and before the first `;` will be used as prefix, and the 
  name of this position will be the prefix but with leading dash(s) "`-`", "`--`" removed. 
  If there is any duplication, a number index will be added to the end for the names. 
  If there is no keyword "`p:`" before first `;`, all text before first `;` will be the name.

- If there is keyword "`p:`" before first `;` but nothing before and after the second `;`, 
  this position will be treated as CWL **argument** instead of input.

- Text between first and second `;` is type. Must be one of File, Directory, string, int, double, float, long, boolean.

- Text after second `;` and before `\` or end of the line is the default value. 
  If it starts with keyword "`out`" or "`stdout`", this position will also be added to outputs or standard output.

- There is only **1** line can have "`stdout`" and usually it is the last position argument.

- Ending with "`\`" is recommended but not required.


Below is a table of examples to demonstrate if values given or not given in different columns 
how `createParam` would translate them to. 

|example                                             |name/prefix column|type column          |value column         |translate to             |
|---|---|---|---|---|
|first line                                          |mycmd             |                     |                     |->base command           |
|no type, no value                                   |p: --prefix;      |;                    |                     |-> arguments             |
|with prefix, type, or value                         |p: -prefix;       |type;                |default_value        |-> normal input          |
|no prefix                                           |name;             |type;                |default_value        |-> inputs no prefix      |
|prefix other than dash                              |p: @prefix;       |type;                |default_value        |-> inputs, prefix no dash|
|output binding specified in third column            |p: -prefix;       |type;                |out: default_value   |-> inputs, outputs       |
|standard out binding specified in third column      |name;             |type;                |stdout: default_value|-> stdout                |

## run `createParam` Function

The string above that we just defined will be used as input for `createParam`. 

If the format is correct, after parsing, the function will print the three components of the `cwl` file:

- `BaseCommand`: Specifies the program to execute. 
- `Inputs`: Defines the input parameters of the process.
- `Arguments`: Usually flags with some fixed values.
- `Outputs`: Defines the parameters representing the output of the process.
- `Stardard out`: stardard out capture of command-line. 
    


```r
cmd <- createParam(command, writeParamFiles = FALSE, syntaxVersion = "v2")
```

```
## *****BaseCommand*****
## mycmd 
## *****Arguments*****
## argument1:
##     prefix: --c
##     position: 3
## *****Inputs*****
## s1:
##     type: File
##     prefix: -s
##     default value: sample1.txt
##     position: 1
## s2:
##     type: File
##     prefix: -s
##     default value: sample2.txt
##     position: 2
## o:
##     type: File
##     prefix: -o
##     default value: myout.txt
##     position: 4
## ref_genome:
##     type: File
##     prefix: 
##     default value: a.fasta
##     position: 5
## nn:
##     type: int
##     prefix: --nn
##     default value: 12
##     position: 6
## *****Outputs*****
## output1:
##     type: File
##     default value: myout.txt
## *****Standard Outputs*****
## mystdout:
##     type: File
##     default value: abc.txt
## *****Parsed raw command line*****
## mycmd -s sample1.txt -s sample2.txt --c -o myout.txt  a.fasta --nn 12 > abc.txt
```

If the user chooses not to save the `param` files on the above operation, 
later, one can use the `writeParamFiles` function.


```r
writeParamFiles(cmd, overwrite = TRUE, syntaxVersion = "v2")
```

```
## 	 Written content of 'commandLine' to file: 
##  param/cwl/mycmd/mycmd.cwl 
## 	 Written content of 'commandLine' to file: 
##  param/cwl/mycmd/mycmd.yml
```

By default, the files will be saved inside `./param/cwl/base_cmd`. It means a 
child folder under _param_ then _cwl_, and create a new folder named by the base command
of the command-line. 

## Access and edit param files

All access and edit functions have the ending of **2**. Syntax v1 and v2 are **not interchangeable**.
Params created by *v1* cannot be used with *v2* utility functions, *vice versa*. 


Usage

```r
printParam2(sysargs, base = FALSE, args = FALSE, inputs = FALSE, outputs = FALSE, stdout = FALSE, raw_cmd = FALSE, all = TRUE)

appendParam2(sysargs, x, position = c("inputs", "args", "outputs"), after = NULL, verbose = FALSE)

replaceParam2(sysargs, x, index=NULL,position = c("inputs", "baseCommand", "args", "outputs", "stdout"), verbose = FALSE)

removeParam2(sysargs, index=NULL, position = c("inputs", "args", "outputs", "stdout"), verbose = FALSE)

renameParam2(sysargs, index=NULL, new_names, position = c("inputs", "args", "outputs", "stdout"), verbose = FALSE)
```

#### Format of utility functions

- `printParam2`: print CWL components of desired, default is to print all.

- `removeParam2`: removes items in certain positions you select.

- `replaceParam2`: replaces the values in command-line with indices given in list by those given in values

- `renameParam2`: rename the names of items in certain position.

- `appendParam2`: Add arguments to the original command line. Adding new `basecommand` or standard out is not allowed.

#### x format
For append and replace functions, there is an argument `x`. It can be either a length 1 
character string or or a list.

- If x is a character, it requires exact **3** semi-colons `;` to separate the string 
  in to **4 columns**. Values before the third column are the same as `createParam` inputs,
  first column: prefix/argument name, second column: type, third column: default value.
  The fourth column (new): numeric, index of the new item, this will be translated into
  position entries in CWL.
    - No `\` should be added to the end.
    - If the key word `out` or `stdout` is included in the default value column, the new 
      component will be treated as outputs or standard outputs.
      Often times, **inputs and outputs are paired** in CWL, and this is done automatically
      in `createParam` for you, but this is **not** the case here. Since the `position`
      argument limit to modify only one place. It will be good 
      to check if the paired inputs component is there or otherwise append the inputs (see examples 
      below).

- If x is a list, it must be named. Following items must be included in list: `name`, `preF`, 
  `type`, `value`, `index.` They refer to name, prefix, param type, default value, 
  and position index correspondingly.
    - baseCommand modification is **not supported** to use list format. 
  
It will be more clear when we walk through examples below.


### Print a component

`printParam2` by default print out all CWL component positions. To select a 
few of them to print, turn `all = FALSE` and turn desired positions in 
any combination to `TRUE`.


```r
# print only base command 
printParam2(cmd, base = TRUE, all = FALSE)
```

```
## *****BaseCommand*****
## mycmd
```

```r
# print inputs and outputs
printParam2(cmd, inputs = TRUE, outputs = TRUE, all = FALSE)
```

```
## *****Inputs*****
## s1:
##     type: File
##     prefix: -s
##     default value: sample1.txt
##     position: 1
## s2:
##     type: File
##     prefix: -s
##     default value: sample2.txt
##     position: 2
## o:
##     type: File
##     prefix: -o
##     default value: myout.txt
##     position: 4
## ref_genome:
##     type: File
##     prefix: 
##     default value: a.fasta
##     position: 5
## nn:
##     type: int
##     prefix: --nn
##     default value: 12
##     position: 6
## *****Outputs*****
## output1:
##     type: File
##     default value: myout.txt
```

```r
# print parsed raw command
printParam2(cmd, raw_cmd = TRUE, all = FALSE)
```

```
## *****Parsed raw command line*****
## mycmd -s sample1.txt -s sample2.txt --c -o myout.txt  a.fasta --nn 12 > abc.txt
```

### Appending new components

#### Adding new inputs

```r
new_cmd <- 'p: -abc; string; abc; 7'
cmd <- appendParam2(cmd, new_cmd, position = "inputs")
printParam2(cmd, inputs = TRUE, raw_cmd = TRUE, all = FALSE)
```

```
## *****Inputs*****
## s1:
##     type: File
##     prefix: -s
##     default value: sample1.txt
##     position: 1
## s2:
##     type: File
##     prefix: -s
##     default value: sample2.txt
##     position: 2
## o:
##     type: File
##     prefix: -o
##     default value: myout.txt
##     position: 4
## ref_genome:
##     type: File
##     prefix: 
##     default value: a.fasta
##     position: 5
## nn:
##     type: int
##     prefix: --nn
##     default value: 12
##     position: 6
## abc:
##     type: string
##     prefix: -abc
##     default value: abc
##     position: 7
## *****Parsed raw command line*****
## mycmd -s sample1.txt -s sample2.txt --c -o myout.txt  a.fasta --nn 12 -abc abc > abc.txt
```

We can see that a new parameter `-abc` and its value `abc` has been added to the last 
command flag before the standard out. 

Alternative, we can do the same with `list` format:

```r
new_cmd_list <- list(name = "abc", preF = "-abc", type = "string", value = "abc", index = 7)
appendParam2(cmd, new_cmd_list, position = "inputs")
```

#### Adding new output

```r
new_cmd <- 'new_out; File; out: new_file.txt;'
commandline <- appendParam2(cmd, new_cmd, position = "outputs", verbose = T)
```

```
## Detected type is: out
```

```
## Appnding to the 2th position in the list
```

```
## *****BaseCommand*****
## mycmd 
## *****Arguments*****
## argument1:
##     prefix: --c
##     position: 3
## *****Inputs*****
## s1:
##     type: File
##     prefix: -s
##     default value: sample1.txt
##     position: 1
## s2:
##     type: File
##     prefix: -s
##     default value: sample2.txt
##     position: 2
## o:
##     type: File
##     prefix: -o
##     default value: myout.txt
##     position: 4
## ref_genome:
##     type: File
##     prefix: 
##     default value: a.fasta
##     position: 5
## nn:
##     type: int
##     prefix: --nn
##     default value: 12
##     position: 6
## abc:
##     type: string
##     prefix: -abc
##     default value: abc
##     position: 7
## *****Outputs*****
## output1:
##     type: File
##     default value: myout.txt
## new_out:
##     type: File
##     default value: new_file.txt
## *****Standard Outputs*****
## mystdout:
##     type: File
##     default value: abc.txt
## *****Parsed raw command line*****
## mycmd -s sample1.txt -s sample2.txt --c -o myout.txt  a.fasta --nn 12 -abc abc > abc.txt
```

```
## Note: New output appended. However, outputs are often come in pairs with inputs. Make sure the corresponding input is there, or append it.
```

```r
printParam2(cmd, outputs = TRUE, raw_cmd = TRUE, all = FALSE)
```

```
## *****Outputs*****
## output1:
##     type: File
##     default value: myout.txt
## *****Parsed raw command line*****
## mycmd -s sample1.txt -s sample2.txt --c -o myout.txt  a.fasta --nn 12 -abc abc > abc.txt
```

Alternative, we can do the same with `list` format:

```r
new_cmd_list <- list(name = "new_out", type = "File", value = "abc.txt")
appendParam2(cmd, new_cmd_list, position = "outputs")
```

### Replacing a existing argument in the command-line


```r
# cmd3 <- replaceParam(cmd, "base", index = 1, replace = list(baseCommand = "bwa"))
# cmdlist(cmd3)
```


```r
# new_inputs <- new_inputs <- list(
#     "new_input1" = list(type = "File", preF="-b", yml ="myfile"),
#     "new_input2" = "-L <int: 4>"
# )
# cmd4 <- replaceParam(cmd, "inputs", index = 1:2, replace = new_inputs)
# cmdlist(cmd4)
```

### Adding new arguments


```r
# newIn <- new_inputs <- list(
#     "new_input1" = list(type = "File", preF="-b1", yml ="myfile1"),
#     "new_input2" = list(type = "File", preF="-b2", yml ="myfile2"),
#     "new_input3" = "-b3 <F: myfile3>"
# )
# cmd5 <- appendParam(cmd, "inputs", index = 1:2, append = new_inputs)
# cmdlist(cmd5)
# 
# cmd6 <- appendParam(cmd, "inputs", index = 1:2, after=0, append = new_inputs)
# cmdlist(cmd6)
```

### Editing `output` param


```r
# new_outs <- list(
#     "sam_out" = "<F: $(inputs.results_path)/test.sam>"
# ) 
# cmd7 <- replaceParam(cmd, "outputs", index = 1, replace = new_outs)
# output(cmd7) 
```

---
title: "SPR and CWL" 
editor_options: 
  chunk_output_type: console
type: docs
weight: 2
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



## How to connect CWL description files within _`systemPipeR`_ 

This section will demonstrate how to connect CWL parameters files to create 
workflows. In addition, we will show how the workflow can be easily scalable 
with _`systemPipeR`_.

`SYSargsList` container stores all the information and instructions needed for processing 
a set of input files with a single or many command-line steps within a workflow 
(i.e. several components of the software or several independent software tools). 
The `SYSargsList` object is created and fully populated with the `SYSargsList` construct
function. 
Full documentation of `SYSargsList` management instances can be found [here](#sysargslist)
and [here](#appendstep).

The following imports a `.cwl` file (here `example.cwl`) for running the `echo Hello World!` 
example.


```r
HW <- SYSargsList(wf_file = "example/workflow_example.cwl", input_file = "example/example_single.yml",
    dir_path = system.file("extdata/cwl", package = "systemPipeR"))
HW
```

```
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. Step_x --> Status: Pending 
##            Total Files: 1 | Existing: 0 | Missing: 1 
##          1.1. echo
##              cmdlist: 1 | Pending: 1
## 
```

```r
cmdlist(HW)
```

```
## $Step_x
## $Step_x$defaultid
## $Step_x$defaultid$echo
## [1] "echo Hello World! > results/M1.txt"
```

However, we are limited to run just one command-line or one sample in this example. 
To scale the command-line over many samples, a simple solution offered by `systemPipeR` 
is to provide a `variable` for each of the parameters that we want to run with multiple samples. 

Let's explore the example:


```r
dir_path <- system.file("extdata/cwl", package = "systemPipeR")
yml <- yaml::read_yaml(file.path(dir_path, "example/example.yml"))
yml
```

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
```

For the `message` and `SampleName` parameter, we are passing a variable connecting 
with a third file called `targets.` 

Now, let's explore the `targets` file structure:


```r
targetspath <- system.file("extdata/cwl/example/targets_example.txt", package = "systemPipeR")
read.delim(targetspath, comment.char = "#")
```

```
##               Message SampleName
## 1        Hello World!         M1
## 2          Hello USA!         M2
## 3 Hello Bioconductor!         M3
```

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

  - CWL command-line specification file (`wf_file` argument);
  - Input variables (`input_file` argument);
  - Targets file (`targets` argument).
    
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


```r
HW_mul <- SYSargsList(step_name = "echo", targets = targetspath, wf_file = "example/workflow_example.cwl",
    input_file = "example/example.yml", dir_path = dir_path, inputvars = c(Message = "_STRING_",
        SampleName = "_SAMPLE_"))
HW_mul
```

```
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. echo --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          1.1. echo
##              cmdlist: 3 | Pending: 3
## 
```

```r
cmdlist(HW_mul)
```

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
```



![](../../SPR_CWL_hello.png)
WConnectivity between CWL param files and targets files.

## Creating the CWL param files 

In the next two sections, we will discuss how to use `createParam` from SPR 
to create CWL param files. In `createParam`, there are two versions of syntax:

1. [version 1](../create_param_v1): pseudo-bash script format, easy to write
1. [version 2](../create_param_v2): `;` separated format, has more rules, but support 
   a lot more functionalities. 


## Contribute new CWL files to _`systemPipeR`_

_`systemPipeR`_ organizes a collection of [CWL](https://www.commonwl.org/) CommandLineTool and 
Workflow descriptions for a variety of applications, that can be 
found on Github [cwl_collection](https://github.com/systemPipeR/cwl_collection). 

If you have new cwl files would like to add to this collection, submit a 
[pull request](https://github.com/systemPipeR/cwl_collection/pulls).

After adding, new files will automatically trigger a
push to [*systemPipeRdata* (SPRdata)](https://github.com/tgirke/systemPipeRdata) 
and [*systemPipeR* (SPR)](https://github.com/tgirke/systemPipeR) repositories master branch
shortly.



---
title: "CWL syntax" 
author: "Author: Daniela Cassol (danielac@ucr.edu)"
date: "Last update: 28 October, 2021" 
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
weight: 6
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

## CWL syntax

This section will introduce how CWL describes command-line tools and the
specification and terminology of each file.
For complete documentation, please check the CommandLineTools documentation [here](https://www.commonwl.org/v1.2/CommandLineTool.html)
and [here](https://www.commonwl.org/v1.2/Workflow.html) for Workflows and the user guide [here](https://www.commonwl.org/user_guide/).

CWL command-line specifications are written in [YAML](http://yaml.org/) format.

In CWL, files with the extension `.cwl` define the parameters of a chosen
command-line step or workflow, while files with the extension `.yml` define
the input variables of command-line steps.

### CWL `CommandLineTool`

`CommandLineTool` by CWL definition is a standalone process, with no interaction
if other programs, execute a program, and produce output.

Let’s explore the `*.cwl` file:

``` r
dir_path <- system.file("extdata/cwl", package = "systemPipeR")
cwl <- yaml::read_yaml(file.path(dir_path, "example/example.cwl"))
```

-   The `cwlVersion` component shows the CWL specification version used by the document.
-   The `class` component shows this document describes a `CommandLineTool.`
    Note that CWL has another `class`, called `Workflow` which represents a union of one
    or more command-line tools together.

``` r
cwl[1:2]
```

    ## $cwlVersion
    ## [1] "v1.0"
    ## 
    ## $class
    ## [1] "CommandLineTool"

-   `baseCommand` component provides the name of the software that we desire to execute.

``` r
cwl[3]
```

    ## $baseCommand
    ## [1] "echo"

-   The `inputs` section provides the input information to run the tool. Important
    components of this section are:
    -   `id`: each input has an id describing the input name;
    -   `type`: describe the type of input value (string, int, long, float, double,
        File, Directory or Any);
    -   `inputBinding`: It is optional. This component indicates if the input
        parameter should appear on the command-line. If this component is missing
        when describing an input parameter, it will not appear in the command-line
        but can be used to build the command-line.

``` r
cwl[4]
```

    ## $inputs
    ## $inputs$message
    ## $inputs$message$type
    ## [1] "string"
    ## 
    ## $inputs$message$inputBinding
    ## $inputs$message$inputBinding$position
    ## [1] 1
    ## 
    ## 
    ## 
    ## $inputs$SampleName
    ## $inputs$SampleName$type
    ## [1] "string"
    ## 
    ## 
    ## $inputs$results_path
    ## $inputs$results_path$type
    ## [1] "Directory"

-   The `outputs` section should provide a list of the expected outputs after running the command-line tools. Important
    components of this section are:
    -   `id`: each input has an id describing the output name;
    -   `type`: describe the type of output value (string, int, long, float, double,
        File, Directory, Any or `stdout`);
    -   `outputBinding`: This component defines how to set the outputs values. The `glob` component will define the name of the output value.

``` r
cwl[5]
```

    ## $outputs
    ## $outputs$string
    ## $outputs$string$type
    ## [1] "stdout"

-   `stdout`: component to specify a `filename` to capture standard output.
    Note here we are using a syntax that takes advantage of the inputs section,
    using results\_path parameter and also the `SampleName` to construct the output `filename.`

``` r
cwl[6]
```

    ## $stdout
    ## [1] "$(inputs.results_path.basename)/$(inputs.SampleName).txt"

### CWL `Workflow`

`Workflow` class in CWL is defined by multiple process steps, where can have
interdependencies between the steps, and the output for one step can be used as
input in the further steps.

``` r
cwl.wf <- yaml::read_yaml(file.path(dir_path, "example/workflow_example.cwl"))
```

-   The `cwlVersion` component shows the CWL specification version used by the document.
-   The `class` component shows this document describes a `Workflow`.

``` r
cwl.wf[1:2]
```

    ## $class
    ## [1] "Workflow"
    ## 
    ## $cwlVersion
    ## [1] "v1.0"

-   The `inputs` section describes the inputs of the workflow.

``` r
cwl.wf[3]
```

    ## $inputs
    ## $inputs$message
    ## [1] "string"
    ## 
    ## $inputs$SampleName
    ## [1] "string"
    ## 
    ## $inputs$results_path
    ## [1] "Directory"

-   The `outputs` section describes the outputs of the workflow.

``` r
cwl.wf[4]
```

    ## $outputs
    ## $outputs$string
    ## $outputs$string$outputSource
    ## [1] "echo/string"
    ## 
    ## $outputs$string$type
    ## [1] "stdout"

-   The `steps` section describes the steps of the workflow. In this simple example,
    we demonstrate one step.

``` r
cwl.wf[5]
```

    ## $steps
    ## $steps$echo
    ## $steps$echo$`in`
    ## $steps$echo$`in`$message
    ## [1] "message"
    ## 
    ## $steps$echo$`in`$SampleName
    ## [1] "SampleName"
    ## 
    ## $steps$echo$`in`$results_path
    ## [1] "results_path"
    ## 
    ## 
    ## $steps$echo$out
    ## [1] "[string]"
    ## 
    ## $steps$echo$run
    ## [1] "example/example.cwl"

### CWL Input Parameter

Next, let’s explore the *.yml* file, which provide the input parameter values for all
the components we describe above.

For this simple example, we have three parameters defined:

``` r
yaml::read_yaml(file.path(dir_path, "example/example_single.yml"))
```

    ## $message
    ## [1] "Hello World!"
    ## 
    ## $SampleName
    ## [1] "M1"
    ## 
    ## $results_path
    ## $results_path$class
    ## [1] "Directory"
    ## 
    ## $results_path$path
    ## [1] "./results"

Note that if we define an input component in the *.cwl* file, this value needs
to be also defined here in the *.yml* file.

### Reference

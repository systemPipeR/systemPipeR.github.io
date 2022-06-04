---
title: "Design and run Workflows" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 03 June, 2022" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeR: Workflow design and reporting generation environment}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex.bib
editor_options: 
  chunk_output_type: console
type: docs
weight: 3
---

<!--
- Compile from command-line
Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeR.Rmd', tangle=TRUE)"; Rscript ../md2jekyll.R systemPipeR.knit.md 2; Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::pdf_document'))"
-->
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

# About this section

In this section, we will discuss following topics:

-   How to create SPR data analysis projects.
-   How to build workflow step by step interactively or use use a template as starting point.
-   After step design, how to run a workflow.
-   After workflow finished running, how we can check the status, visualize the workflow.
-   Different options for managing the workflow, *e.g.* resume, restart, overwrite a
    SPR project.
-   How to explore the workflow object (methods).
-   Finally, how to generate some data analysis reports.

# Project initialization

To create a workflow within *`systemPipeR`*, we can start by defining an empty
container and checking the directory structure:

``` r
sal <- SPRproject()
```

    ## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/data 
    ## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/param 
    ## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/results 
    ## Creating directory '/home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/.SPRproject'
    ## Creating file '/home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/.SPRproject/SYSargsList.yml'

Internally, `SPRproject` function will create a hidden folder called `.SPRproject`,
by default, to store all the log files.
A `YAML` file, here called `SYSargsList.yml`, has been created, which initially
contains the basic location of the project structure; however, every time the
workflow object `sal` is updated in R, the new information will also be store in this
flat-file database for easy recovery.
If you desire different names for the logs folder and the `YAML` file, these can
be modified as follows:

``` r
sal <- SPRproject(logs.dir = ".SPRproject", sys.file = ".SPRproject/SYSargsList.yml")
```

Also, this function will check and/or create the basic folder structure if missing,
which means `data`, `param`, and `results` folder, as described [here](https://systempipe.org/sp/spr/gettingstarted/#directory-structure).
If the user wants to use a different names for these directories, can be specified
as follows:

``` r
sal <- SPRproject(data = "data", param = "param", results = "results")
```

It is possible to separate all the R objects created within the workflow analysis
from the current environment. `SPRproject` function provides the option to create
a new environment, and in this way, it is not overwriting any object you may want
to have at your current section.

``` r
sal <- SPRproject(envir = new.env())
```

In this stage, the object `sal` is a empty container, except for the project information. The project information can be accessed by the `projectInfo` method:

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##  No workflow steps added

``` r
projectInfo(sal)
```

    ## $project
    ## [1] "/home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run"
    ## 
    ## $data
    ## [1] "data"
    ## 
    ## $param
    ## [1] "param"
    ## 
    ## $results
    ## [1] "results"
    ## 
    ## $logsDir
    ## [1] ".SPRproject"
    ## 
    ## $sysargslist
    ## [1] ".SPRproject/SYSargsList.yml"

Also, the `length` function will return how many steps this workflow contains,
and in this case, it is empty, as follow:

``` r
length(sal)
```

    ## [1] 0

# Workflow Design

*`systemPipeR`* workflows can be designed and built from start to finish with a single command, importing from an R Markdown file or stepwise in interactive mode from the R console.
In the [next section](#appendstep), we will demonstrate how to build the workflow in an interactive mode, and in the [following section](#importWF), we will show how to build from a file.

New workflows are constructed, or existing ones modified, by connecting each step
via `appendStep` method. Each `SYSargsList` instance contains instructions needed
for processing a set of input files with a specific command-line and the paths to
the corresponding outfiles generated.

The constructor function `Linewise` is used to build the R code-based step.
For more details about this S4 class container, see [here](#linewise).

## Build workflow interactive

This tutorial shows a straightforward example for describing and explaining all main features available within systemPipeR to design, build, manage, run, and visualize the workflow. In summary, we are exporting a dataset to multiple files, compressing and decompressing each one of the files, importing to R, and finally performing a statistical analysis.

In the previous section, we initialize the project by building the `sal` object.
Until this moment, the container has no steps:

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##  No workflow steps added

In the next subsection, we will discuss how to populate the object created with the first step in the
workflow interactively.

## Subsections

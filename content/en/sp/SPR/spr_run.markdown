---
title: "How to run a Workflow" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 22 February, 2021" 
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

# How to run a Workflow

This tutorial introduces the basic ideas and tools needed to build a specific workflow from preconfigured templates.

## Load sample data and workflow templates

``` r
library(systemPipeRdata)
genWorkenvir(workflow = "rnaseq")
setwd("rnaseq")
```

## Setup and Requirements

To go through this tutorial, you need the following software installed:

-   R/&gt;=3.6.2
-   systemPipeR R package (version 1.22)
-   Hisat2/2.1.0

If you desire to build your pipeline with any different software, make sure to have the respective software installed and configured in your PATH. To make sure if the configuration is right, you always can test as follow:

``` r
tryCL(command = "hisat2")  ## 'All set up, proceed!'
```

## Project Initialization

The Project management structure is essential, especially for reproducibility and efficiency in the analysis. Here we show how to construct an instance of this S4 object class by the *`initWF`* function. The object of class *`SYSarsgsList`* storing all the configuration information for the project and allows management and control at a high level.

``` r
script <- "systemPipeRNAseq.Rmd"
targetspath <- "targets.txt"
sysargslist <- initWF(script = script, targets = targetspath)
```

## Project Initialization in a Temporary Directory

``` r
library(systemPipeRdata)
script <- system.file("extdata/workflows/rnaseq", "systemPipeRNAseq.Rmd", package = "systemPipeRdata")
targets <- system.file("extdata", "targets.txt", package = "systemPipeR")
dir_path <- tempdir()
SYSconfig <- initProject(projPath = dir_path, targets = targets, script = script, 
    overwrite = TRUE)
sysargslist_temp <- initWF(sysconfig = "SYSconfig.yml")
```

## Configuration and run of the project

``` r
sysargslist <- configWF(x = sysargslist, input_steps = "1:3")
sysargslist <- runWF(sysargslist = sysargslist, steps = "ALL")
sysargslist <- runWF(sysargslist = sysargslist, steps = "1:2")
```

## How to Use Pipes with *systemPipeR*

At first encounter, you may wonder whether an operator such as *%&gt;%* can really be all that beneficial; but as you may notice, it semantically changes your code in a way that makes it more intuitive to both read and write.

Consider the following example, in which the steps are the initialization, configuration and running the entire workflow.

``` r
library(systemPipeR)
sysargslist <- initWF(script = "systemPipeRNAseq.Rmd", overwrite = T) %>% configWF(input_steps = "1:3") %>% 
    runWF(steps = "1:2")
```

## How to run the workflow on a cluster

This section of the tutorial provides an introduction to the usage of the *systemPipeR* features on a cluster.

Now open the R markdown script `*.Rmd`in your R IDE (\_e.g.\_vim-r or RStudio) and run the workflow as outlined below. If you work under Vim-R-Tmux, the following command sequence will connect the user in an
interactive session with a node on the cluster. The code of the `Rmd`
script can then be sent from Vim on the login (head) node to an open R session running
on the corresponding computer node. This is important since Tmux sessions
should not be run on the computer nodes.

``` r
q("no")  # closes R session on head node
```

``` bash
srun --x11 --partition=short --mem=2gb --cpus-per-task 4 --ntasks 1 --time 2:00:00 --pty bash -l
module load R/3.4.2
R
```

Now check whether your R session is running on a computer node of the cluster and not on a head node.

``` r
system("hostname")  # should return name of a compute node starting with i or c 
getwd()  # checks current working directory of R session
dir()  # returns content of current working directory
```

### Parallelization on clusters

Alternatively, the computation can be greatly accelerated by processing many files
in parallel using several compute nodes of a cluster, where a scheduling/queuing
system is used for load balancing. For this the *`clusterRun`* function submits
the computing requests to the scheduler using the run specifications
defined by *`runCommandline`*.

To avoid over-subscription of CPU cores on the compute nodes, the value from
*`yamlinput(args)['thread']`* is passed on to the submission command, here *`ncpus`*
in the *`resources`* list object. The number of independent parallel cluster
processes is defined under the *`Njobs`* argument. The following example will run
18 processes in parallel using for each 4 CPU cores. If the resources available
on a cluster allow running all 18 processes at the same time then the shown sample
submission will utilize in total 72 CPU cores. Note, *`clusterRun`* can be used
with most queueing systems as it is based on utilities from the *`batchtools`*
package which supports the use of template files (*`*.tmpl`*) for defining the
run parameters of different schedulers. To run the following code, one needs to
have both a conf file (see *`.batchtools.conf.R`* samples [here](https://mllg.github.io/batchtools/))
and a template file (see *`*.tmpl`* samples [here](https://github.com/mllg/batchtools/tree/master/inst/templates))
for the queueing available on a system. The following example uses the sample
conf and template files for the Slurm scheduler provided by this package.

``` r
library(batchtools)
resources <- list(walltime = 120, ntasks = 1, ncpus = 4, memory = 1024)
reg <- clusterRun(args, FUN = runCommandline, more.args = list(args = args, make_bam = TRUE, 
    dir = FALSE), conffile = ".batchtools.conf.R", template = "batchtools.slurm.tmpl", 
    Njobs = 18, runid = "01", resourceList = resources)
getStatus(reg = reg)
waitForJobs(reg = reg)
```

# References

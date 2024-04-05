---
title: "How to install systemPipe Workflows" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 05 April, 2024" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{WF: Workflow Template}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
editor_options: 
  chunk_output_type: console
type: docs
---



## Starting with pre-configured stable workflow templates

To test workflows quickly or design new ones from existing templates, users can
generate with a single command workflow instances fully populated with sample data 
and parameter files required for running a chosen workflow.

Load one of the available workflows into your current working directory. 
The following does this for the _`varseq`_ workflow template. The name of the resulting 
workflow directory can be specified under the _`mydirname`_ argument. The default _`NULL`_ 
uses the name of the chosen workflow. An error is issued if a directory of the same 
name and path exists already. 


```r
library("systemPipeRdata") 
genWorkenvir(workflow="systemPipeR/SPvarseq", mydirname=NULL)
setwd("varseq")
```

On Linux and OS X systems the same can be achieved from the command-line of a terminal with the following commands.


```bash
$ Rscript -e "systemPipeRdata::genWorkenvir(workflow='systemPipeR/SPvarseq', mydirname=NULL)"
```

## Check availability of workflow templates 

A collection of workflow templates are available, and it is possible to browse the 
current availability, as follows:


```r
availableWF()
```

```
## Available Workflow Templates in systemPipeRdata:
## Name         Description
## ------------------------------------
## chipseq      ChIP-seq
## new          New Empty Workflow
## riboseq      Ribosome Profiling
## rnaseq       RNA-seq
## SPblast      BLAST
## SPcheminfo   Chemical Informatics
## SPscrna      Single-cell RNA-seq
## varseq       Variant Calling
```


In addition, one can check experimental workflows available in the Github 
Organization [systemPipeR](https://github.com/systemPipeR) as follows:


```r
availableWF(github = TRUE)
```

```
## Checking templates in systemPipeR GitHub, please wait ...
## Available Workflow Templates in systemPipeRdata:
## Name         Description
## ------------------------------------
## chipseq      ChIP-seq
## new          New Empty Workflow
## riboseq      Ribosome Profiling
## rnaseq       RNA-seq
## SPblast      BLAST
## SPcheminfo   Chemical Informatics
## SPscrna      Single-cell RNA-seq
## varseq       Variant Calling
## Experimental Workflow Templates in systemPipeR GitHub Organization:
##        Workflow                                     Download URL
## 1     SPatacseq     https://github.com/systemPipeR/SPatacseq.git
## 2     SPclipseq     https://github.com/systemPipeR/SPclipseq.git
## 3      SPdenovo      https://github.com/systemPipeR/SPdenovo.git
## 4         SPhic         https://github.com/systemPipeR/SPhic.git
## 5   SPmetatrans   https://github.com/systemPipeR/SPmetatrans.git
## 6   SPmethylseq   https://github.com/systemPipeR/SPmethylseq.git
## 7    SPmirnaseq    https://github.com/systemPipeR/SPmirnaseq.git
## 8 SPpolyriboseq https://github.com/systemPipeR/SPpolyriboseq.git
## ------------------------------------
## To install a workflow template from GitHub, use:
## git clone <URL>
## e.g. git clone https://github.com/systemPipeR/SPatacseq.git
```

Installation of experimental workflows can done by `git clone` the repository.
```bash
git clone <URL FROM THE TABLE ABOVE>
cd <REPO_NAME>
```

After the installation, start the SPR project as others.

```r
library(systemPipeR)
sal <- SPRproject()
sal <- importWF(sal, file_path = "workflow_name.Rmd")
```

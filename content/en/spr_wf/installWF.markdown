---
title: "How to install systemPipe Workflows" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 12 April, 2021" 
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



## Starting with pre-configured workflow templates

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
availableWF(github = TRUE)
```

```
## $systemPipeRdata
## [1] "chipseq" "new"     "riboseq" "rnaseq"  "varseq" 
## 
## $github
##                  workflow                       branches version
## 1   systemPipeR/SPchipseq                         master release
## 2   systemPipeR/SPriboseq                         master release
## 3    systemPipeR/SPrnaseq cluster, master, singleMachine release
## 4    systemPipeR/SPvarseq                         master release
## 5   systemPipeR/SPclipseq                         master   devel
## 6    systemPipeR/SPdenovo                         master   devel
## 7 systemPipeR/SPmetatrans                         master   devel
## 8 systemPipeR/SPmethylseq                         master   devel
## 9  systemPipeR/SPmirnaseq                         master   devel
##                                         html       description
## 1   https://github.com/systemPipeR/SPchipseq Workflow Template
## 2   https://github.com/systemPipeR/SPriboseq Workflow Template
## 3    https://github.com/systemPipeR/SPrnaseq Workflow Template
## 4    https://github.com/systemPipeR/SPvarseq Workflow Template
## 5   https://github.com/systemPipeR/SPclipseq Workflow Template
## 6    https://github.com/systemPipeR/SPdenovo Workflow Template
## 7 https://github.com/systemPipeR/SPmetatrans Workflow Template
## 8 https://github.com/systemPipeR/SPmethylseq Workflow Template
## 9  https://github.com/systemPipeR/SPmirnaseq Workflow Template
```

This function returns the list of workflow templates available within the package 
and [systemPipeR Project Organization](https://github.com/systemPipeR) on GitHub. Each one 
listed template can be created as described above. 

The workflow template choose from Github will be installed as an R package, and 
also it creates an environment with all the settings and files to run the demo analysis.


```r
genWorkenvir(workflow="systemPipeR/SPrnaseq", mydirname="NULL")
setwd("systemPipeVARseq")
```

Besides, it is possible to choose different versions of the workflow template, 
defined through other branches on the GitHub Repository. By default, the _`master`_ 
branch is selected, however, it is possible to define a different branch with the _`ref`_ argument. 


```r
genWorkenvir(workflow="systemPipeR/SPrnaseq", ref = "singleMachine")
setwd("systemPipeRNAseq")
```

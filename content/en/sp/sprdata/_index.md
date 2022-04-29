---
title: "systemPipeRdata"
linkTitle: "systemPipeRdata"
weight: 3
type: docs
---

{{% pageinfo %}}
Find [here](https://systempipe.org/spr/systempiperdata/vignette/) all the documentation!
{{% /pageinfo %}}

# systemPipeRdata: Workflow templates and sample data

[_`systemPipeRdata`_](https://github.com/tgirke/systemPipeRdata) is a helper package 
to generate with a single command  workflow templates that are intended to be 
used by its parent package [_`systemPipeR`_](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html). 
The *systemPipeR* project provides a suite of R/Bioconductor packages for designing,
building and running end-to-end analysis workflows on local machines, HPC clusters 
and cloud systems, while generating at the same time publication quality analysis reports.

To test workflows quickly or design new ones from existing templates, users can
generate with a single command workflow instances fully populated with sample data 
and parameter files required for running a chosen workflow.
Pre-configured directory structure of the workflow environment and the sample data 
used by _`systemPipeRdata`_ are described [here](http://bioconductor.org/packages/release/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#load-sample-data-and-workflow-templates).

## Installation 

To install the package, please use the _`BiocManager::install`_ command:
```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("systemPipeRdata")
```

To obtain the most recent updates immediately, one can install it directly from
github as follow:
```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("tgirke/systemPipeRdata", build_vignettes=TRUE, dependencies=TRUE)
```

Due to the large size of the sample data (~320 MB) provided by _systemPipeRdata_, its download/install may take some time.

To install the parent package _systemPipeR_ itself, please use the _BiocManager::install_ method as instructed
[_here_](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html).

### Usage

Detailed user manuals are available here: 

+ [_systemPipeRdata_ Vignette](http://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRdata.html)
+ [_systemPipeR_ Overview Vignette](http://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html)

<iframe width="900" height="600" src="https://systempipe.org/presentations/sprdata/SPRdata.html#1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


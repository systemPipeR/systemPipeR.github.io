---
title: "Workflow templates and sample data"
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 05 May, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeRdata
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeRdata: Workflow templates and sample data}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex.bib
type: docs
weight: 1
---

<style type="text/css">
pre code {
white-space: pre !important;
overflow-x: scroll !important;
word-break: keep-all !important;
word-wrap: initial !important;
}
</style>
<!---
- Compile from command-line
Rscript -e "rmarkdown::render('systemPipeRdata.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeRdata.Rmd', tangle=TRUE)"; Rscript -e "rmarkdown::render('systemPipeRdata.Rmd', c('BiocStyle::pdf_document'))"
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

**Note:** the most recent version of this vignette can be found <a href="https://github.com/tgirke/systemPipeRdata/blob/master/vignettes/systemPipeRdata.Rmd">here</a>.

**Note:** if you use *`systemPipeR`* and *`systemPipeRdata`* in published research, please cite:

Backman, T.W.H and Girke, T. (2016). *systemPipeR*: Workflow and Report Generation Environment. *BMC Bioinformatics*, 17: 388. [10.1186/s12859-016-1241-0](https://doi.org/10.1186/s12859-016-1241-0).

# Introduction

[*`systemPipeRdata`*](https://github.com/tgirke/systemPipeRdata) is a helper package
to generate with a single command workflow templates that are intended to be
used by its parent package [*`systemPipeR`*](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) (H Backman and Girke 2016).
The *systemPipeR* project provides a suite of R/Bioconductor packages for designing,
building and running end-to-end analysis workflows on local machines, HPC clusters
and cloud systems, while generating at the same time publication quality analysis reports.

To test workflows quickly or design new ones from existing templates, users can
generate with a single command workflow instances fully populated with sample data
and parameter files required for running a chosen workflow.
Pre-configured directory structure of the workflow environment and the sample data
used by *`systemPipeRdata`* are described [here](http://bioconductor.org/packages/release/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#load-sample-data-and-workflow-templates).

# Getting started

## Installation

The *`systemPipeRdata`* package is available at [Bioconductor](http://www.bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html) and can be installed from within R as follows:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("systemPipeRdata")
```

Also, it is possible to install the development version from [Bioconductor](http://www.bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html).

``` r
BiocManager::install("systemPipeRdata", version = "devel", build_vignettes = TRUE, 
    dependencies = TRUE)  # Installs Devel version from Bioconductor
```

## Loading package and documentation

``` r
library("systemPipeRdata")  # Loads the package
```

``` r
library(help = "systemPipeRdata")  # Lists package info
vignette("systemPipeRdata")  # Opens vignette
```

## Starting with pre-configured workflow templates

Load one of the available workflows into your current working directory.
The following does this for the *`varseq`* workflow template. The name of the resulting
workflow directory can be specified under the *`mydirname`* argument. The default *`NULL`*
uses the name of the chosen workflow. An error is issued if a directory of the same
name and path exists already.

``` r
genWorkenvir(workflow = "systemPipeR/SPvarseq", mydirname = "varseq")
setwd("varseq")
```

On Linux and OS X systems the same can be achieved from the command-line of a terminal with the following commands.

``` bash
$ Rscript -e "systemPipeRdata::genWorkenvir(workflow='systemPipeR/SPvarseq', mydirname='varseq')"
```

# Workflow templates collection

A collection of workflow templates are available, and it is possible to browse the
current availability, as follows:

``` r
availableWF(github = TRUE)
```

This function returns the list of workflow templates available within the package
and [systemPipeR Organization](https://github.com/systemPipeR) on GitHub. Each one
listed template can be created as described above.

The workflow template choose from Github will be installed as an R package, and
also it creates the environment with all the settings and files to run the demo
analysis.

``` r
genWorkenvir(workflow="systemPipeR/SPrnaseq", mydirname="NULL")
setwd("SPrnaseq")
```

Besides, it is possible to choose different versions of the workflow template,
defined through other branches on the GitHub Repository. By default, the *`master`*
branch is selected, however, it is possible to define a different branch with the *`ref`* argument.

``` r
genWorkenvir(workflow="systemPipeR/SPrnaseq", ref = "singleMachine")
setwd("SPrnaseq")
```

## Download a specific R Markdown file

Also, it is possible to download a specific workflow script for your analysis.
The URL can be specified under *`url`* argument and the R Markdown file name in
the *`urlname`* argument. The default *`NULL`* copies the current version available in the chose template.

``` r
genWorkenvir(workflow="systemPipeR/SPrnaseq", url = "https://raw.githubusercontent.com/systemPipeR/systemPipeRNAseq/cluster/vignettes/systemPipeRNAseq.Rmd", 
             urlname = "rnaseq_V-cluster.Rmd")
setwd("rnaseq")
```

# Dynamic generation of workflow template

It is possible to create a new workflow structure from RStudio
menu `File -> New File -> R Markdown -> From Template -> systemPipeR New WorkFlow`.
This interactive option creates the same environment as demonstrated above.

![](results/rstudio.png)
**Figure 1:** Selecting workflow template within RStudio.

# Directory Structure

The workflow templates generated by *`genWorkenvir`* contain the following preconfigured directory structure:

-   <span style="color:green">***workflow/***</span> (*e.g.* *rnaseq/*)
    -   This is the root directory of the R session running the workflow.
    -   Run script ( *\*.Rmd*) and sample annotation (*targets.txt*) files are located here.
    -   Note, this directory can have any name (*e.g.* <span style="color:green">***rnaseq***</span>, <span style="color:green">***varseq***</span>). Changing its name does not require any modifications in the run script(s).
    -   **Important subdirectories**:
        -   <span style="color:green">***param/***</span>
            -   Stores non-CWL parameter files such as: *\*.param*, *\*.tmpl* and *\*.run.sh*. These files are only required for backwards compatibility to run old workflows using the previous custom command-line interface.
            -   <span style="color:green">***param/cwl/***</span>: This subdirectory stores all the CWL parameter files. To organize workflows, each can have its own subdirectory, where all `CWL param` and `input.yml` files need to be in the same subdirectory.
        -   <span style="color:green">***data/*** </span>
            -   FASTQ files
            -   FASTA file of reference (*e.g.* reference genome)
            -   Annotation files
            -   etc.
        -   <span style="color:green">***results/***</span>
            -   Analysis results are usually written to this directory, including: alignment, variant and peak files (BAM, VCF, BED); tabular result files; and image/plot files
            -   Note, the user has the option to organize results files for a given sample and analysis step in a separate subdirectory.

**Note**: Directory names are indicated in <span style="color:grey">***green***</span>.
Users can change this structure as needed, but need to adjust the code in their workflows
accordingly.

<center>
<img src="results/directory.png">
</center>

**Figure 2:** *systemPipeR’s* preconfigured directory structure.

# Run workflows

Next, run from within R the chosen sample workflow by executing the code provided
in the corresponding *`*.Rmd`* template file.
Much more detailed information on running and customizing [*`systemPipeR`*](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html)
workflows is available in its overview vignette [here](http://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html).
This vignette can also be opened from R with the following command.

``` r
library("systemPipeR")  # Loads systemPipeR which needs to be installed via BiocManager::install() from Bioconductor
```

``` r
vignette("systemPipeR", package = "systemPipeR")
```

## Return paths to sample data

The location of the sample data provided by *`systemPipeRdata`* can be returned as a *`list`*.

``` r
pathList()
```

    ## $targets
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/param/targets.txt"
    ## 
    ## $targetsPE
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/param/targetsPE.txt"
    ## 
    ## $annotationdir
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/annotation/"
    ## 
    ## $fastqdir
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/fastq/"
    ## 
    ## $bamdir
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/bam/"
    ## 
    ## $paramdir
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/param/"
    ## 
    ## $workflows
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/workflows/"
    ## 
    ## $chipseq
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/workflows/chipseq/"
    ## 
    ## $rnaseq
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/workflows/rnaseq/"
    ## 
    ## $riboseq
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/workflows/riboseq/"
    ## 
    ## $varseq
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/workflows/varseq/"
    ## 
    ## $new
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/workflows/new/"

# Version information

``` r
sessionInfo()
```

    ## R Under development (unstable) (2021-02-04 r79940)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.2 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
    ## LAPACK: /home/dcassol/src/R-devel/lib/libRlapack.so
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets 
    ## [6] methods   base     
    ## 
    ## other attached packages:
    ## [1] systemPipeRdata_1.19.2 BiocStyle_2.19.2      
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] knitr_1.33          magrittr_2.0.1     
    ##  [3] BiocGenerics_0.37.4 R6_2.5.0           
    ##  [5] rlang_0.4.11        stringr_1.4.0      
    ##  [7] tools_4.1.0         parallel_4.1.0     
    ##  [9] xfun_0.22           jquerylib_0.1.4    
    ## [11] htmltools_0.5.1.1   remotes_2.3.0      
    ## [13] yaml_2.2.1          digest_0.6.27      
    ## [15] bookdown_0.22       formatR_1.9        
    ## [17] BiocManager_1.30.12 sass_0.3.1         
    ## [19] codetools_0.2-18    evaluate_0.14      
    ## [21] rmarkdown_2.7.12    blogdown_1.3       
    ## [23] stringi_1.5.3       compiler_4.1.0     
    ## [25] bslib_0.2.4         jsonlite_1.7.2

# Funding

This project was supported by funds from the National Institutes of Health (NIH) and the National Science Foundation (NSF).

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-H_Backman2016-bt" class="csl-entry">

H Backman, Tyler W, and Thomas Girke. 2016. “<span class="nocase">systemPipeR: NGS workflow and report generation environment</span>.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

</div>

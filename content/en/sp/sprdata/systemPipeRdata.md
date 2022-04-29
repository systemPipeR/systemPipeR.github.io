---
title: "Workflow templates and sample data"
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 29 April, 2022" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
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
Rscript -e "rmarkdown::render('systemPipeRdata.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeRdata.Rmd', tangle=TRUE)"

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

*`systemPipeRdata`* package provides a demo sample FASTQ files used in the
workflow reporting vignettes. The chosen data set [`SRP010938`](http://www.ncbi.nlm.nih.gov/sra/?term=SRP010938) obtains 18
paired-end (PE) read sets from *Arabidposis thaliana* (Howard et al. 2013). To
minimize processing time during testing, each FASTQ file has been subsetted to
90,000-100,000 randomly sampled PE reads that map to the first 100,000
nucleotides of each chromosome of the *A. thalina* genome. The corresponding
reference genome sequence (FASTA) and its GFF annotation files (provided in the
same download) have been truncated accordingly. This way the entire test sample
data set requires less than 200MB disk storage space. A PE read set has been
chosen for this test data set for flexibility, because it can be used for
testing both types of analysis routines requiring either SE (single-end) reads
or PE reads.

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

# Starting with pre-configured workflow templates

Load one of the available workflows into your current working directory.
The following does this for the *`rnaseq`* workflow template. The name of the resulting
workflow directory can be specified under the *`mydirname`* argument. The default *`NULL`*
uses the name of the chosen workflow. An error is issued if a directory of the same
name and path exists already.

``` r
genWorkenvir(workflow = "systemPipeR/SPrnaseq", mydirname = "rnaseq")
setwd("rnaseq")
```

On Linux and OS X systems the same can be achieved from the command-line of a terminal with the following commands.

``` bash
$ Rscript -e "systemPipeRdata::genWorkenvir(workflow='systemPipeR/SPrnaseq', mydirname='rnaseq')"
```

## Build, run and visualize the workflow template

-   Build workflow from RMarkdown file

This template provides some common steps for a `RNAseq` workflow. One can add, remove, modify
workflow steps by operating on the `sal` object.

``` r
sal <- SPRproject()
sal <- importWF(sal, file_path = "systemPipeVARseq.Rmd", verbose = FALSE)
```

-   Running workflow

Next, we can run the entire workflow from R with one command:

``` r
sal <- runWF(sal)
```

-   Visualize workflow

*`systemPipeR`* workflows instances can be visualized with the `plotWF` function.

``` r
plotWF(sal)
```

-   Report generation

*`systemPipeR`* compiles all the workflow execution logs in one central location,
making it easier to check any standard output (`stdout`) or standard error
(`stderr`) for any command-line tools used on the workflow or the R code stdout.

``` r
sal <- renderLogs(sal)
```

Also, the technical report can be generated using `renderReport` function.

``` r
sal <- renderReport(sal)
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

## Return paths to sample data

The location of the sample data provided by *`systemPipeRdata`* can be returned as a *`list`*.

``` r
pathList()[1:2]
```

    ## $targets
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/param/targets.txt"
    ## 
    ## $targetsPE
    ## [1] "/home/dcassol/src/R-devel/library/systemPipeRdata/extdata/param/targetsPE.txt"

# Version information

``` r
sessionInfo()
```

    ## R Under development (unstable) (2021-10-25 r81105)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
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
    ## [1] systemPipeRdata_1.22.3 BiocStyle_2.23.1      
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] bslib_0.3.1            compiler_4.2.0        
    ##  [3] BiocManager_1.30.17    formatR_1.12          
    ##  [5] jquerylib_0.1.4        GenomeInfoDb_1.32.0   
    ##  [7] XVector_0.36.0         bitops_1.0-7          
    ##  [9] remotes_2.4.2          tools_4.2.0           
    ## [11] zlibbioc_1.42.0        digest_0.6.29         
    ## [13] jsonlite_1.8.0         evaluate_0.15         
    ## [15] rlang_1.0.2            cli_3.3.0             
    ## [17] rstudioapi_0.13        yaml_2.3.5            
    ## [19] blogdown_1.9           xfun_0.30             
    ## [21] fastmap_1.1.0          GenomeInfoDbData_1.2.8
    ## [23] stringr_1.4.0          knitr_1.38            
    ## [25] Biostrings_2.64.0      sass_0.4.1            
    ## [27] S4Vectors_0.34.0       IRanges_2.30.0        
    ## [29] stats4_4.2.0           R6_2.5.1              
    ## [31] rmarkdown_2.14         bookdown_0.26         
    ## [33] magrittr_2.0.3         codetools_0.2-18      
    ## [35] htmltools_0.5.2        BiocGenerics_0.42.0   
    ## [37] stringi_1.7.6          RCurl_1.98-1.6        
    ## [39] crayon_1.5.1

# Funding

This project was supported by funds from the National Institutes of Health (NIH) and the National Science Foundation (NSF).

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-H_Backman2016-bt" class="csl-entry">

H Backman, Tyler W, and Thomas Girke. 2016. “<span class="nocase">systemPipeR: NGS workflow and report generation environment</span>.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

<div id="ref-Howard2013-fq" class="csl-entry">

Howard, Brian E, Qiwen Hu, Ahmet Can Babaoglu, Manan Chandra, Monica Borghi, Xiaoping Tan, Luyan He, et al. 2013. “High-Throughput RNA Sequencing of Pseudomonas-Infected Arabidopsis Reveals Hidden Transcriptome Complexity and Novel Splice Variants.” *PLoS One* 8 (10): e74183. <https://doi.org/10.1371/journal.pone.0074183>.

</div>

</div>

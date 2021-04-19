---
title: "Workflow templates and sample data"
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 18 April, 2021" 
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

<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/datatables-binding/datatables.js"></script>
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.min.css" rel="stylesheet" />
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.extra.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-core/js/jquery.dataTables.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-fixedcolumns/css/fixedColumns.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-fixedcolumns/js/dataTables.fixedColumns.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-scroller/css/scroller.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-scroller/js/dataTables.scroller.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/datatables-binding/datatables.js"></script>
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.min.css" rel="stylesheet" />
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.extra.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-core/js/jquery.dataTables.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-fixedcolumns/css/fixedColumns.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-fixedcolumns/js/dataTables.fixedColumns.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-scroller/css/scroller.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-scroller/js/dataTables.scroller.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
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

# Create a small RNA-seq Data

## Download NCBI data

The chosen data set [`SRP010938`](http://www.ncbi.nlm.nih.gov/sra/?term=SRP010938)
obtains 18 paired-end (PE) read sets from *Arabidposis thaliana* (Howard et al. 2013).

``` r
## https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP010938&o=acc_s%3Aa
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
targets <- read.delim(targetspath, comment.char = "#")
systemPipeR::showDT(targets)
```

<div id="htmlwidget-1" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"filter":"none","extensions":["FixedColumns","Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["./data/SRR446027_1.fastq.gz","./data/SRR446028_1.fastq.gz","./data/SRR446029_1.fastq.gz","./data/SRR446030_1.fastq.gz","./data/SRR446031_1.fastq.gz","./data/SRR446032_1.fastq.gz","./data/SRR446033_1.fastq.gz","./data/SRR446034_1.fastq.gz","./data/SRR446035_1.fastq.gz","./data/SRR446036_1.fastq.gz","./data/SRR446037_1.fastq.gz","./data/SRR446038_1.fastq.gz","./data/SRR446039_1.fastq.gz","./data/SRR446040_1.fastq.gz","./data/SRR446041_1.fastq.gz","./data/SRR446042_1.fastq.gz","./data/SRR446043_1.fastq.gz","./data/SRR446044_1.fastq.gz"],["./data/SRR446027_2.fastq.gz","./data/SRR446028_2.fastq.gz","./data/SRR446029_2.fastq.gz","./data/SRR446030_2.fastq.gz","./data/SRR446031_2.fastq.gz","./data/SRR446032_2.fastq.gz","./data/SRR446033_2.fastq.gz","./data/SRR446034_2.fastq.gz","./data/SRR446035_2.fastq.gz","./data/SRR446036_2.fastq.gz","./data/SRR446037_2.fastq.gz","./data/SRR446038_2.fastq.gz","./data/SRR446039_2.fastq.gz","./data/SRR446040_2.fastq.gz","./data/SRR446041_2.fastq.gz","./data/SRR446042_2.fastq.gz","./data/SRR446043_2.fastq.gz","./data/SRR446044_2.fastq.gz"],["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],["M1","M1","A1","A1","V1","V1","M6","M6","A6","A6","V6","V6","M12","M12","A12","A12","V12","V12"],["Mock.1h.A","Mock.1h.B","Avr.1h.A","Avr.1h.B","Vir.1h.A","Vir.1h.B","Mock.6h.A","Mock.6h.B","Avr.6h.A","Avr.6h.B","Vir.6h.A","Vir.6h.B","Mock.12h.A","Mock.12h.B","Avr.12h.A","Avr.12h.B","Vir.12h.A","Vir.12h.B"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],["23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>FileName1<\/th>\n      <th>FileName2<\/th>\n      <th>SampleName<\/th>\n      <th>Factor<\/th>\n      <th>SampleLong<\/th>\n      <th>Experiment<\/th>\n      <th>Date<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"columnDefs":[{"className":"dt-right","targets":6},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

``` r
## Create a SYSargs2 object and populate all the command-line
dir_path <- system.file("extdata/cwl/fastq-dump", package = "systemPipeR")
WF <- systemPipeR::loadWF(targets = targetspath, wf_file = "fastq-dump.cwl", 
    input_file = "fastq-dump.yml", dir_path = dir_path)
WF <- renderWF(WF, inputvars = c(FileName = "_FASTQ_PATH1_", 
    SampleName = "_SampleName_"))
cmdlist(WF)
output(WF)
runCommandline(WF, make_bam = FALSE)
```

## Create targets file

``` r
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
targets <- read.delim(targetspath, comment.char = "#")
systemPipeR::showDT(targets)
```

<div id="htmlwidget-2" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2">{"x":{"filter":"none","extensions":["FixedColumns","Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["./data/SRR446027_1.fastq.gz","./data/SRR446028_1.fastq.gz","./data/SRR446029_1.fastq.gz","./data/SRR446030_1.fastq.gz","./data/SRR446031_1.fastq.gz","./data/SRR446032_1.fastq.gz","./data/SRR446033_1.fastq.gz","./data/SRR446034_1.fastq.gz","./data/SRR446035_1.fastq.gz","./data/SRR446036_1.fastq.gz","./data/SRR446037_1.fastq.gz","./data/SRR446038_1.fastq.gz","./data/SRR446039_1.fastq.gz","./data/SRR446040_1.fastq.gz","./data/SRR446041_1.fastq.gz","./data/SRR446042_1.fastq.gz","./data/SRR446043_1.fastq.gz","./data/SRR446044_1.fastq.gz"],["./data/SRR446027_2.fastq.gz","./data/SRR446028_2.fastq.gz","./data/SRR446029_2.fastq.gz","./data/SRR446030_2.fastq.gz","./data/SRR446031_2.fastq.gz","./data/SRR446032_2.fastq.gz","./data/SRR446033_2.fastq.gz","./data/SRR446034_2.fastq.gz","./data/SRR446035_2.fastq.gz","./data/SRR446036_2.fastq.gz","./data/SRR446037_2.fastq.gz","./data/SRR446038_2.fastq.gz","./data/SRR446039_2.fastq.gz","./data/SRR446040_2.fastq.gz","./data/SRR446041_2.fastq.gz","./data/SRR446042_2.fastq.gz","./data/SRR446043_2.fastq.gz","./data/SRR446044_2.fastq.gz"],["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],["M1","M1","A1","A1","V1","V1","M6","M6","A6","A6","V6","V6","M12","M12","A12","A12","V12","V12"],["Mock.1h.A","Mock.1h.B","Avr.1h.A","Avr.1h.B","Vir.1h.A","Vir.1h.B","Mock.6h.A","Mock.6h.B","Avr.6h.A","Avr.6h.B","Vir.6h.A","Vir.6h.B","Mock.12h.A","Mock.12h.B","Avr.12h.A","Avr.12h.B","Vir.12h.A","Vir.12h.B"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],["23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>FileName1<\/th>\n      <th>FileName2<\/th>\n      <th>SampleName<\/th>\n      <th>Factor<\/th>\n      <th>SampleLong<\/th>\n      <th>Experiment<\/th>\n      <th>Date<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"columnDefs":[{"className":"dt-right","targets":6},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

## Mapping

Build Index:

``` r
idx <- loadWF(targets = NULL, wf_file = "hisat2-index.cwl", input_file = "hisat2-index.yml", 
    dir_path = "param/cwl/hisat2/hisat2-idx/")
idx <- renderWF(idx)
idx
cmdlist(idx)

library(batchtools)
resources <- list(walltime = 1200, ntasks = 1, ncpus = 14, memory = 20480)
reg <- clusterRun(idx, FUN = runCommandline, more.args = list(args = idx, 
    dir = FALSE, make_bam = FALSE), conffile = ".batchtools.conf.R", 
    template = "batchtools.slurm.tmpl", Njobs = 1, runid = "01", 
    resourceList = resources)
getStatus(reg = reg)
waitForJobs(reg = reg)
```

### Mapping

``` r
## Build WF
align <- loadWF(targets = targetspath, wf_file = "hisat2-mapping-pe.cwl", 
    input_file = "hisat2-mapping-pe.yml", dir_path = "param/cwl/hisat2/hisat2-pe/")
align <- renderWF(align, inputvars = c(FileName1 = "_FASTQ_PATH1_", 
    FileName2 = "_FASTQ_PATH2_", SampleName = "_SampleName_"))
align
cmdlist(align)[1:2]
output(align)[1:2]

## Run
library(batchtools)
resources <- list(walltime = 1200, ntasks = 1, ncpus = 14, memory = 20480)
reg <- clusterRun(align, FUN = runCommandline, more.args = list(args = align, 
    dir = FALSE), conffile = ".batchtools.conf.R", template = "batchtools.slurm.tmpl", 
    Njobs = 18, runid = "01", resourceList = resources)
getStatus(reg = reg)
waitForJobs(reg = reg)
align <- output_update(align, replace = TRUE, dir = FALSE, extension = c(".sam", 
    ".bam"))
```

## Subset reads by Mapping Region

To minimize processing time during testing, each FASTQ file has been subsetted to
800-900 randomly sampled PE reads that map to the first 900 nucleotides
of each chromosome of the *A. thalina* genome.

``` r
getSubsetReads(align, MappingRegion = 1:900, sample_range = 800:900, 
    outdir = "data/subset/", silent = FALSE)
```

## Subset reads by Genes List

Select genes upregulated by DEG analysis with *`DESeq2`*.

``` r
library(DESeq2)
targets <- read.delim(targetspath, comment = "#")
cmp <- readComp(file = targetspath, format = "matrix", delim = "-")
cmp[[1]]
countDFeBygpath <- system.file("extdata", "countDFeByg.xls", 
    package = "systemPipeR")
countDFeByg <- read.delim(countDFeBygpath, row.names = 1)
degseqDF <- run_DESeq2(countDF = countDFeByg, targets = targets, 
    cmp = cmp[[1]], independent = FALSE)
DEG_list <- filterDEGs(degDF = degseqDF, filter = c(Fold = 2, 
    FDR = 10))  ## filter
list <- unique(unlist(DEG_list$Up))
```

``` r
getSubsetReads(align, geneList = list, MappingRegion = NULL, 
    sample_range = NULL, outdir = "data/subset/", silent = FALSE)
```

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
    ## [1] systemPipeRdata_1.19.1 BiocStyle_2.19.2      
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] backports_1.2.1            
    ##   [2] BiocFileCache_1.99.5       
    ##   [3] plyr_1.8.6                 
    ##   [4] lazyeval_0.2.2             
    ##   [5] splines_4.1.0              
    ##   [6] crosstalk_1.1.1            
    ##   [7] BiocParallel_1.25.5        
    ##   [8] GenomeInfoDb_1.27.11       
    ##   [9] ggplot2_3.3.3              
    ##  [10] digest_0.6.27              
    ##  [11] htmltools_0.5.1.1          
    ##  [12] fansi_0.4.2                
    ##  [13] magrittr_2.0.1             
    ##  [14] checkmate_2.0.0            
    ##  [15] memoise_2.0.0              
    ##  [16] BSgenome_1.59.2            
    ##  [17] base64url_1.4              
    ##  [18] limma_3.47.12              
    ##  [19] remotes_2.3.0              
    ##  [20] Biostrings_2.59.2          
    ##  [21] annotate_1.69.2            
    ##  [22] matrixStats_0.58.0         
    ##  [23] systemPipeR_1.25.12        
    ##  [24] prettyunits_1.1.1          
    ##  [25] jpeg_0.1-8.1               
    ##  [26] colorspace_2.0-0           
    ##  [27] blob_1.2.1                 
    ##  [28] rappdirs_0.3.3             
    ##  [29] ggrepel_0.9.1              
    ##  [30] xfun_0.22                  
    ##  [31] dplyr_1.0.5                
    ##  [32] crayon_1.4.1               
    ##  [33] RCurl_1.98-1.3             
    ##  [34] jsonlite_1.7.2             
    ##  [35] genefilter_1.73.1          
    ##  [36] VariantAnnotation_1.37.1   
    ##  [37] brew_1.0-6                 
    ##  [38] survival_3.2-10            
    ##  [39] ape_5.4-1                  
    ##  [40] glue_1.4.2                 
    ##  [41] gtable_0.3.0               
    ##  [42] zlibbioc_1.37.0            
    ##  [43] XVector_0.31.1             
    ##  [44] DelayedArray_0.17.10       
    ##  [45] V8_3.4.0                   
    ##  [46] BiocGenerics_0.37.1        
    ##  [47] scales_1.1.1               
    ##  [48] pheatmap_1.0.12            
    ##  [49] DBI_1.1.1                  
    ##  [50] GGally_2.1.1               
    ##  [51] edgeR_3.33.3               
    ##  [52] Rcpp_1.0.6                 
    ##  [53] viridisLite_0.4.0          
    ##  [54] xtable_1.8-4               
    ##  [55] progress_1.2.2             
    ##  [56] tidytree_0.3.3             
    ##  [57] bit_4.0.4                  
    ##  [58] DT_0.18                    
    ##  [59] rsvg_2.1                   
    ##  [60] stats4_4.1.0               
    ##  [61] htmlwidgets_1.5.3          
    ##  [62] httr_1.4.2                 
    ##  [63] RColorBrewer_1.1-2         
    ##  [64] ellipsis_0.3.1             
    ##  [65] pkgconfig_2.0.3            
    ##  [66] reshape_0.8.8              
    ##  [67] XML_3.99-0.6               
    ##  [68] sass_0.3.1                 
    ##  [69] dbplyr_2.1.1               
    ##  [70] locfit_1.5-9.4             
    ##  [71] utf8_1.2.1                 
    ##  [72] later_1.1.0.1              
    ##  [73] tidyselect_1.1.0           
    ##  [74] rlang_0.4.10               
    ##  [75] AnnotationDbi_1.53.1       
    ##  [76] munsell_0.5.0              
    ##  [77] tools_4.1.0                
    ##  [78] cachem_1.0.4               
    ##  [79] generics_0.1.0             
    ##  [80] RSQLite_2.2.6              
    ##  [81] evaluate_0.14              
    ##  [82] stringr_1.4.0              
    ##  [83] fastmap_1.1.0              
    ##  [84] yaml_2.2.1                 
    ##  [85] ggtree_2.5.2               
    ##  [86] knitr_1.32                 
    ##  [87] bit64_4.0.5                
    ##  [88] purrr_0.3.4                
    ##  [89] KEGGREST_1.31.1            
    ##  [90] nlme_3.1-152               
    ##  [91] mime_0.10                  
    ##  [92] formatR_1.9                
    ##  [93] aplot_0.0.6                
    ##  [94] biomaRt_2.47.7             
    ##  [95] compiler_4.1.0             
    ##  [96] plotly_4.9.3               
    ##  [97] filelock_1.0.2             
    ##  [98] curl_4.3                   
    ##  [99] png_0.1-7                  
    ## [100] treeio_1.15.6              
    ## [101] tibble_3.1.0               
    ## [102] geneplotter_1.69.0         
    ## [103] bslib_0.2.4                
    ## [104] stringi_1.5.3              
    ## [105] blogdown_1.3               
    ## [106] GenomicFeatures_1.43.8     
    ## [107] lattice_0.20-41            
    ## [108] Matrix_1.3-2               
    ## [109] glmpca_0.2.0               
    ## [110] vctrs_0.3.7                
    ## [111] pillar_1.6.0               
    ## [112] lifecycle_1.0.0            
    ## [113] BiocManager_1.30.12        
    ## [114] jquerylib_0.1.3            
    ## [115] data.table_1.14.0          
    ## [116] bitops_1.0-6               
    ## [117] httpuv_1.5.5               
    ## [118] patchwork_1.1.1            
    ## [119] rtracklayer_1.51.5         
    ## [120] GenomicRanges_1.43.4       
    ## [121] latticeExtra_0.6-29        
    ## [122] hwriter_1.3.2              
    ## [123] R6_2.5.0                   
    ## [124] BiocIO_1.1.2               
    ## [125] promises_1.2.0.1           
    ## [126] ShortRead_1.49.2           
    ## [127] bookdown_0.21              
    ## [128] IRanges_2.25.8             
    ## [129] codetools_0.2-18           
    ## [130] MASS_7.3-53.1              
    ## [131] assertthat_0.2.1           
    ## [132] SummarizedExperiment_1.21.3
    ## [133] DESeq2_1.31.18             
    ## [134] rjson_0.2.20               
    ## [135] withr_2.4.1                
    ## [136] GenomicAlignments_1.27.2   
    ## [137] batchtools_0.9.15          
    ## [138] Rsamtools_2.7.2            
    ## [139] S4Vectors_0.29.15          
    ## [140] GenomeInfoDbData_1.2.4     
    ## [141] parallel_4.1.0             
    ## [142] hms_1.0.0                  
    ## [143] grid_4.1.0                 
    ## [144] tidyr_1.1.3                
    ## [145] DOT_0.1                    
    ## [146] rmarkdown_2.7              
    ## [147] rvcheck_0.1.8              
    ## [148] MatrixGenerics_1.3.1       
    ## [149] Rtsne_0.15                 
    ## [150] shiny_1.6.0                
    ## [151] Biobase_2.51.0             
    ## [152] restfulr_0.0.13

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

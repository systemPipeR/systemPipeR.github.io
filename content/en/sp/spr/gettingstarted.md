---
title: "Getting Started" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 28 October, 2021" 
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
weight: 2
---

<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<link href="/rmarkdown-libs/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/datatables-binding/datatables.js"></script>
<script src="/rmarkdown-libs/jquery/jquery-3.6.0.min.js"></script>
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
<link href="/rmarkdown-libs/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/datatables-binding/datatables.js"></script>
<script src="/rmarkdown-libs/jquery/jquery-3.6.0.min.js"></script>
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
<link href="/rmarkdown-libs/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/datatables-binding/datatables.js"></script>
<script src="/rmarkdown-libs/jquery/jquery-3.6.0.min.js"></script>
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.min.css" rel="stylesheet" />
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.extra.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-core/js/jquery.dataTables.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-fixedcolumns/css/fixedColumns.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-fixedcolumns/js/dataTables.fixedColumns.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-scroller/css/scroller.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-scroller/js/dataTables.scroller.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
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

## Getting Started

### Installation

[*`systemPipeR`*](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html)
environment can be installed from the R console using the [*`BiocManager::install`*](https://cran.r-project.org/web/packages/BiocManager/index.html)
command. The associated data package [*`systemPipeRdata`*](http://www.bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html)
can be installed the same way. The latter is a helper package for generating *`systemPipeR`*
workflow environments with a single command containing all parameter files and
sample data required to quickly test and run workflows.

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("systemPipeR")
BiocManager::install("systemPipeRdata")
```

Please note that if you desire to use a third-party command-line tool, the particular
tool and dependencies need to be installed and exported in your PATH.
See [details](https://systempipe.org/sp/spr/sprinstall/).

### Loading package and documentation

``` r
library("systemPipeR")  # Loads the package
library(help = "systemPipeR")  # Lists package info
vignette("systemPipeR")  # Opens vignette
```

### How to get help for systemPipeR

All questions about the package or any particular function should be posted to
the Bioconductor support site <https://support.bioconductor.org>.

Please add the “*`systemPipeR`*” tag to your question, and the package authors will
automatically receive an alert.

We appreciate receiving reports of bugs in the functions or documentation and
suggestions for improvement. For that, please consider opening an issue at
[GitHub](https://github.com/tgirke/systemPipeR/issues/new).

## Project structure

*`systemPipeR`* expects a project directory structure that consists of a directory
where users may store all the raw data, the results directory that will be reserved
for all the outfiles files or new output folders, and the parameters directory.

This structure allows reproducibility and collaboration across the data science
team since internally relative paths are used. Users could transfer this project
to a different location and still be able to run the entire workflow. Also, it
increases efficiency and data management once the raw data is kept in a separate
folder and avoids duplication.

### Directory Structure

[*`systemPipeRdata`*](http://bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html),
helper package, provides pre-configured workflows, reporting
templates, and sample data loaded as demonstrated below. With a single command,
the package allows creating the workflow environment containing the structure
described here (see Figure <a href="#fig:dir">1</a>).

Directory names are indicated in <span style="color:grey">***green***</span>.
Users can change this structure as needed, but need to adjust the code in their
workflows accordingly.

-   <span style="color:green">***workflow/***</span> (*e.g.* *myproject/*)
    -   This is the root directory of the R session running the workflow.
    -   Run script ( *\*.Rmd*) and sample annotation (*targets.txt*) files are located here.
    -   Note, this directory can have any name (*e.g.* <span style="color:green">***myproject***</span>). Changing its name does not require any modifications in the run script(s).
    -   **Important subdirectories**:
        -   <span style="color:green">***param/***</span>
            -   <span style="color:green">***param/cwl/***</span>: This subdirectory stores all the parameter and configuration files. To organize workflows, each can have its own subdirectory, where all `*.cwl` and `*input.yml` files need to be in the same subdirectory.
        -   <span style="color:green">***data/*** </span>
            -   Raw data (*e.g.* FASTQ files)
            -   FASTA file of reference (*e.g.* reference genome)
            -   Annotation files
            -   Metadata
            -   etc.
        -   <span style="color:green">***results/***</span>
            -   Analysis results are usually written to this directory, including: alignment, variant and peak files (BAM, VCF, BED); tabular result files; and image/plot files
            -   Note, the user has the option to organize results files for a given sample and analysis step in a separate subdirectory.

<div class="figure" style="text-align: center">

<img src="spr_project.png" alt="systemPipeR's preconfigured directory structure." width="100%" />
<p class="caption">
Figure 1: systemPipeR’s preconfigured directory structure.
</p>

</div>

The following parameter files are included in each workflow template:

1.  *`targets.txt`*: initial one provided by user; downstream *`targets_*.txt`* files are generated automatically
2.  *`*.param/cwl`*: defines parameter for input/output file operations, *e.g.*:
    -   *`hisat2/hisat2-mapping-se.cwl`*
    -   *`hisat2/hisat2-mapping-se.yml`*
3.  *`*_run.sh`*: optional bash scripts
4.  Configuration files for computer cluster environments (skip on single machines):
    -   *`.batchtools.conf.R`*: defines the type of scheduler for *`batchtools`* pointing to template file of cluster, and located in user’s home directory
    -   *`batchtools.*.tmpl`*: specifies parameters of scheduler used by a system, *e.g.* Torque, SGE, Slurm, etc.

### Structure of initial *`targets`* file

The *`targets`* file defines all input files (*e.g.* FASTQ, BAM, BCF) and sample
comparisons of an analysis workflow. The following shows the format of a sample
*`targets`* file included in the package. It also can be viewed and downloaded
from *`systemPipeR`*’s GitHub repository [here](https://github.com/tgirke/systemPipeR/blob/master/inst/extdata/targets.txt).
In a target file with a single type of input files, here FASTQ files of
single-end (SE) reads, the first column describe the path and the second column
represents a unique id name for each sample. The third column called `Factor`
represents the biological replicates. All subsequent columns are additional
information, and any number of extra columns can be added as needed.

Users should note here, the usage of targets files is optional when using
*`systemPipeR's`* new workflow management interface. They can be replaced by a standard YAML
input file used by CWL. Since for organizing experimental variables targets
files are extremely useful and user-friendly. Thus, we encourage users to keep using
them.

#### Structure of *`targets`* file for single-end (SE) samples

``` r
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
showDF(read.delim(targetspath, comment.char = "#"))
```

    ## Loading required namespace: DT

<div id="htmlwidget-1" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"filter":"none","vertical":false,"extensions":["FixedColumns","Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["./data/SRR446027_1.fastq.gz","./data/SRR446028_1.fastq.gz","./data/SRR446029_1.fastq.gz","./data/SRR446030_1.fastq.gz","./data/SRR446031_1.fastq.gz","./data/SRR446032_1.fastq.gz","./data/SRR446033_1.fastq.gz","./data/SRR446034_1.fastq.gz","./data/SRR446035_1.fastq.gz","./data/SRR446036_1.fastq.gz","./data/SRR446037_1.fastq.gz","./data/SRR446038_1.fastq.gz","./data/SRR446039_1.fastq.gz","./data/SRR446040_1.fastq.gz","./data/SRR446041_1.fastq.gz","./data/SRR446042_1.fastq.gz","./data/SRR446043_1.fastq.gz","./data/SRR446044_1.fastq.gz"],["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],["M1","M1","A1","A1","V1","V1","M6","M6","A6","A6","V6","V6","M12","M12","A12","A12","V12","V12"],["Mock.1h.A","Mock.1h.B","Avr.1h.A","Avr.1h.B","Vir.1h.A","Vir.1h.B","Mock.6h.A","Mock.6h.B","Avr.6h.A","Avr.6h.B","Vir.6h.A","Vir.6h.B","Mock.12h.A","Mock.12h.B","Avr.12h.A","Avr.12h.B","Vir.12h.A","Vir.12h.B"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],["23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>FileName<\/th>\n      <th>SampleName<\/th>\n      <th>Factor<\/th>\n      <th>SampleLong<\/th>\n      <th>Experiment<\/th>\n      <th>Date<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"columnDefs":[{"className":"dt-right","targets":5},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

To work with custom data, users need to generate a *`targets`* file containing
the paths to their own FASTQ files and then provide under *`targetspath`* the
path to the corresponding *`targets`* file.

#### Structure of *`targets`* file for paired-end (PE) samples

For paired-end (PE) samples, the structure of the targets file is similar, where
users need to provide two FASTQ path columns: *`FileName1`* and *`FileName2`*
with the paths to the PE FASTQ files.

``` r
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
showDF(read.delim(targetspath, comment.char = "#"))
```

<div id="htmlwidget-2" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2">{"x":{"filter":"none","vertical":false,"extensions":["FixedColumns","Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["./data/SRR446027_1.fastq.gz","./data/SRR446028_1.fastq.gz","./data/SRR446029_1.fastq.gz","./data/SRR446030_1.fastq.gz","./data/SRR446031_1.fastq.gz","./data/SRR446032_1.fastq.gz","./data/SRR446033_1.fastq.gz","./data/SRR446034_1.fastq.gz","./data/SRR446035_1.fastq.gz","./data/SRR446036_1.fastq.gz","./data/SRR446037_1.fastq.gz","./data/SRR446038_1.fastq.gz","./data/SRR446039_1.fastq.gz","./data/SRR446040_1.fastq.gz","./data/SRR446041_1.fastq.gz","./data/SRR446042_1.fastq.gz","./data/SRR446043_1.fastq.gz","./data/SRR446044_1.fastq.gz"],["./data/SRR446027_2.fastq.gz","./data/SRR446028_2.fastq.gz","./data/SRR446029_2.fastq.gz","./data/SRR446030_2.fastq.gz","./data/SRR446031_2.fastq.gz","./data/SRR446032_2.fastq.gz","./data/SRR446033_2.fastq.gz","./data/SRR446034_2.fastq.gz","./data/SRR446035_2.fastq.gz","./data/SRR446036_2.fastq.gz","./data/SRR446037_2.fastq.gz","./data/SRR446038_2.fastq.gz","./data/SRR446039_2.fastq.gz","./data/SRR446040_2.fastq.gz","./data/SRR446041_2.fastq.gz","./data/SRR446042_2.fastq.gz","./data/SRR446043_2.fastq.gz","./data/SRR446044_2.fastq.gz"],["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],["M1","M1","A1","A1","V1","V1","M6","M6","A6","A6","V6","V6","M12","M12","A12","A12","V12","V12"],["Mock.1h.A","Mock.1h.B","Avr.1h.A","Avr.1h.B","Vir.1h.A","Vir.1h.B","Mock.6h.A","Mock.6h.B","Avr.6h.A","Avr.6h.B","Vir.6h.A","Vir.6h.B","Mock.12h.A","Mock.12h.B","Avr.12h.A","Avr.12h.B","Vir.12h.A","Vir.12h.B"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],["23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>FileName1<\/th>\n      <th>FileName2<\/th>\n      <th>SampleName<\/th>\n      <th>Factor<\/th>\n      <th>SampleLong<\/th>\n      <th>Experiment<\/th>\n      <th>Date<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"columnDefs":[{"className":"dt-right","targets":6},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

#### Structure of *`targets`* file for “Hello World” example

In this example, *`targets`* file presents only two columns, which the first one
are the different phrases used by the `echo` command-line and the second column
it is the sample `id`. The `id` column is required, and each sample id should be unique.

``` r
targetspath <- system.file("extdata/cwl/example/targets_example.txt", package = "systemPipeR")
showDF(read.delim(targetspath, comment.char = "#"))
```

<div id="htmlwidget-3" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-3">{"x":{"filter":"none","vertical":false,"extensions":["FixedColumns","Scroller"],"data":[["1","2","3"],["Hello World!","Hello USA!","Hello Bioconductor!"],["M1","M2","M3"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Message<\/th>\n      <th>SampleName<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script>

#### Sample comparisons

Sample comparisons are defined in the header lines of the *`targets`* file
starting with ‘`# <CMP>`.’

``` r
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
readLines(targetspath)[1:4]
```

    ## [1] "# Project ID: Arabidopsis - Pseudomonas alternative splicing study (SRA: SRP010938; PMID: 24098335)"                                                                              
    ## [2] "# The following line(s) allow to specify the contrasts needed for comparative analyses, such as DEG identification. All possible comparisons can be specified with 'CMPset: ALL'."
    ## [3] "# <CMP> CMPset1: M1-A1, M1-V1, A1-V1, M6-A6, M6-V6, A6-V6, M12-A12, M12-V12, A12-V12"                                                                                             
    ## [4] "# <CMP> CMPset2: ALL"

The function *`readComp`* imports the comparison information and stores it in a
*`list`*. Alternatively, *`readComp`* can obtain the comparison information from
the corresponding *`SYSargsList`* step (see below). Note, these header lines are
optional. They are mainly useful for controlling comparative analyses according
to certain biological expectations, such as identifying differentially expressed
genes in RNA-Seq experiments based on simple pair-wise comparisons.

``` r
readComp(file = targetspath, format = "vector", delim = "-")
```

    ## $CMPset1
    ## [1] "M1-A1"   "M1-V1"   "A1-V1"   "M6-A6"   "M6-V6"   "A6-V6"   "M12-A12"
    ## [8] "M12-V12" "A12-V12"
    ## 
    ## $CMPset2
    ##  [1] "M1-A1"   "M1-V1"   "M1-M6"   "M1-A6"   "M1-V6"   "M1-M12"  "M1-A12" 
    ##  [8] "M1-V12"  "A1-V1"   "A1-M6"   "A1-A6"   "A1-V6"   "A1-M12"  "A1-A12" 
    ## [15] "A1-V12"  "V1-M6"   "V1-A6"   "V1-V6"   "V1-M12"  "V1-A12"  "V1-V12" 
    ## [22] "M6-A6"   "M6-V6"   "M6-M12"  "M6-A12"  "M6-V12"  "A6-V6"   "A6-M12" 
    ## [29] "A6-A12"  "A6-V12"  "V6-M12"  "V6-A12"  "V6-V12"  "M12-A12" "M12-V12"
    ## [36] "A12-V12"

### Downstream targets files description

After the step which required the initial targets file information, the downstream
targets files are created automatically (see Figure <a href="#fig:targetsFig">2</a>).
Each step that uses the previous step outfiles as an input, the new targets input
will be managed internally by the workflow instances, establishing connectivity
among the steps in the workflow.
*`systemPipeR`* provides features to automatically and systematically build this
connection, providing security that all the samples will be managed efficiently
and reproducibly.

<div class="figure" style="text-align: center">

<img src="targets_con.png" alt="_systemPipeR_ automatically creates the downstream `targets` files based on the previous steps outfiles. A) Usually, users provide the initial `targets` files, and this step will generate some outfiles, as demonstrated on B. Then, those files are used to build the new `targets` files as inputs in the next step. _`systemPipeR`_ (C) manages this connectivity among the steps automatically for the users." width="100%" />
<p class="caption">
Figure 2: *systemPipeR* automatically creates the downstream `targets` files based on the previous steps outfiles. A) Usually, users provide the initial `targets` files, and this step will generate some outfiles, as demonstrated on B. Then, those files are used to build the new `targets` files as inputs in the next step. *`systemPipeR`* (C) manages this connectivity among the steps automatically for the users.
</p>

</div>

## Structure of the new parameters files

The parameters and configuration required for running command-line software are
provided by the widely used community standard [Common Workflow Language](https://www.commonwl.org/) (CWL) (Amstutz et al. 2016), which describes
parameters analysis workflows in a generic and reproducible manner.
For R-based workflow steps, param files are not required.
For a complete overview of the CWL syntax, please see this [section](https://systempipe.org/sp/spr/cwl_syntax/).
Also, we have a dedicated section explain how to *`systemPipeR`* establish the
connection between the CWL parameters files and the targets files. Please see [here](https://systempipe.org/sp/spr/cwl_and_spr).

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Amstutz2016-ka" class="csl-entry">

Amstutz, Peter, Michael R Crusoe, Nebojša Tijanić, Brad Chapman, John Chilton, Michael Heuer, Andrey Kartashov, et al. 2016. “Common Workflow Language, V1.0,” July. <https://doi.org/10.6084/m9.figshare.3115156.v2>.

</div>

</div>

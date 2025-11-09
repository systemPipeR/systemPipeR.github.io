---
title: "Getting Started" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 15 December, 2021" 
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

[_`systemPipeR`_](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) 
environment can be installed from the R console using the [_`BiocManager::install`_](https://cran.r-project.org/web/packages/BiocManager/index.html) 
command. The associated data package [_`systemPipeRdata`_](http://www.bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html) 
can be installed the same way. The latter is a helper package for generating _`systemPipeR`_ 
workflow environments with a single command containing all parameter files and 
sample data required to quickly test and run workflows. 


```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("systemPipeR")
BiocManager::install("systemPipeRdata")
```

Please note that if you desire to use a third-party command-line tool, the particular
tool and dependencies need to be installed and exported in your PATH. 
See [details](https://systempipe.org/sp/spr/sprinstall/). 

### Loading package and documentation


```r
library("systemPipeR")  # Loads the package
library(help = "systemPipeR")  # Lists package info
vignette("systemPipeR")  # Opens vignette
```

### How to get help for systemPipeR

All questions about the package or any particular function should be posted to 
the Bioconductor support site [https://support.bioconductor.org](https://support.bioconductor.org). 

Please add the "_`systemPipeR`_" tag to your question, and the package authors will 
automatically receive an alert. 

We appreciate receiving reports of bugs in the functions or documentation and
suggestions for improvement. For that, please consider opening an issue at
[GitHub](https://github.com/tgirke/systemPipeR/issues/new). 

## Project structure

_`systemPipeR`_ expects a project directory structure that consists of a directory
where users may store all the raw data, the results directory that will be reserved 
for all the outfiles files or new output folders, and the parameters directory. 

This structure allows reproducibility and collaboration across the data science 
team since internally relative paths are used. Users could transfer this project 
to a different location and still be able to run the entire workflow. Also, it 
increases efficiency and data management once the raw data is kept in a separate 
folder and avoids duplication. 

### Directory Structure {#dir}

[_`systemPipeRdata`_](http://bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html), 
helper package, provides pre-configured workflows, reporting 
templates, and sample data loaded as demonstrated below. With a single command, 
the package allows creating the workflow environment containing the structure 
described here (see Figure \@ref(fig:dir)).

Directory names are indicated in <span style="color:grey">***green***</span>.
Users can change this structure as needed, but need to adjust the code in their 
workflows accordingly. 

* <span style="color:green">_**workflow/**_</span> (*e.g.* *myproject/*) 
    + This is the root directory of the R session running the workflow.
    + Run script ( *\*.Rmd*) and sample annotation (*targets.txt*) files are located here.
    + Note, this directory can have any name (*e.g.* <span style="color:green">_**myproject**_</span>). Changing its name does not require any modifications in the run script(s).
  + **Important subdirectories**: 
    + <span style="color:green">_**param/**_</span> 
        + <span style="color:green">_**param/cwl/**_</span>: This subdirectory stores all the parameter and configuration files. To organize workflows, each can have its own subdirectory, where all `*.cwl` and `*input.yml` files need to be in the same subdirectory. 
    + <span style="color:green">_**data/**_ </span>
        + Raw data (*e.g.* FASTQ files)
        + FASTA file of reference (*e.g.* reference genome)
        + Annotation files
        + Metadata
        + etc.
    + <span style="color:green">_**results/**_</span>
        + Analysis results are usually written to this directory, including: alignment, variant and peak files (BAM, VCF, BED); tabular result files; and image/plot files
        + Note, the user has the option to organize results files for a given sample and analysis step in a separate subdirectory.

<div class="figure" style="text-align: center">
<img src="spr_project.png" alt="systemPipeR's preconfigured directory structure." width="100%" />
<p class="caption">(\#fig:dir)systemPipeR's preconfigured directory structure.</p>
</div>

The following parameter files are included in each workflow template:

1. *`targets.txt`*: initial one provided by user; downstream *`targets_*.txt`* files are generated automatically
2. *`*.param/cwl`*: defines parameter for input/output file operations, *e.g.*:
    + *`hisat2/hisat2-mapping-se.cwl`* 
    + *`hisat2/hisat2-mapping-se.yml`*
3. *`*_run.sh`*: optional bash scripts 
4. Configuration files for computer cluster environments (skip on single machines):
    + *`.batchtools.conf.R`*: defines the type of scheduler for *`batchtools`* pointing to template file of cluster, and located in user's home directory
    + *`batchtools.*.tmpl`*: specifies parameters of scheduler used by a system, *e.g.* Torque, SGE, Slurm, etc.

## Structure of initial _`targets`_ data

The _`targets`_ data defines all input files (_e.g._ FASTQ, BAM, BCF) and sample 
comparisons of an analysis workflow. It can, also, store any number of descriptive 
information for each sample used in the workflow. 

The following shows the format of a sample _`targets`_ file included in the
package. It also can be viewed and downloaded 
from _`systemPipeR`'s_ GitHub repository [here](https://github.com/tgirke/systemPipeR/blob/master/inst/extdata/targets.txt). 
Please note that here it is represented a tabular file, however _`systemPipeR`_ can 
import the inputs information from a `YAML` and `Google Sheets` files, as well as 
`SummarizedExperiment` object. For more details on how to create custom `targets`, 
please find here. 

Users should note here, the usage of targets files is optional when using
_`systemPipeR's`_ new workflow management interface. They can be replaced by a standard YAML
input file used by CWL. Since for organizing experimental variables targets
files are extremely useful and user-friendly. Thus, we encourage users to keep using 
them. 

### Structure of _`targets`_ file for single-end (SE) samples

In a target file with a single type of input files, here FASTQ files of 
single-end (SE) reads, the first column describe the path and the second column
represents a unique `id` name for each sample. The third column called `Factor` 
represents the biological replicates. All subsequent columns are additional 
information, and any number of extra columns can be added as needed.


```r
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
showDF(read.delim(targetspath, comment.char = "#"))
```

```
## Loading required namespace: DT
```

```{=html}
<div id="htmlwidget-11208547f79be35a3b08" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-11208547f79be35a3b08">{"x":{"filter":"none","vertical":false,"extensions":["FixedColumns","Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["./data/SRR446027_1.fastq.gz","./data/SRR446028_1.fastq.gz","./data/SRR446029_1.fastq.gz","./data/SRR446030_1.fastq.gz","./data/SRR446031_1.fastq.gz","./data/SRR446032_1.fastq.gz","./data/SRR446033_1.fastq.gz","./data/SRR446034_1.fastq.gz","./data/SRR446035_1.fastq.gz","./data/SRR446036_1.fastq.gz","./data/SRR446037_1.fastq.gz","./data/SRR446038_1.fastq.gz","./data/SRR446039_1.fastq.gz","./data/SRR446040_1.fastq.gz","./data/SRR446041_1.fastq.gz","./data/SRR446042_1.fastq.gz","./data/SRR446043_1.fastq.gz","./data/SRR446044_1.fastq.gz"],["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],["M1","M1","A1","A1","V1","V1","M6","M6","A6","A6","V6","V6","M12","M12","A12","A12","V12","V12"],["Mock.1h.A","Mock.1h.B","Avr.1h.A","Avr.1h.B","Vir.1h.A","Vir.1h.B","Mock.6h.A","Mock.6h.B","Avr.6h.A","Avr.6h.B","Vir.6h.A","Vir.6h.B","Mock.12h.A","Mock.12h.B","Avr.12h.A","Avr.12h.B","Vir.12h.A","Vir.12h.B"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],["23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>FileName<\/th>\n      <th>SampleName<\/th>\n      <th>Factor<\/th>\n      <th>SampleLong<\/th>\n      <th>Experiment<\/th>\n      <th>Date<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"columnDefs":[{"className":"dt-right","targets":5},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```

To work with custom data, users need to generate a _`targets`_ file containing 
the paths to their own FASTQ files and then provide under _`targetspath`_ the
path to the corresponding _`targets`_ file. 

### Structure of _`targets`_ file for paired-end (PE) samples

For paired-end (PE) samples, the structure of the targets file is similar, where
users need to provide two FASTQ path columns: *`FileName1`* and *`FileName2`* 
with the paths to the PE FASTQ files. 


```r
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
showDF(read.delim(targetspath, comment.char = "#"))
```

```{=html}
<div id="htmlwidget-d65e902a761ce590d29b" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d65e902a761ce590d29b">{"x":{"filter":"none","vertical":false,"extensions":["FixedColumns","Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["./data/SRR446027_1.fastq.gz","./data/SRR446028_1.fastq.gz","./data/SRR446029_1.fastq.gz","./data/SRR446030_1.fastq.gz","./data/SRR446031_1.fastq.gz","./data/SRR446032_1.fastq.gz","./data/SRR446033_1.fastq.gz","./data/SRR446034_1.fastq.gz","./data/SRR446035_1.fastq.gz","./data/SRR446036_1.fastq.gz","./data/SRR446037_1.fastq.gz","./data/SRR446038_1.fastq.gz","./data/SRR446039_1.fastq.gz","./data/SRR446040_1.fastq.gz","./data/SRR446041_1.fastq.gz","./data/SRR446042_1.fastq.gz","./data/SRR446043_1.fastq.gz","./data/SRR446044_1.fastq.gz"],["./data/SRR446027_2.fastq.gz","./data/SRR446028_2.fastq.gz","./data/SRR446029_2.fastq.gz","./data/SRR446030_2.fastq.gz","./data/SRR446031_2.fastq.gz","./data/SRR446032_2.fastq.gz","./data/SRR446033_2.fastq.gz","./data/SRR446034_2.fastq.gz","./data/SRR446035_2.fastq.gz","./data/SRR446036_2.fastq.gz","./data/SRR446037_2.fastq.gz","./data/SRR446038_2.fastq.gz","./data/SRR446039_2.fastq.gz","./data/SRR446040_2.fastq.gz","./data/SRR446041_2.fastq.gz","./data/SRR446042_2.fastq.gz","./data/SRR446043_2.fastq.gz","./data/SRR446044_2.fastq.gz"],["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],["M1","M1","A1","A1","V1","V1","M6","M6","A6","A6","V6","V6","M12","M12","A12","A12","V12","V12"],["Mock.1h.A","Mock.1h.B","Avr.1h.A","Avr.1h.B","Vir.1h.A","Vir.1h.B","Mock.6h.A","Mock.6h.B","Avr.6h.A","Avr.6h.B","Vir.6h.A","Vir.6h.B","Mock.12h.A","Mock.12h.B","Avr.12h.A","Avr.12h.B","Vir.12h.A","Vir.12h.B"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],["23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>FileName1<\/th>\n      <th>FileName2<\/th>\n      <th>SampleName<\/th>\n      <th>Factor<\/th>\n      <th>SampleLong<\/th>\n      <th>Experiment<\/th>\n      <th>Date<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"columnDefs":[{"className":"dt-right","targets":6},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```

### Structure of _`targets`_ file for "Hello World" example

In this example, _`targets`_ file presents only two columns, which the first one 
are the different phrases used by the `echo` command-line and the second column
it is the sample `id`. The `id` column is required, and each sample id should be unique. 


```r
targetspath <- system.file("extdata/cwl/example/targets_example.txt", package = "systemPipeR")
showDF(read.delim(targetspath, comment.char = "#"))
```

```{=html}
<div id="htmlwidget-83b2c6f615b5f62b6632" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-83b2c6f615b5f62b6632">{"x":{"filter":"none","vertical":false,"extensions":["FixedColumns","Scroller"],"data":[["1","2","3"],["Hello World!","Hello USA!","Hello Bioconductor!"],["M1","M2","M3"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Message<\/th>\n      <th>SampleName<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script>
```

### Sample comparisons

Sample comparisons are defined in the header lines of the _`targets`_ file 
starting with '``# <CMP>``'. 


```r
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
readLines(targetspath)[1:4]
```

```
## [1] "# Project ID: Arabidopsis - Pseudomonas alternative splicing study (SRA: SRP010938; PMID: 24098335)"                                                                              
## [2] "# The following line(s) allow to specify the contrasts needed for comparative analyses, such as DEG identification. All possible comparisons can be specified with 'CMPset: ALL'."
## [3] "# <CMP> CMPset1: M1-A1, M1-V1, A1-V1, M6-A6, M6-V6, A6-V6, M12-A12, M12-V12, A12-V12"                                                                                             
## [4] "# <CMP> CMPset2: ALL"
```

The function _`readComp`_ imports the comparison information and stores it in a 
_`list`_. Alternatively, _`readComp`_ can obtain the comparison information from 
the corresponding _`SYSargsList`_ step (see below). Note, these header lines are 
optional. They are mainly useful for controlling comparative analyses according 
to certain biological expectations, such as identifying differentially expressed
genes in RNA-Seq experiments based on simple pair-wise comparisons.
 

```r
readComp(file = targetspath, format = "vector", delim = "-")
```

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
```

## Downstream targets files description

After the step which required the initial targets file information, the downstream 
targets files are created automatically (see Figure \@ref(fig:targetsFig)).
Each step that uses the previous step outfiles as an input, the new targets input 
will be managed internally by the workflow instances, establishing connectivity 
among the steps in the workflow. 
_`systemPipeR`_ provides features to automatically and systematically build this 
connection, providing security that all the samples will be managed efficiently 
and reproducibly.

<div class="figure" style="text-align: center">
<img src="/home/dcassol/src/R-devel/library/systemPipeR/extdata/images/targets_con.png" alt="_`systemPipeR`_ automatically creates the downstream `targets` files based on the previous steps outfiles. A) Usually, users provide the initial `targets` files, and this step will generate some outfiles, as demonstrated on B. Then, those files are used to build the new `targets` files as inputs in the next step. _`systemPipeR`_ (C) manages this connectivity among the steps automatically for the users." width="100%" />
<p class="caption">(\#fig:targetsFig)_`systemPipeR`_ automatically creates the downstream `targets` files based on the previous steps outfiles. A) Usually, users provide the initial `targets` files, and this step will generate some outfiles, as demonstrated on B. Then, those files are used to build the new `targets` files as inputs in the next step. _`systemPipeR`_ (C) manages this connectivity among the steps automatically for the users.</p>
</div>

## Structure of the new parameters files

The parameters and configuration required for running command-line software are 
provided by the widely used community standard [Common Workflow Language](https://www.commonwl.org/) (CWL) [@Amstutz2016-ka], which describes
parameters analysis workflows in a generic and reproducible manner. 
For R-based workflow steps, param files are not required. 
For a complete overview of the CWL syntax, please see this [section](https://systempipe.org/sp/spr/cwl_syntax/). 
Also, we have a dedicated section explain how to _`systemPipeR`_ establish the 
connection between the CWL parameters files and the targets files. Please see [here](https://systempipe.org/sp/spr/cwl_and_spr). 



## References

---
title: "SPR WorkFlow Collection" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: `r format(Sys.time(), '%d %B, %Y')`" 
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
bibliography: bibtex.bib
editor_options: 
  chunk_output_type: console
type: docs
---

## Workflow Templates

[_`systemPipeR`_](https://github.com/systemPipeR/) project provides pre-configured workflows and reporting templates for a wide range of NGS applications that are listed bellow. The *systemPipeR* project provides a suite of R/Bioconductor packages for designing, building and running end-to-end analysis workflows on local machines, HPC clusters 
and cloud systems, while generating at the same time publication quality analysis reports.

[_`systemPipeRdata`_](https://github.com/tgirke/systemPipeRdata) is a helper package 
to generate with a single command workflow templates that are intended to be 
used by its parent package [_`systemPipeR`_](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) [@H_Backman2016-bt]. 

For `stable` workflows, one can directly use following to create/check supported workflows.
When you typed the wrong/unsupported workflow names, all possible workflows will be 
listed. The table below also displays workflow template development status.

```r
systemPipeRdata::genWorkflowEnv("")
#> Error in systemPipeRdata::genWorkenvir("") : 
#>  workflow can only be assigned one of: chipseq, new, riboseq, rnaseq, varseq, SPblast, SPcheminfo, SPscrna
```



|   WorkFlow    |                   Description                    |                                     Status                                      |                                                                                                              Link                                                                                                              |
| :-----------: | :----------------------------------------------: | :-----------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|   SPchipseq   |            ChIP-Seq Workflow Template            |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        | <a href="https://www.bioconductor.org/packages/release/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeChIPseq.html" target="_blank"> <img src="bioconductor_logo_rgb.png" align="center" style="width:100px;" /> |
|   SPriboseq   |            RIBO-Seq Workflow Template            |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        | <a href="https://www.bioconductor.org/packages/release/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRIBOseq.html" target="_blank"> <img src="bioconductor_logo_rgb.png" align="center" style="width:100px;" /> |
|   SPrnaseq    |            RNA-Seq Workflow Template             |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        | <a href="https://www.bioconductor.org/packages/release/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRNAseq.html" target="_blank"> <img src="bioconductor_logo_rgb.png" align="center" style="width:100px;" />  |
|   SPvarseq    |            VAR-Seq Workflow Template             |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        | <a href="https://www.bioconductor.org/packages/release/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeVARseq.html" target="_blank"> <img src="bioconductor_logo_rgb.png" align="center" style="width:100px;" />  |
|  SPscrnaseq   |      Single-Cell RNA-Seq Workflow Template       |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |      <a href="https://www.bioconductor.org/packages/release/data/experiment/vignettes/systemPipeRdata/inst/doc/SPscrna.html" target="_blank"> <img src="bioconductor_logo_rgb.png" align="center" style="width:100px;" />      |
|    SPblast    |             BLAST Workflow Template              |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |      <a href="https://www.bioconductor.org/packages/release/data/experiment/vignettes/systemPipeRdata/inst/doc/SPblast.html" target="_blank"> <img src="bioconductor_logo_rgb.png" align="center" style="width:100px;" />      |
|  SPcheminfo   |          Basic drug discovery workflow           |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |    <a href="https://www.bioconductor.org/packages/release/data/experiment/vignettes/systemPipeRdata/inst/doc/SPcheminfo.html" target="_blank"> <img src="bioconductor_logo_rgb.png" align="center" style="width:100px;" />     |
|  SPmethylseq  |           Methyl-Seq Workflow Template           | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/SPmethylseq" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |
|   SPdenovo    | De novo transcriptome assembly Workflow Template | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |    <a href="https://github.com/systemPipeR/SPdenovo" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />    |
|   SPclipseq   |            CLIP-Seq Workflow Template            | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |   <a href="https://github.com/systemPipeR/SPclipseq" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />    |
|  SPmetatrans  | Metatranscriptomic Sequencing Workflow Template  | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/SPmetatrans" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |
|   SPatacseq   |            ATAC-Seq Workflow Template            | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |   <a href="https://github.com/systemPipeR/SPatacseq" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />    |
| SPpolyriboseq |     Polyribosomal RNA-Seq Workflow Template      | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) | <a href="https://github.com/systemPipeR/SPpolyriboseq" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />  |
|     SPhic     |              Hi-C Workflow Template              | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |     <a href="https://github.com/systemPipeR/SPhic" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />      |
|  SPmirnaseq   |          MicroRNA-Seq Workflow Template          | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |   <a href="https://github.com/systemPipeR/SPmirnaseq" target="_blank"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |





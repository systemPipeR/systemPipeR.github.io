---
title: "SPR WorkFlow Collection" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 22 February, 2021" 
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

[*`systemPipeR`*](https://github.com/systemPipeR/) project provides pre-configured workflows and reporting templates for a wide range of NGS applications that are listed bellow. The *systemPipeR* project provides a suite of R/Bioconductor packages for designing, building and running end-to-end analysis workflows on local machines, HPC clusters
and cloud systems, while generating at the same time publication quality analysis reports.

[*`systemPipeRdata`*](https://github.com/tgirke/systemPipeRdata) is a helper package
to generate with a single command workflow templates that are intended to be
used by its parent package [*`systemPipeR`*](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) (H Backman and Girke 2016).

|                                               WorkFlow                                               |                   Description                    |                                     Version                                     |                                                                                                       GitHub                                                                                                        |                                            R-CMD-check                                             |
|:----------------------------------------------------------------------------------------------------:|:------------------------------------------------:|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------:|
| [systemPipeChIPseq](https://systempiper.github.io/systemPipeChIPseq/articles/systemPipeChIPseq.html) |            ChIP-Seq Workflow Template            |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |  <a href="https://github.com/systemPipeR/systemPipeChIPseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />  |  ![R-CMD-check](https://github.com/systemPipeR/systemPipeChIPseq/workflows/R-CMD-check/badge.svg)  |
| [systemPipeRIBOseq](https://systempiper.github.io/systemPipeRIBOseq/articles/systemPipeRIBOseq.html) |            RIBO-Seq Workflow Template            |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |  <a href="https://github.com/systemPipeR/systemPipeRIBOseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />  |  ![R-CMD-check](https://github.com/systemPipeR/systemPipeRIBOseq/workflows/R-CMD-check/badge.svg)  |
|  [systemPipeRNAseq](https://systempiper.github.io/systemPipeRNAseq/articles/systemPipeRNAseq.html)   |            RNA-Seq Workflow Template             |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |  <a href="https://github.com/systemPipeR/systemPipeRNAseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |  ![R-CMD-check](https://github.com/systemPipeR/systemPipeRNAseq/workflows/R-CMD-check/badge.svg)   |
|  [systemPipeVARseq](https://systempiper.github.io/systemPipeVARseq/articles/systemPipeVARseq.html)   |            VAR-Seq Workflow Template             |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |  <a href="https://github.com/systemPipeR/systemPipeVARseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |  ![R-CMD-check](https://github.com/systemPipeR/systemPipeVARseq/workflows/R-CMD-check/badge.svg)   |
|              [systemPipeMethylseq](https://github.com/systemPipeR/systemPipeMethylseq)               |           Methyl-Seq Workflow Template           | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) | <a href="https://github.com/systemPipeR/systemPipeMethylseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" /> | ![R-CMD-check](https://github.com/systemPipeR/systemPipeMethylseq/workflows/R-CMD-check/badge.svg) |
|                 [systemPipeDeNovo](https://github.com/systemPipeR/systemPipeDeNovo)                  | De novo transcriptome assembly Workflow Template | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/systemPipeDeNovo"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |  ![R-CMD-check](https://github.com/systemPipeR/systemPipeDeNovo/workflows/R-CMD-check/badge.svg)   |
|                [systemPipeCLIPseq](https://github.com/systemPipeR/systemPipeCLIPseq)                 |            CLIP-Seq Workflow Template            | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/systemPipeCLIPseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />  |  ![R-CMD-check](https://github.com/systemPipeR/systemPipeCLIPseq/workflows/R-CMD-check/badge.svg)  |
|              [systemPipeMetaTrans](https://github.com/systemPipeR/systemPipeMetaTrans)               | Metatranscriptomic Sequencing Workflow Template  | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) | <a href="https://github.com/systemPipeR/systemPipeMetaTrans"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" /> | ![R-CMD-check](https://github.com/systemPipeR/systemPipeMetaTrans/workflows/R-CMD-check/badge.svg) |

### Reference

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-H_Backman2016-bt" class="csl-entry">

H Backman, Tyler W, and Thomas Girke. 2016. “<span class="nocase">systemPipeR: NGS workflow and report generation environment</span>.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

</div>

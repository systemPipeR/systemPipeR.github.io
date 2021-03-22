---
title: "SPR WorkFlow Collection" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 22 March, 2021" 
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

|                                   WorkFlow                                   |                   Description                    |                                     Version                                     |                                                                                                    GitHub                                                                                                     |                                           R-CMD-check                                            |
| :--------------------------------------------------------------------------: | :----------------------------------------------: | :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------: |
| [SPchipseq](https://systempiper.github.io/SPchipseq/articles/SPchipseq.html) |            ChIP-Seq Workflow Template            |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |   <a href="https://github.com/systemPipeR/SPchipseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   | ![R-CMD-check](https://github.com/systemPipeR/systemPipeChIPseq/workflows/R-CMD-check/badge.svg) |
| [SPriboseq](https://systempiper.github.io/SPriboseq/articles/SPriboseq.html) |            RIBO-Seq Workflow Template            |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |   <a href="https://github.com/systemPipeR/SPriboseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |     ![R-CMD-check](https://github.com/systemPipeR/SPriboseq/workflows/R-CMD-check/badge.svg)     |
|  [SPrnaseq](https://systempiper.github.io/SPrnaseq/articles/SPrnaseq.html)   |            RNA-Seq Workflow Template             |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |   <a href="https://github.com/systemPipeR/SPrnaseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />    |     ![R-CMD-check](https://github.com/systemPipeR/SPrnaseq/workflows/R-CMD-check/badge.svg)      |
|  [SPvarseq](https://systempiper.github.io/SPvarseq/articles/SPvarseq.html)   |            VAR-Seq Workflow Template             |       ![Stable](https://img.shields.io/badge/lifecycle-stable-green.svg)        |   <a href="https://github.com/systemPipeR/SPvarseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />    |     ![R-CMD-check](https://github.com/systemPipeR/SPvarseq/workflows/R-CMD-check/badge.svg)      |
|          [SPmethylseq](https://github.com/systemPipeR/SPmethylseq)           |           Methyl-Seq Workflow Template           | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/SPmethylseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />  |    ![R-CMD-check](https://github.com/systemPipeR/SPmethylseq/workflows/R-CMD-check/badge.svg)    |
|             [SPdenovo](https://github.com/systemPipeR/SPdenovo)              | De novo transcriptome assembly Workflow Template | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |   <a href="https://github.com/systemPipeR/SPdenovo"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />    |     ![R-CMD-check](https://github.com/systemPipeR/SPdenovo/workflows/R-CMD-check/badge.svg)      |
|            [SPclipseq](https://github.com/systemPipeR/SPclipseq)             |            CLIP-Seq Workflow Template            | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |   <a href="https://github.com/systemPipeR/SPclipseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |     ![R-CMD-check](https://github.com/systemPipeR/SPclipseq/workflows/R-CMD-check/badge.svg)     |
|          [SPmetatrans](https://github.com/systemPipeR/SPmetatrans)           | Metatranscriptomic Sequencing Workflow Template  | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/SPmetatrans"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />  |    ![R-CMD-check](https://github.com/systemPipeR/SPmetatrans/workflows/R-CMD-check/badge.svg)    |
|            [SPatacseq](https://github.com/systemPipeR/SPatacseq)             |            ATAC-Seq Workflow Template            | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |   <a href="https://github.com/systemPipeR/SPatacseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |     ![R-CMD-check](https://github.com/systemPipeR/SPatacseq/workflows/R-CMD-check/badge.svg)     |
|        [SPpolyriboseq](https://github.com/systemPipeR/SPpolyriboseq)         |     Polyribosomal RNA-Seq Workflow Template      | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) | <a href="https://github.com/systemPipeR/SPpolyriboseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" /> |   ![R-CMD-check](https://github.com/systemPipeR/SPpolyriboseq/workflows/R-CMD-check/badge.svg)   |
|                [SPhic](https://github.com/systemPipeR/SPhic)                 |              Hi-C Workflow Template              | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |     <a href="https://github.com/systemPipeR/SPhic"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />     |       ![R-CMD-check](https://github.com/systemPipeR/SPhic/workflows/R-CMD-check/badge.svg)       |
|           [SPmirnaseq](https://github.com/systemPipeR/SPmirnaseq)            |          MicroRNA-Seq Workflow Template          | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/SPmirnaseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |    ![R-CMD-check](https://github.com/systemPipeR/SPmirnaseq/workflows/R-CMD-check/badge.svg)     |
|              [SPblast](https://github.com/systemPipeR/SPblast)               |             BLAST Workflow Template              | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |    <a href="https://github.com/systemPipeR/SPblast"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />    |      ![R-CMD-check](https://github.com/systemPipeR/SPblast/workflows/R-CMD-check/badge.svg)      |
|           [SPscrnaseq](https://github.com/systemPipeR/SPscrnaseq)            |      Single-Cell RNA-Seq Workflow Template       | ![Experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg) |  <a href="https://github.com/systemPipeR/SPscrnaseq"> <img src="https://raw.githubusercontent.com/systemPipeR/systemPipeR/gh-pages/images/GitHub-Mark-120px-plus.png" align="center" style="width:20px;" />   |    ![R-CMD-check](https://github.com/systemPipeR/SPscrnaseq/workflows/R-CMD-check/badge.svg)     |

### Reference

<div id="refs" class="references">

<div id="ref-H_Backman2016-bt">

H Backman, Tyler W, and Thomas Girke. 2016. “systemPipeR: NGS workflow and report generation environment.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

</div>

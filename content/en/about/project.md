---
title: "About Project"
linkTitle: "Project"
type: docs
description: >
weight: 2
exclude_search: true
---

## Overview

<img src="systemPipe_logo.png" width="20%" alt="Right Aligned" align="right" style="display: block; margin: auto;" />

The systemPipe project provides a suite of R/Bioconductor packages for designing, building and running end-to-end analysis workflows on local machines and HPC systems, while generating at the same time publication quality analysis reports.

This site serves mainly as a landing page providing a high-level overview of each package and links to the corresponding pages on Bioconductor. Detailed usage instructions are provided in the vignettes of each package on Bioconductor (linked below).

### Core Packages

  * __systemPipeR: Workflow Management System (WMS)__ <br/>
[_systemPipeR_](https://bioconductor.org/packages/devel/bioc/html/systemPipeR.html) is the core workflow management package, enabling users to define, organize, and run workflows that combine R functions with external command-line software([H Backman and Girke 2016](https://link.springer.com/article/10.1186/s12859-016-1241-0)). A scientific reporting system is integral part of the package.

  * __systemPipeRdata: Workflow Templates__ <br/>
[_systemPipeRdata_](https://www.bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html) offers a set of pre-configured workflow templates and associated resources that simplify the setup of common analysis pipelines. 

  * __systemPipeShiny: Visualization Toolbox__ <br/>
[_systemPipeShiny_](https://bioconductor.org/packages/release/bioc/html/systemPipeShiny.html) provides a Shiny-based graphical interface for a subset of _systemPipeR's_ functionalities as well as a collection of interactive visualization tools.


## Workflow 

### Templates

The [_systemPipeRdata_](https://www.bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html) package provides preconfigured workflow templates that are compatible with the systemPipeR WMS. These templates include the necessary CWL parameter files for running a chosen workflow. Many of the templates come equipped with sample data. This setup serves several purposes: it simplifies the learning curve for using systemPipeR, allows for easy workflow testing, and provides a starting point for developing new workflows. To get started using systemPiperR's workflow templates, users should refer to the provided overview tutorial of [_systemPipeR_](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html) and [_systemPipeRdata_](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRdata.html).

The workflow templates are also availble from GitHub. The following table lists a core set of workflows along with links for obtaining them from GitHub or via _systemPipeRdata_ on Bioconductor. 


| **Name**   | **Description**                          | **URL**      |
|------------|------------------------------------------|--------------|
| new        | Generic Workflow Template                | [Bioc](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/new.html), [GitHub](https://github.com/systemPipeR/sprwf-new-02-14-04) |
| rnaseq     | RNA-Seq Workflow Template                | Rmd, HTML |
| riboseq    | RIBO-Seq Workflow Template               | Rmd, HTML |
| chipseq    | ChIP-Seq Workflow Template               | Rmd, HTML |
| varseq     | VAR-Seq Workflow Template                | Rmd, HTML |
| SPblast    | BLAST Workflow Template                  | Rmd, HTML |
| SPcheminfo | Cheminformatics Drug Similarity Template | Rmd, HTML |
| SPscrna    | Basic Single-Cell Workflow Template      | Rmd, HTML |




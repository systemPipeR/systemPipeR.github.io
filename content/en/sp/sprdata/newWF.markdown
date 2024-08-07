---
title: "Rules to create a new Workflow Template" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 18 April, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{WF: New Workflow Template}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
editor_options: 
  chunk_output_type: console
type: docs
weight: 2
---



# How to create a new Workflow Template

`SPRthis` package expand [usethis](https://github.com/r-lib/usethis) package, providing automation to create [systemPipeR](https://github.com/tgirke/systemPipeR) workflows templates.

## Installation 

To install `SPRthis` using from `BiocManager` the following code:


```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
  BiocManager::install("dcassol/SPRthis")
```

## Quick start to using to `SPRthis`


```r
## Load the package
library(SPRthis)
## create Package
sprthis(wfName="SPRtest", analysis="SPRtest", path=tempdir())
```

```
## ✓ Setting active project to '/tmp/RtmpunjAF9'
```

```
## ✓ Creating 'R/'
```

```
## ✓ Writing 'DESCRIPTION'
```

```
## Package: SPRtest
## Title: SPRtest
## Version: 0.9.0
## Authors@R (parsed):
##     * First Last <first.last@example.com> [aut, cre] (YOUR-ORCID-ID)
## Description: This package provides a pre-configured workflow and reporting
##     template for SPRtest.
## License: Artistic-2.0
## URL: https://github.com/systemPipeR/SPRtest
## Imports:
##     systemPipeR (>= 1.25.0)
## Suggests:
##     BiocStyle,
##     knitr,
##     rmarkdown
## VignetteBuilder:
##     knitr
## biocViews: Infrastructure, ...
## Encoding: UTF-8
## LazyData: true
## Roxygen: list(markdown = TRUE)
## RoxygenNote: 7.1.1
## SystemRequirements: SPRtest can be used to run external command-line
##     software, but the corresponding tool needs to be installed on a
##     system.
```

```
## ✓ Writing 'NAMESPACE'
```

```
## ✓ Setting active project to '<no active project>'
```

```
## [1] "/tmp/RtmpunjAF9"
```

<pre>
SPRtest/  
├── DESCRIPTION 
├── NAMESPACE 
├── README.md 
├── SPRtest.Rproj 
├── .gitignore
├── .Rbuildignore
├── .Rproj.user/  
├── R/
│   ├── functions.R
├── vignettes 
│   ├── bibtex.bib
│   ├── SPRtest.Rmd  
└── inst 
    ├── rmarkdown 
    │   └── templates
    │       └── SPRtest
    │           ├── template.yml
    │           └── skeleton
    │                 ├── batchtools.slurm.tmpl
    │                 ├── .batchtools.conf.R
    │                 ├── bibtex.bib 
    │                 ├── NEWS
    │                 ├── SPRconfig.yml
    │                 ├── skeleton.Rmd 
    │                 ├── targetsPE.txt 
    │                 ├── data/
    │                 ├── param/
    │                 └── results/
</pre>

# Help functions to create the package

## Create the webiste for the package with `pkgdown`

Edit the `_pkgdown.yml` file and run:


```r
pkgdown::build_site() 
```

## Documentation with `roxygen2`


```r
roxygen2::roxygenise()
```

## Testing the code with `testthat`

To test the code, you can run


```r
devtools::test()
```

# Update R Markdown template on `skeleton`


```r
path <- file.path("vignettes/SPRtest.Rmd")
skeleton_update(path)
```

# Package available to `genWorkenvir` Function

After creating the new repository on GitHub [systemPipeR Organization](https://github.com/systemPipeR), 
please follow:

 - Rules:
    - The Workflow Template need to be available under [systemPipeR Organization](https://github.com/systemPipeR/);
    - The repository needs to be `public`;
    - About setting: 
        - `Description`: keywords in the description are required: "Workflow Template";
        - `Topics`: we expected "systempiper" and "release" or "development" words on Topics section;
    - Branch name: To make simple, please name the branch as "master".

## Check availability of workflow templates 

A collection of workflow templates are available, and it is possible to browse the 
current availability, as follows:


```r
systemPipeRdata::availableWF(github = TRUE)
```

```
## $systemPipeRdata
## [1] "chipseq" "new"     "riboseq" "rnaseq"  "varseq" 
## 
## $github
##                  workflow                       branches version
## 1   systemPipeR/SPchipseq                         master release
## 2   systemPipeR/SPriboseq                         master release
## 3    systemPipeR/SPrnaseq cluster, master, singleMachine release
## 4    systemPipeR/SPvarseq                         master release
## 5   systemPipeR/SPclipseq                         master   devel
## 6    systemPipeR/SPdenovo                         master   devel
## 7 systemPipeR/SPmetatrans                         master   devel
## 8 systemPipeR/SPmethylseq                         master   devel
## 9  systemPipeR/SPmirnaseq                         master   devel
##                                         html       description
## 1   https://github.com/systemPipeR/SPchipseq Workflow Template
## 2   https://github.com/systemPipeR/SPriboseq Workflow Template
## 3    https://github.com/systemPipeR/SPrnaseq Workflow Template
## 4    https://github.com/systemPipeR/SPvarseq Workflow Template
## 5   https://github.com/systemPipeR/SPclipseq Workflow Template
## 6    https://github.com/systemPipeR/SPdenovo Workflow Template
## 7 https://github.com/systemPipeR/SPmetatrans Workflow Template
## 8 https://github.com/systemPipeR/SPmethylseq Workflow Template
## 9  https://github.com/systemPipeR/SPmirnaseq Workflow Template
```

This function returns the list of workflow templates available within the package 
and [systemPipeR Project Organization](https://github.com/systemPipeR) on GitHub. Each one 
listed template can be created as described above. 


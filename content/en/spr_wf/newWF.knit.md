---
title: "Rules to create a new Workflow Template" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 12 April, 2021" 
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












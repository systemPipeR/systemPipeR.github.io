---
title: "spsUtil"
linkTitle: "spsUtil"
type: docs
weight: 3
---
*****

SPS framework come with a plenty of useful general R utility functions, like 
pretty logging, package namespace checking, URL checking, and more.

Since SPS 1.1, these functions are separated into a supporting package called 
**spsUtil** (systemPipeShiny Utility). You can install it from CRAN.


```r
install.packages("spsUtil")
```
Develop version:
```r
if (!requireNamespace("spsUtil", quietly=TRUE))
    remotes::install_github("lz100/spsComps")
```

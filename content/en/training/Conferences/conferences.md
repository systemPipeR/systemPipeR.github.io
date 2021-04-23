---
title: "Conferences"
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 23 April, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
fontsize: 14pt
type: docs
weight: 1
---

## BioC2021

+ [BioC2021{blk}](https://bioc2021.bioconductor.org/)
+ systemPipe: Workflow and Visualization Toolkit - Workshop
    + [GitHub Material{blk}](https://github.com/systemPipeR/systemPipeWorkshop2021)

## BioC2020

+ [BioC2020{blk}](https://bioc2020.bioconductor.org/)

+ `systemPipeShiny`: An Interactive Framework for Workflow Management and Visualization - [F1000{blk}](https://f1000research.com/posters/9-749)
+ `systemPipeR`: a generic workflow environment federates R with command-line software - [F1000{blk}](https://f1000research.com/posters/9-747)

## BioC2019

+ [BioC2019{blk}](https://bioc2019.bioconductor.org/)
+ `systemPipeR's` New CWL Command-line Interface - Workshop
    + [GitHub Material{blk}](https://github.com/dcassol/BioC2019_Workshop/blob/master/workshop-sytemPipeR.md)

<iframe width="900" height="600" src="https://systempipe.org/presentations/Bioc2019.html#/" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Bioc2018

+ [BioC2018{blk}](https://bioc2018.bioconductor.org/)

+ [Poster Bioc2018{blk}](https://systempipe.org/posters/Poster_BioC2018.pdf)

## Bioc2016

+ [BioC2016{blk}](https://bioc2019.bioconductor.org/)

<iframe width="900" height="600" src="https://docs.google.com/presentation/d/175aup31LvnbIJUAvEEoSkpGsKgtBJ2RpQYd0Gs23dLo/embed?start=false&loop=false&delayms=60000&slide=id.p" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Material for Bioc2016 Tutorial 

+ [Intro Slide Show{blk}](https://docs.google.com/presentation/d/175aup31LvnbIJUAvEEoSkpGsKgtBJ2RpQYd0Gs23dLo/embed?start=false&loop=false&delayms=60000)
+ Tutorial Material 
    + Introduction to `systemPipeR` 
        + [HTML{blk}](https://htmlpreview.github.io/?https://raw.githubusercontent.com/tgirke/systemPipeRdata/master_github_deprecated/vignettes/systemPipeR_Intro.html)
        + [PDF{blk}](https://raw.githubusercontent.com/tgirke/systemPipeRdata/master_github_deprecated/vignettes/systemPipeR_Intro.pdf)
        + [Rmd{blk}](https://raw.githubusercontent.com/tgirke/systemPipeRdata/master_github_deprecated/vignettes/systemPipeR_Intro.Rmd)
    + Demo Workflow: RIBO-Seq 
        + [HTML{blk}](https://htmlpreview.github.io/?https://raw.githubusercontent.com/tgirke/systemPipeRdata/master_github_deprecated/inst/extdata/workflows/riboseq/systemPipeRIBOseq.html)
        + [PDF{blk}](https://raw.githubusercontent.com/tgirke/systemPipeRdata/master_github_deprecated/inst/extdata/workflows/riboseq/systemPipeRIBOseq.pdf)
        + [Rmd{blk}](https://raw.githubusercontent.com/tgirke/systemPipeRdata/master_github_deprecated/inst/extdata/workflows/riboseq/systemPipeRIBOseq.Rmd)

### Installation 

Please install _systemPipeRdata_ from this GitHub repository as shown below. This package provides the data and `Rmd` files for the tutorial. 
Its parent package _systemPipeR_ is a dependency and it should install along with all its own dependencies automatically. If it doesn't then please also install the package, using the `BiocManager::install` command given below.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("tgirke/systemPipeRdata", build_vignettes=TRUE, dependencies=TRUE)
```

## BioC2015

+ [BioC2015{blk}](https://bioconductor.org/help/course-materials/2015/BioC2015/)

+ [Slide Show Talk{blk}](https://systempipe.org/presentations/systemPipeRslides.html#1)

<iframe width="900" height="600" src="https://systempipe.org/presentations/systemPipeRslides.html#1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

---
title: "Simple Workflow by systemPipeR" 
author: "Author: Daniela Cassol, Le Zhang, and Thomas Girke"
date: "Last update: `r format(Sys.time(), '%d %B, %Y')`" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{Workflow example}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Build the Workflow 

- Load `systemPipeR` library:

```{r load_library, eval=TRUE, spr=TRUE}
appendStep(sal) <- LineWise(code={
 library(systemPipeR)
  }, 
  step_name = "load_library", 
  dependency = NA)
```

## Export dataset to file

- Add first step as `LineWise`

```{r export_iris, eval=TRUE, spr=TRUE}
appendStep(sal) <- LineWise(code={
 mapply(
   function(x, y) write.csv(x, y),
   split(iris, factor(iris$Species)),
   file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))
  }, 
  step_name = "export_iris", 
  dependency = "load_library")
```

## Compress data

- Adding the second step, as `SYSargs2` 

```{r gzip, eval=TRUE, spr=TRUE, spr.dep=TRUE}
targetspath <- system.file("extdata/cwl/gunzip", "targets_gunzip.txt", package = "systemPipeR")
appendStep(sal) <- SYSargsList(step_name = "gzip", 
                      targets = targetspath, dir = TRUE,
                      wf_file = "gunzip/workflow_gzip.cwl", input_file = "gunzip/gzip.yml",
                      dir_path = system.file("extdata/cwl", package = "systemPipeR"),
                      inputvars = c(FileName = "_FILE_PATH_", SampleName = "_SampleName_"), 
                      dependency = "export_iris")
```

## Decompress data

```{r gunzip, eval=TRUE, spr=TRUE}
appendStep(sal) <- SYSargsList(step_name = "gunzip", 
                      targets = "gzip", dir = TRUE,
                      wf_file = "gunzip/workflow_gunzip.cwl", input_file = "gunzip/gunzip.yml",
                      dir_path = system.file("extdata/cwl", package = "systemPipeR"),
                      inputvars = c(gzip_file = "_FILE_PATH_", SampleName = "_SampleName_"), 
                      rm_targets_col = "FileName", 
                      dependency = "gzip")
```

## Import data to R and perform statistical analysis and visualization 
Some other text has been added here.

Some space created. 

```{r stats, eval=TRUE, spr=TRUE}
appendStep(sal) <- LineWise(code={
  df <- lapply(getColumn(sal, step="gunzip", 'outfiles'), function(x) read.delim(x, sep=",")[-1])
  df <- do.call(rbind, df)
  stats <- data.frame(cbind(mean=apply(df[,1:4], 2, mean),
                            sd=apply(df[,1:4], 2, sd)))
  stats$species <- rownames(stats)
  
  plot <- ggplot2::ggplot(stats, ggplot2::aes(x=species, y=mean, fill=species)) + 
    ggplot2::geom_bar(stat = "identity", color="black", position=ggplot2::position_dodge()) +
    ggplot2::geom_errorbar(ggplot2::aes(ymin=mean-sd, ymax=mean+sd), width=.2,
                           position=ggplot2::position_dodge(.9)) 
  }, 
  step_name = "stats", 
  dependency = "gunzip", 
  run_step = "optional")
```

## A new step
This is a new step with some simple code to demonstrate the update of `importWF`
```{r session_info, eval=TRUE, spr=TRUE}
1+1
cat("some fake preprocess code that has been changed!\n")
###pre-end
appendStep(sal) <- LineWise(code={
  sessionInfo()
  }, 
  step_name = "sessionInfo", 
  dependency = "stats")
```

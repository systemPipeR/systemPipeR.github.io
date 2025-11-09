---
title: "Export workflows" 
date: "Last update: 26 October, 2022" 
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeR: Workflow design and reporting generation environment}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
editor_options: 
  chunk_output_type: console
type: docs
weight: 8
---

_`systemPipeR`_ workflow management system allows one to translate workflow into 
**reproducible code** and export the 
workflow build interactively to R Markdown template format or an executable bash script.
This feature advances the reusability of the workflow, as well as the flexibility
for workflow execution.








```r
suppressPackageStartupMessages({
    library(systemPipeR)
})
```

We still use the [simple workflow](https://raw.githubusercontent.com/systemPipeR/systemPipeR.github.io/main/static/en/sp/spr/sp_run/spr_simple_wf.md) to demonstrate.

```r
sal <- SPRproject()
## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/data 
## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/param 
## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/results 
## Creating directory '/home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/.SPRproject'
## Creating file '/home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/.SPRproject/SYSargsList.yml'
sal <- importWF(sal, file_path = system.file("extdata", "spr_simple_wf.Rmd", package = "systemPipeR"), verbose = FALSE)
sal
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. load_library --> Status: Pending
##        2. export_iris --> Status: Pending
##        3. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          3.1. gzip
##              cmdlist: 3 | Pending: 3
##        4. gunzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          4.1. gunzip
##              cmdlist: 3 | Pending: 3
##        5. stats --> Status: Pending
## 
```

## R Markdown file

`sal2rmd` function takes an `SYSargsList` workflow container and translates it to 
SPR workflow template R markdown format. This file can be imported with the 
[`importWF` function](../step_import). This is very similar to the 
[text-enriched report](../step_reports), but with all text removed. 


```r
sal2rmd(sal)
## sal2rmd starts, pre-checks...
## Open spr_template.Rmd to write
## Write Rmd header and description
## Now writing step 1 load_library
## Now writing step 2 export_iris
## Now writing step 3 gzip
## Now writing step 4 gunzip
## Now writing step 5 stats
## Success! File created at spr_template.Rmd
```


## Bash script

`sal2bash` function takes an `SYSargsList` workflow container and translates 
it to an executable bash script, The benefit of this is that if the workflow is 
only composed with command-line steps, no R step (LineWise) step in involved, then 
one could generate the workflow on one computer and run in another computer without 
installing SPR or R at all. 


```r
sal2bash(sal)
## Success: Make sure the script 'spr_wf.sh' and directory ./spr_bash is there before executing.
```

It will be generated on the project root an executable bash script, called by
default the `spr_wf.sh`. Also, a directory `./spr_wf` will be created and store 
all the R scripts based on the workflow steps. Please note that this function will 
"collapse" adjacent R steps into one file as much as possible.


```r
fs::dir_tree("spr_bash")
```

```
## spr_bash
## ├── rscript_step1_2.R
## ├── rscript_step5.R
## └── spr_wf.RData
```


# Session 

```r
sessionInfo()
```

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.9.0
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
##  [1] systemPipeR_2.3.5           ShortRead_1.54.0           
##  [3] GenomicAlignments_1.32.1    SummarizedExperiment_1.26.1
##  [5] Biobase_2.56.0              MatrixGenerics_1.8.1       
##  [7] matrixStats_0.62.0          BiocParallel_1.30.4        
##  [9] Rsamtools_2.12.0            Biostrings_2.64.1          
## [11] XVector_0.36.0              GenomicRanges_1.48.0       
## [13] GenomeInfoDb_1.32.4         IRanges_2.30.1             
## [15] S4Vectors_0.34.0            BiocGenerics_0.42.0        
## 
## loaded via a namespace (and not attached):
##  [1] sass_0.4.2             jsonlite_1.8.3         bslib_0.4.0           
##  [4] assertthat_0.2.1       latticeExtra_0.6-30    GenomeInfoDbData_1.2.8
##  [7] yaml_2.3.6             pillar_1.8.1           lattice_0.20-45       
## [10] glue_1.6.2             digest_0.6.30          RColorBrewer_1.1-3    
## [13] colorspace_2.0-3       htmltools_0.5.3        Matrix_1.5-1          
## [16] pkgconfig_2.0.3        bookdown_0.29          zlibbioc_1.42.0       
## [19] scales_1.2.1           jpeg_0.1-9             tibble_3.1.8          
## [22] generics_0.1.3         ggplot2_3.3.6          cachem_1.0.6          
## [25] cli_3.4.1              magrittr_2.0.3         crayon_1.5.2          
## [28] deldir_1.0-6           evaluate_0.17          fs_1.5.2              
## [31] fansi_1.0.3            hwriter_1.3.2.1        blogdown_1.13         
## [34] tools_4.2.1            lifecycle_1.0.3        stringr_1.4.1         
## [37] interp_1.1-3           munsell_0.5.0          DelayedArray_0.22.0   
## [40] compiler_4.2.1         jquerylib_0.1.4        rlang_1.0.6           
## [43] grid_4.2.1             RCurl_1.98-1.9         rstudioapi_0.14       
## [46] htmlwidgets_1.5.4      bitops_1.0-7           rmarkdown_2.17        
## [49] gtable_0.3.1           codetools_0.2-18       DBI_1.1.3             
## [52] R6_2.5.1               knitr_1.40             dplyr_1.0.10          
## [55] fastmap_1.1.0          utf8_1.2.2             stringi_1.7.8         
## [58] parallel_4.2.1         Rcpp_1.0.9             vctrs_0.4.2           
## [61] png_0.1-7              tidyselect_1.2.0       xfun_0.34
```



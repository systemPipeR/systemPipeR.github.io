---
title: "Explore workflow instances" 
date: "Last update: 03 June, 2022" 
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeR: Workflow design and reporting generation environment}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
editor_options: 
  chunk_output_type: console
type: docs
weight: 5
---



We have discussed about how to run/manage a workflow. There 
are many useful methods (functions) of the `SYSargsList`. We have discussed some 
of them in previous secions like, `appendStep`, `addResources`, and more. We 
will be exploring them in details in this section. To get help quickly, use 
`?\`SYSargsList-class\`` to call up the help files. 



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


## Accessor Methods

_`systemPipeR`_ provide several accessor methods and useful functions to explore 
`SYSargsList` workflow object.

Several accessor methods are available that are named after the slot names of
the `SYSargsList` workflow object.


```r
names(sal)
```

```
## [1] "stepsWF"            "statusWF"           "targetsWF"         
## [4] "outfiles"           "SE"                 "dependency"        
## [7] "targets_connection" "projectInfo"        "runInfo"
```

### Check the length of the workflow:


```r
length(sal)
## [1] 5
```

### Extract all steps of the workflow in a list:


```r
stepsWF(sal)
## $load_library
## Instance of 'LineWise'
##     Code Chunk length: 1
## 
## $export_iris
## Instance of 'LineWise'
##     Code Chunk length: 1
## 
## $gzip
## Instance of 'SYSargs2':
##    Slot names/accessors: 
##       targets: 3 (SE...VI), targetsheader: 1 (lines)
##       modules: 0
##       wf: 1, clt: 1, yamlinput: 4 (inputs)
##       input: 3, output: 3
##       cmdlist: 3
##    Sub Steps:
##       1. gzip (rendered: TRUE)
## 
## 
## 
## $gunzip
## Instance of 'SYSargs2':
##    Slot names/accessors: 
##       targets: 3 (SE...VI), targetsheader: 1 (lines)
##       modules: 0
##       wf: 1, clt: 1, yamlinput: 4 (inputs)
##       input: 3, output: 3
##       cmdlist: 3
##    Sub Steps:
##       1. gunzip (rendered: TRUE)
## 
## 
## 
## $stats
## Instance of 'LineWise'
##     Code Chunk length: 5
```

### Checking the command-line for each target sample:

`cmdlist()` method printing the system commands for running command-line
software as specified by a given `*.cwl` file combined with the paths to the
input samples (*e.g.* FASTQ files) provided by a `targets` file. The example below
shows the `cmdlist()` output for running `gzip` and `gunzip` on the first sample. 
Evaluating the output of `cmdlist()` can be very helpful for designing
and debugging `*.cwl` files of new command-line software or changing the
parameter settings of existing ones.


```r
cmdlist(sal, step = c(2,3), targets = 1)
## export_iris step have been dropped because it is not a SYSargs2 object.
## $gzip
## $gzip$SE
## $gzip$SE$gzip
## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"
```

### Check the workflow status:


```r
statusWF(sal)
## $load_library
## DataFrame with 1 row and 2 columns
##           Step status.summary
##    <character>    <character>
## 1 load_library        Pending
## 
## $export_iris
## DataFrame with 1 row and 2 columns
##          Step status.summary
##   <character>    <character>
## 1 export_iris        Pending
## 
## $gzip
## DataFrame with 3 rows and 5 columns
##        Targets Total_Files Existing_Files Missing_Files     gzip
##    <character>   <numeric>      <numeric>     <numeric> <matrix>
## SE          SE           1              0             1  Pending
## VE          VE           1              0             1  Pending
## VI          VI           1              0             1  Pending
## 
## $gunzip
## DataFrame with 3 rows and 5 columns
##        Targets Total_Files Existing_Files Missing_Files   gunzip
##    <character>   <numeric>      <numeric>     <numeric> <matrix>
## SE          SE           1              0             1  Pending
## VE          VE           1              0             1  Pending
## VI          VI           1              0             1  Pending
## 
## $stats
## DataFrame with 1 row and 2 columns
##          Step status.summary
##   <character>    <character>
## 1       stats        Pending
```

### Check the workflow targets files:


```r
targetsWF(sal[2])
## $export_iris
## DataFrame with 0 rows and 0 columns
```

### Checking the expected outfiles files:

The `outfiles` components of `SYSargsList` define the expected outfiles files 
for each step in the workflow, some of which are the input for the next workflow step.


```r
outfiles(sal[2])
## $export_iris
## DataFrame with 0 rows and 0 columns
```

### Check the workflow dependencies:


```r
dependency(sal)
## $load_library
## [1] NA
## 
## $export_iris
## [1] "load_library"
## 
## $gzip
## [1] "export_iris"
## 
## $gunzip
## [1] "gzip"
## 
## $stats
## [1] "gunzip"
```

### Check the sample comparisons:

Sample comparisons are defined in the header lines of the `targets` file 
starting with '``# <CMP>``'. This information can be accessed as follows:


```r
targetsheader(sal, step = "gzip")
## $targetsheader
## [1] "# Project ID: SPR Example gzip"
```

This demo workflow does not have any comparison groups, for a real analysis like 
RNAseq or ChIPseq, comparisons can be defined in the header, like 
[this file](https://raw.githubusercontent.com/tgirke/systemPipeR/master/inst/extdata/targetsPE.txt).

### Get the workflow steps names: 


```r
stepName(sal)
## [1] "load_library" "export_iris"  "gzip"         "gunzip"       "stats"
```

### Get the Sample Id for on particular step:


```r
SampleName(sal, step = "gzip")
## [1] "SE" "VE" "VI"
SampleName(sal, step = "stats")
## NULL
```

### Get the `outfiles` or `targets` column files: 


```r
getColumn(sal, "outfiles", step = "gzip", column = "gzip_file")
##                  SE                  VE                  VI 
## "results/SE.csv.gz" "results/VE.csv.gz" "results/VI.csv.gz"
getColumn(sal, "targetsWF", step = "gzip", column = "FileName")
##                       SE                       VE                       VI 
##     "results/setosa.csv" "results/versicolor.csv"  "results/virginica.csv"
```

### Get the R code for a `LineWise` step:


```r
codeLine(sal, step = "export_iris")
## export_iris
##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))
```

### View all the objects in the running environment:


```r
viewEnvir(sal)
## <environment: 0x55761c0b2b20>
## character(0)
```

### Copy one or multiple objects from the running environment to a new environment:


```r
copyEnvir(sal, list = c("plot"), new.env = globalenv(), silent = FALSE)
## <environment: 0x55761c0b2b20>
## Copying to 'new.env': 
## plot
```

### Accessing the `*.yml` data


```r
yamlinput(sal, step = "gzip")
## $file
## $file$class
## [1] "File"
## 
## $file$path
## [1] "_FILE_PATH_"
## 
## 
## $SampleName
## [1] "_SampleName_"
## 
## $ext
## [1] "csv.gz"
## 
## $results_path
## $results_path$class
## [1] "Directory"
## 
## $results_path$path
## [1] "./results"
```

## Subsetting the workflow details

### The `SYSargsList` class and its subsetting operator `[`:


```r
sal[1]
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. load_library --> Status: Pending
## 
sal[1:3]
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. load_library --> Status: Pending
##        2. export_iris --> Status: Pending
##        3. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          3.1. gzip
##              cmdlist: 3 | Pending: 3
## 
sal[c(1,3)]
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. load_library --> Status: Pending
##        2. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          2.1. gzip
##              cmdlist: 3 | Pending: 3
## 
```

or use a character vector


```r
sal[c("gzip", "stats")]
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          1.1. gzip
##              cmdlist: 3 | Pending: 3
##        2. stats --> Status: Pending
## 
```

### The `SYSargsList` class and its subsetting by steps and input samples: 


```r
sal_sub <- subset(sal, subset_steps = c(3,4), input_targets = ("SE"), keep_steps = TRUE)
stepsWF(sal_sub)
## $load_library
## Instance of 'LineWise'
##     Code Chunk length: 1
## 
## $export_iris
## Instance of 'LineWise'
##     Code Chunk length: 1
## 
## $gzip
## Instance of 'SYSargs2':
##    Slot names/accessors: 
##       targets: 1 (SE...SE), targetsheader: 1 (lines)
##       modules: 0
##       wf: 1, clt: 1, yamlinput: 4 (inputs)
##       input: 1, output: 1
##       cmdlist: 1
##    Sub Steps:
##       1. gzip (rendered: TRUE)
## 
## 
## 
## $gunzip
## Instance of 'SYSargs2':
##    Slot names/accessors: 
##       targets: 1 (SE...SE), targetsheader: 1 (lines)
##       modules: 0
##       wf: 1, clt: 1, yamlinput: 4 (inputs)
##       input: 1, output: 1
##       cmdlist: 1
##    Sub Steps:
##       1. gunzip (rendered: TRUE)
## 
## 
## 
## $stats
## Instance of 'LineWise'
##     Code Chunk length: 5
targetsWF(sal_sub)
## $load_library
## DataFrame with 0 rows and 0 columns
## 
## $export_iris
## DataFrame with 0 rows and 0 columns
## 
## $gzip
## DataFrame with 1 row and 2 columns
##              FileName  SampleName
##           <character> <character>
## SE results/setosa.csv          SE
## 
## $gunzip
## DataFrame with 1 row and 2 columns
##            gzip_file  SampleName
##          <character> <character>
## SE results/SE.csv.gz          SE
## 
## $stats
## DataFrame with 0 rows and 0 columns
outfiles(sal_sub)
## $load_library
## DataFrame with 0 rows and 0 columns
## 
## $export_iris
## DataFrame with 0 rows and 0 columns
## 
## $gzip
## DataFrame with 1 row and 1 column
##           gzip_file
##         <character>
## 1 results/SE.csv.gz
## 
## $gunzip
## DataFrame with 1 row and 1 column
##      gunzip_file
##      <character>
## 1 results/SE.csv
## 
## $stats
## DataFrame with 0 rows and 0 columns
```

In this way, we are only selecting sample `SE` to run in step 3 (gzip) and 4 (gunzip).
Other samples in these steps are removed. 

### The `SYSargsList` class and its operator `+`


```r
sal[1] + sal[2] + sal[3]
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. load_library --> Status: Pending
##        2. export_iris --> Status: Pending
##        3. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          3.1. gzip
##              cmdlist: 3 | Pending: 3
## 
```

## Replacement Methods

### Update a `input` parameter in the workflow


```r
sal_c <- sal
## check values
yamlinput(sal_c, step = "gzip")
## $file
## $file$class
## [1] "File"
## 
## $file$path
## [1] "_FILE_PATH_"
## 
## 
## $SampleName
## [1] "_SampleName_"
## 
## $ext
## [1] "csv.gz"
## 
## $results_path
## $results_path$class
## [1] "Directory"
## 
## $results_path$path
## [1] "./results"
## check on command-line
cmdlist(sal_c, step = "gzip", targets = 1)
## $gzip
## $gzip$SE
## $gzip$SE$gzip
## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"
## Replace
yamlinput(sal_c, step = "gzip", paramName = "ext") <- "txt.gz"

## check NEW values
yamlinput(sal_c, step = "gzip")
## $file
## $file$class
## [1] "File"
## 
## $file$path
## [1] "_FILE_PATH_"
## 
## 
## $SampleName
## [1] "_SampleName_"
## 
## $ext
## [1] "txt.gz"
## 
## $results_path
## $results_path$class
## [1] "Directory"
## 
## $results_path$path
## [1] "./results"
## Check on command-line
cmdlist(sal_c, step = "gzip", targets = 1)
## $gzip
## $gzip$SE
## $gzip$SE$gzip
## [1] "gzip -c  results/setosa.csv > results/SE.txt.gz"
```

Here you can see we replace the yaml input of `"ext"` from `"csv.gz"`
to `"txt.gz"`, so the following rendered command is also changed. In this 
way, we can easily tweak command-line parameters of a certain steps. For example,
we are training a machine learning model, the results are not ideal and we wish to 
increase the iteration numbers. Then we can use similar method above to change 
the iteration parameter and next use `runWF(.., steps = "train_model", force = TRUE)`
to only rerun this step instead of rebuilding the whole workflow and rerun all steps. 


### Append and Replacement methods for R Code Steps


```r
appendCodeLine(sal_c, step = "export_iris", after = 1) <- "log_cal_100 <- log(100)"
codeLine(sal_c, step = "export_iris")
## export_iris
##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))
##     log_cal_100 <- log(100)

replaceCodeLine(sal_c, step="export_iris", line = 2) <- LineWise(code={
                    log_cal_100 <- log(50)
                    })
codeLine(sal_c, step = 1)
## load_library
##     library(systemPipeR)
```



### Rename a Step


```r
renameStep(sal_c, step = 1) <- "newStep"
renameStep(sal_c, c(1, 2)) <- c("newStep2", "newIndex")
sal_c
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. newStep2 --> Status: Pending
##        2. newIndex --> Status: Pending
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
names(outfiles(sal_c))
## [1] "newStep2" "newIndex" "gzip"     "gunzip"   "stats"
names(targetsWF(sal_c))
## [1] "newStep2" "newIndex" "gzip"     "gunzip"   "stats"
dependency(sal_c)
## $newStep2
## [1] NA
## 
## $newIndex
## [1] "newStep2"
## 
## $gzip
## [1] "newIndex"
## 
## $gunzip
## [1] "gzip"
## 
## $stats
## [1] "gunzip"
```

### Replace a Step


```r
sal_test <- sal[c(1,2)]
replaceStep(sal_test, step = 1, step_name = "gunzip" ) <- sal[3]
sal_test
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. gunzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          1.1. gzip
##              cmdlist: 3 | Pending: 3
##        2. export_iris --> Status: Pending
## 
```

Note: Please use this method with attention, because it can disrupt all 
the dependency graphs. 

### Removing a Step


```r
sal_test <- sal[-2]
sal_test
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. load_library --> Status: Pending
##        2. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          2.1. gzip
##              cmdlist: 3 | Pending: 3
##        3. gunzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          3.1. gunzip
##              cmdlist: 3 | Pending: 3
##        4. stats --> Status: Pending
## 
```



## Session 

```r
sessionInfo()
```

```
## R version 4.2.0 (2022-04-22)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.4 LTS
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
##  [1] systemPipeR_2.3.4           ShortRead_1.54.0           
##  [3] GenomicAlignments_1.32.0    SummarizedExperiment_1.26.1
##  [5] Biobase_2.56.0              MatrixGenerics_1.8.0       
##  [7] matrixStats_0.62.0          BiocParallel_1.30.2        
##  [9] Rsamtools_2.12.0            Biostrings_2.64.0          
## [11] XVector_0.36.0              GenomicRanges_1.48.0       
## [13] GenomeInfoDb_1.32.2         IRanges_2.30.0             
## [15] S4Vectors_0.34.0            BiocGenerics_0.42.0        
## 
## loaded via a namespace (and not attached):
##  [1] lattice_0.20-45        png_0.1-7              assertthat_0.2.1      
##  [4] digest_0.6.29          utf8_1.2.2             R6_2.5.1              
##  [7] evaluate_0.15          ggplot2_3.3.6          blogdown_1.10         
## [10] pillar_1.7.0           zlibbioc_1.42.0        rlang_1.0.2           
## [13] rstudioapi_0.13        jquerylib_0.1.4        Matrix_1.4-1          
## [16] rmarkdown_2.14         stringr_1.4.0          htmlwidgets_1.5.4     
## [19] RCurl_1.98-1.6         munsell_0.5.0          DelayedArray_0.22.0   
## [22] compiler_4.2.0         xfun_0.31              pkgconfig_2.0.3       
## [25] htmltools_0.5.2        tidyselect_1.1.2       tibble_3.1.7          
## [28] GenomeInfoDbData_1.2.8 bookdown_0.26          fansi_1.0.3           
## [31] dplyr_1.0.9            crayon_1.5.1           bitops_1.0-7          
## [34] grid_4.2.0             DBI_1.1.2              jsonlite_1.8.0        
## [37] gtable_0.3.0           lifecycle_1.0.1        magrittr_2.0.3        
## [40] scales_1.2.0           cli_3.3.0              stringi_1.7.6         
## [43] hwriter_1.3.2.1        latticeExtra_0.6-29    bslib_0.3.1           
## [46] generics_0.1.2         ellipsis_0.3.2         vctrs_0.4.1           
## [49] RColorBrewer_1.1-3     tools_4.2.0            glue_1.6.2            
## [52] purrr_0.3.4            jpeg_0.1-9             parallel_4.2.0        
## [55] fastmap_1.1.0          yaml_2.3.5             colorspace_2.0-3      
## [58] knitr_1.39             sass_0.4.1
```



---
title: "Build workflow interactively" 
fontsize: 14pt
editor_options: 
  chunk_output_type: console
type: docs
weight: 1
---

<!--
- Compile from command-line
Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeR.Rmd', tangle=TRUE)"; Rscript ../md2jekyll.R systemPipeR.knit.md 2; Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::pdf_document'))"
-->

To start, we use the same workflow instance like the last [section](..).
 




```r
sal <- SPRproject(logs.dir= ".SPRproject", sys.file=".SPRproject/SYSargsList.yml") 
```


```
## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/data 
## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/param 
## Creating directory:  /home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/results 
## Creating directory '/home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/.SPRproject'
## Creating file '/home/lab/Desktop/spr/systemPipeR.github.io/content/en/sp/spr/sp_run/.SPRproject/SYSargsList.yml'
```



```r
sal
```

```
## Instance of 'SYSargsList': 
##  No workflow steps added
```

### Adding the first step 

The first step is R code based, and we are splitting the `iris` dataset by `Species`
and for each `Species` will be saved on file. Please note that this code will
not be executed now; it is just store in the container for further execution. 

This constructor function requires the `step_name` and the R-based code under 
the `code` argument. 
The R code should be enclosed by braces (`{}`) and separated by a new line. 


```r
appendStep(sal) <- LineWise(code = {
                              mapply(function(x, y) write.csv(x, y),
                                     split(iris, factor(iris$Species)),
                                     file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv"))
                                     ) 
                            },
                            step_name = "export_iris")
```

For a brief overview of the workflow, we can check the object as follows:


```r
sal
```

```
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. export_iris --> Status: Pending
## 
```

Also, for printing and double-check the R code in the step, we can use the 
`codeLine` method:


```r
codeLine(sal)
```

```
## export_iris
##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))
```

### Adding more steps

Next, an example of how to compress the exported files using 
[`gzip`](https://www.gnu.org/software/gzip/) command-line. 

The constructor function creates an `SYSargsList` S4 class object using data from
three input files:

    - CWL command-line specification file (`wf_file` argument);
    - Input variables (`input_file` argument);
    - Targets file (`targets` argument).

In CWL, files with the extension `.cwl` define the parameters of a chosen
command-line step or workflow, while files with the extension `.yml` define the
input variables of command-line steps. 

The `targets` file is optional for workflow steps lacking `input` files. The connection 
between `input` variables and the `targets` file is defined under the `inputvars` 
argument. It is required a `named vector`, where each element name needs to match
with column names in the `targets` file, and the value must match the names of 
the `input` variables defined in the `*.yml` files (see Figure <a href="#fig:sprandCWL"><strong>??</strong></a>). 

A detailed description of the dynamic between `input` variables and `targets` 
files can be found [here](#cwl_targets). 
In addition, the CWL syntax overview can be found [here](#cwl). 

Besides all the data form `targets`, `wf_file`, `input_file` and `dir_path` arguments,
`SYSargsList` constructor function options include: 

  - `step_name`: a unique *name* for the step. This is not mandatory; however, 
    it is highly recommended. If no name is provided, a default `step_x`, where
    `x` reflects the step index, will be added. 
  - `dir`: this option allows creating an exclusive subdirectory for the step 
    in the workflow. All the outfiles and log files for this particular step will 
    be generated in the respective folders.
  - `dependency`: after the first step, all the additional steps appended to 
    the workflow require the information of the dependency tree. 

The `appendStep<-` method is used to append a new step in the workflow.


```r
targetspath <- system.file("extdata/cwl/gunzip", "targets_gunzip.txt", package = "systemPipeR")
appendStep(sal) <- SYSargsList(step_name = "gzip", 
                      targets = targetspath, dir = TRUE,
                      wf_file = "gunzip/workflow_gzip.cwl", input_file = "gunzip/gzip.yml",
                      dir_path = system.file("extdata/cwl", package = "systemPipeR"),
                      inputvars = c(FileName = "_FILE_PATH_", SampleName = "_SampleName_"), 
                      dependency = "export_iris")
```

Note: This will not work if the `gzip` is not available on your system 
(installed and exported to PATH) and may only work on Windows systems using PowerShell. 

For a overview of the workflow, we can check the object as follows:


```r
sal
```

```
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. export_iris --> Status: Pending
##        2. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          2.1. gzip
##              cmdlist: 3 | Pending: 3
## 
```

Note that we have two steps, and it is expected three files from the second step.
Also, the workflow status is *Pending*, which means the workflow object is 
rendered in R; however, we did not execute the workflow yet. 
In addition to this summary, it can be observed this step has three command lines. 

For more details about the command-line rendered for each target file, it can be 
checked as follows: 


```r
cmdlist(sal, step = "gzip")
```

```
## $gzip
## $gzip$SE
## $gzip$SE$gzip
## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"
## 
## 
## $gzip$VE
## $gzip$VE$gzip
## [1] "gzip -c  results/versicolor.csv > results/VE.csv.gz"
## 
## 
## $gzip$VI
## $gzip$VI$gzip
## [1] "gzip -c  results/virginica.csv > results/VI.csv.gz"
```

#### Using the `outfiles` for the next step

For building this step, all the previous procedures are being used to append the 
next step. However, here, we can observe power features that build the 
connectivity between steps in the workflow.

In this example, we would like to use the outfiles from *gzip* Step, as
input from the next step, which is the *gunzip*. In this case, let's look at the 
outfiles from the first step:


```r
outfiles(sal)
```

```
## $export_iris
## DataFrame with 0 rows and 0 columns
## 
## $gzip
## DataFrame with 3 rows and 1 column
##            gzip_file
##          <character>
## SE results/SE.csv.gz
## VE results/VE.csv.gz
## VI results/VI.csv.gz
```

The column we want to use is "gzip_file". For the argument `targets` in the 
`SYSargsList` function, it should provide the name of the correspondent step in
the Workflow and which `outfiles` you would like to be incorporated in the next 
step. 
The argument `inputvars` allows the connectivity between `outfiles` and the 
new `targets` file. Here, the name of the previous `outfiles` should be provided 
it. Please note that all `outfiles` column names must be unique.

It is possible to keep all the original columns from the `targets` files or remove
some columns for a clean `targets` file.
The argument `rm_targets_col` provides this flexibility, where it is possible to
specify the names of the columns that should be removed. If no names are passing
here, the new columns will be appended. 


```r
appendStep(sal) <- SYSargsList(step_name = "gunzip", 
                      targets = "gzip", dir = TRUE,
                      wf_file = "gunzip/workflow_gunzip.cwl", input_file = "gunzip/gunzip.yml",
                      dir_path = system.file("extdata/cwl", package = "systemPipeR"),
                      inputvars = c(gzip_file = "_FILE_PATH_", SampleName = "_SampleName_"), 
                      rm_targets_col = "FileName", 
                      dependency = "gzip")
```

We can check the targets automatically create for this step, 
based on the previous `outfiles`:


```r
targetsWF(sal[3])
```

```
## $gunzip
## DataFrame with 3 rows and 2 columns
##            gzip_file  SampleName
##          <character> <character>
## SE results/SE.csv.gz          SE
## VE results/VE.csv.gz          VE
## VI results/VI.csv.gz          VI
```

We can also check all the expected `outfiles` for this particular step, as follows:


```r
outfiles(sal[3])
```

```
## $gunzip
## DataFrame with 3 rows and 1 column
##       gunzip_file
##       <character>
## SE results/SE.csv
## VE results/VE.csv
## VI results/VI.csv
```

Now, we can observe that the third step has been added and contains one substep.


```r
sal
```

```
## Instance of 'SYSargsList': 
##     WF Steps:
##        1. export_iris --> Status: Pending
##        2. gzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          2.1. gzip
##              cmdlist: 3 | Pending: 3
##        3. gunzip --> Status: Pending 
##            Total Files: 3 | Existing: 0 | Missing: 3 
##          3.1. gunzip
##              cmdlist: 3 | Pending: 3
## 
```

In addition, we can access all the command lines for each one of the substeps. 


```r
cmdlist(sal["gzip"], targets = 1)
```

```
## $gzip
## $gzip$SE
## $gzip$SE$gzip
## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"
```

#### Getting data from a workflow instance 

The final step in this simple workflow is an R code step. For that, we are using
the `LineWise` constructor function as demonstrated above. 

One interesting feature showed here is the `getColumn` method that allows 
extracting the information for a workflow instance. Those files can be used in
an R code, as demonstrated below. 


```r
getColumn(sal, step = "gunzip", 'outfiles')
```

```
##               SE               VE               VI 
## "results/SE.csv" "results/VE.csv" "results/VI.csv"
```


```r
appendStep(sal) <- LineWise(code = {
                    df <- lapply(getColumn(sal, step = "gunzip", 'outfiles'), function(x) read.delim(x, sep = ",")[-1])
                    df <- do.call(rbind, df)
                    stats <- data.frame(cbind(mean = apply(df[,1:4], 2, mean), sd = apply(df[,1:4], 2, sd)))
                    stats$species <- rownames(stats)
                    
                    plot <- ggplot2::ggplot(stats, ggplot2::aes(x = species, y = mean, fill = species)) + 
                      ggplot2::geom_bar(stat = "identity", color = "black", position = ggplot2::position_dodge()) +
                      ggplot2::geom_errorbar(ggplot2::aes(ymin = mean-sd, ymax = mean+sd), width = .2, position = ggplot2::position_dodge(.9)) 
                    },
                    step_name = "iris_stats", 
                    dependency = "gzip")
```


# Session 

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


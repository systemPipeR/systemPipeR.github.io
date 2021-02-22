---
title: "Workflow Templates" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 21 February, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeR: Workflow design and reporting generation environment}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex.bib
editor_options: 
  chunk_output_type: console
type: docs
weight: 5
---

<!--
- Compile from command-line
Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeR.Rmd', tangle=TRUE)"; Rscript ../md2jekyll.R systemPipeR.knit.md 2; Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::pdf_document'))"
-->
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("h1").className = "title";
});
</script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  var links = document.links;  
  for (var i = 0, linksLength = links.length; i < linksLength; i++)
    if (links[i].hostname != window.location.hostname)
      links[i].target = '_blank';
});
</script>

# Workflow templates

The intended way of running *`systemPipeR`* workflows is via *`*.Rmd`* files, which
can be executed either line-wise in interactive mode or with a single command from
R or the command-line. This way comprehensive and reproducible analysis reports
can be generated in PDF or HTML format in a fully automated manner by making use
of the highly functional reporting utilities available for R.
The following shows how to execute a workflow (*e.g.*, systemPipeRNAseq.Rmd)
from the command-line.

``` bash
Rscript -e "rmarkdown::render('systemPipeRNAseq.Rmd')"
```

Templates for setting up custom project reports are provided as *`*.Rmd`* files by the helper package *`systemPipeRdata`* and in the vignettes subdirectory of *`systemPipeR`*. The corresponding HTML of these report templates are available here: [*`systemPipeRNAseq`*](http://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRNAseq.html), [*`systemPipeRIBOseq`*](http://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRIBOseq.html), [*`systemPipeChIPseq`*](http://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeChIPseq.html) and [*`systemPipeVARseq`*](http://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeVARseq.html). To work with *`*.Rnw`* or *`*.Rmd`* files efficiently, basic knowledge of [*`Sweave`*](https://www.stat.uni-muenchen.de/~leisch/Sweave/) or [*`knitr`*](http://yihui.name/knitr/) and [*`Latex`*](http://www.latex-project.org/) or [*`R Markdown v2`*](http://rmarkdown.rstudio.com/) is required.

## RNA-Seq sample

Load the RNA-Seq sample workflow into your current working directory.

``` r
library(systemPipeRdata)
genWorkenvir(workflow = "rnaseq")
setwd("rnaseq")
```

### Run workflow

Next, run the chosen sample workflow *`systemPipeRNAseq`* ([PDF](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/rnaseq/systemPipeRNAseq.pdf?raw=true), [Rmd](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/rnaseq/systemPipeRNAseq.Rmd)) by executing from the command-line *`make -B`* within the *`rnaseq`* directory. Alternatively, one can run the code from the provided *`*.Rmd`* template file from within R interactively.

The workflow includes following steps:

1.  Read preprocessing
    -   Quality filtering (trimming)
    -   FASTQ quality report
2.  Alignments: *`Tophat2`* (or any other RNA-Seq aligner)
3.  Alignment stats
4.  Read counting
5.  Sample-wise correlation analysis
6.  Analysis of differentially expressed genes (DEGs)
7.  GO term enrichment analysis
8.  Gene-wise clustering

## ChIP-Seq sample

Load the ChIP-Seq sample workflow into your current working directory.

``` r
library(systemPipeRdata)
genWorkenvir(workflow = "chipseq")
setwd("chipseq")
```

### Run workflow

Next, run the chosen sample workflow *`systemPipeChIPseq_single`* ([PDF](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/chipseq/systemPipeChIPseq.pdf?raw=true), [Rmd](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/chipseq/systemPipeChIPseq.Rmd)) by executing from the command-line *`make -B`* within the *`chipseq`* directory. Alternatively, one can run the code from the provided *`*.Rmd`* template file from within R interactively.

The workflow includes the following steps:

1.  Read preprocessing
    -   Quality filtering (trimming)
    -   FASTQ quality report
2.  Alignments: *`Bowtie2`* or *`rsubread`*
3.  Alignment stats
4.  Peak calling: *`MACS2`*, *`BayesPeak`*
5.  Peak annotation with genomic context
6.  Differential binding analysis
7.  GO term enrichment analysis
8.  Motif analysis

## VAR-Seq sample

### VAR-Seq workflow for the single machine

Load the VAR-Seq sample workflow into your current working directory.

``` r
library(systemPipeRdata)
genWorkenvir(workflow = "varseq")
setwd("varseq")
```

### Run workflow

Next, run the chosen sample workflow *`systemPipeVARseq_single`* ([PDF](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/varseq/systemPipeVARseq_single.pdf?raw=true), [Rmd](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/varseq/systemPipeVARseq_single.Rmd)) by executing from the command-line *`make -B`* within the *`varseq`* directory. Alternatively, one can run the code from the provided *`*.Rmd`* template file from within R interactively.

The workflow includes following steps:

1.  Read preprocessing
    -   Quality filtering (trimming)
    -   FASTQ quality report
2.  Alignments: *`gsnap`*, *`bwa`*
3.  Variant calling: *`VariantTools`*, *`GATK`*, *`BCFtools`*
4.  Variant filtering: *`VariantTools`* and *`VariantAnnotation`*
5.  Variant annotation: *`VariantAnnotation`*
6.  Combine results from many samples
7.  Summary statistics of samples

### VAR-Seq workflow for computer cluster

The workflow template provided for this step is called *`systemPipeVARseq.Rmd`* ([PDF](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/varseq/systemPipeVARseq.pdf?raw=true), [Rmd](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/varseq/systemPipeVARseq.Rmd)).
It runs the above VAR-Seq workflow in parallel on multiple compute nodes of an HPC system using Slurm as the scheduler.

## Ribo-Seq sample

Load the Ribo-Seq sample workflow into your current working directory.

``` r
library(systemPipeRdata)
genWorkenvir(workflow = "riboseq")
setwd("riboseq")
```

### Run workflow

Next, run the chosen sample workflow *`systemPipeRIBOseq`* ([PDF](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/riboseq/systemPipeRIBOseq.pdf?raw=true), [Rmd](https://github.com/tgirke/systemPipeRdata/blob/master/inst/extdata/workflows/ribseq/systemPipeRIBOseq.Rmd)) by executing from the command-line *`make -B`* within the *`ribseq`* directory. Alternatively, one can run the code from the provided *`*.Rmd`* template file from within R interactively.

The workflow includes following steps:

1.  Read preprocessing
    -   Adaptor trimming and quality filtering
    -   FASTQ quality report
2.  Alignments: *`Tophat2`* (or any other RNA-Seq aligner)
3.  Alignment stats
4.  Compute read distribution across genomic features
5.  Adding custom features to the workflow (e.g. uORFs)
6.  Genomic read coverage along with transcripts
7.  Read counting
8.  Sample-wise correlation analysis
9.  Analysis of differentially expressed genes (DEGs)
10. GO term enrichment analysis
11. Gene-wise clustering
12. Differential ribosome binding (translational efficiency)

# Version information

**Note:** the most recent version of this tutorial can be found <a href="http://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html">here</a>.

``` r
sessionInfo()
```

    ## R version 4.0.3 (2020-10-10)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.2 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
    ## LAPACK: /home/dcassol/src/R-4.0.3/lib/libRlapack.so
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
    ## [1] stats4    parallel  stats     graphics  grDevices utils     datasets 
    ## [8] methods   base     
    ## 
    ## other attached packages:
    ##  [1] magrittr_2.0.1              batchtools_0.9.15          
    ##  [3] ape_5.4-1                   ggplot2_3.3.3              
    ##  [5] systemPipeR_1.25.6          ShortRead_1.48.0           
    ##  [7] GenomicAlignments_1.26.0    SummarizedExperiment_1.20.0
    ##  [9] Biobase_2.50.0              MatrixGenerics_1.2.1       
    ## [11] matrixStats_0.58.0          BiocParallel_1.24.1        
    ## [13] Rsamtools_2.6.0             Biostrings_2.58.0          
    ## [15] XVector_0.30.0              GenomicRanges_1.42.0       
    ## [17] GenomeInfoDb_1.26.2         IRanges_2.24.1             
    ## [19] S4Vectors_0.28.1            BiocGenerics_0.36.0        
    ## [21] BiocStyle_2.18.1           
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] colorspace_2.0-0         rjson_0.2.20             hwriter_1.3.2           
    ##   [4] ellipsis_0.3.1           bit64_4.0.5              AnnotationDbi_1.52.0    
    ##   [7] xml2_1.3.2               codetools_0.2-18         splines_4.0.3           
    ##  [10] cachem_1.0.3             knitr_1.31               jsonlite_1.7.2          
    ##  [13] annotate_1.68.0          GO.db_3.12.1             dbplyr_2.1.0            
    ##  [16] png_0.1-7                pheatmap_1.0.12          graph_1.68.0            
    ##  [19] BiocManager_1.30.10      compiler_4.0.3           httr_1.4.2              
    ##  [22] GOstats_2.56.0           backports_1.2.1          assertthat_0.2.1        
    ##  [25] Matrix_1.3-2             fastmap_1.1.0            limma_3.46.0            
    ##  [28] formatR_1.7              htmltools_0.5.1.1        prettyunits_1.1.1       
    ##  [31] tools_4.0.3              gtable_0.3.0             glue_1.4.2              
    ##  [34] GenomeInfoDbData_1.2.4   Category_2.56.0          dplyr_1.0.4             
    ##  [37] rsvg_2.1                 rappdirs_0.3.3           V8_3.4.0                
    ##  [40] Rcpp_1.0.6               vctrs_0.3.6              nlme_3.1-152            
    ##  [43] blogdown_1.1.7           rtracklayer_1.50.0       xfun_0.21               
    ##  [46] stringr_1.4.0            lifecycle_1.0.0.9000     XML_3.99-0.5            
    ##  [49] edgeR_3.32.1             zlibbioc_1.36.0          scales_1.1.1            
    ##  [52] BSgenome_1.58.0          VariantAnnotation_1.36.0 hms_1.0.0               
    ##  [55] RBGL_1.66.0              RColorBrewer_1.1-2       yaml_2.2.1              
    ##  [58] curl_4.3                 memoise_2.0.0            biomaRt_2.46.3          
    ##  [61] latticeExtra_0.6-29      stringi_1.5.3            RSQLite_2.2.3           
    ##  [64] genefilter_1.72.1        checkmate_2.0.0          GenomicFeatures_1.42.1  
    ##  [67] DOT_0.1                  rlang_0.4.10             pkgconfig_2.0.3         
    ##  [70] bitops_1.0-6             evaluate_0.14            lattice_0.20-41         
    ##  [73] purrr_0.3.4              bit_4.0.4                tidyselect_1.1.0        
    ##  [76] GSEABase_1.52.1          AnnotationForge_1.32.0   bookdown_0.21           
    ##  [79] R6_2.5.0                 generics_0.1.0           base64url_1.4           
    ##  [82] DelayedArray_0.16.1      DBI_1.1.1                withr_2.4.1             
    ##  [85] pillar_1.4.7             survival_3.2-7           RCurl_1.98-1.2          
    ##  [88] tibble_3.0.6             crayon_1.4.1             BiocFileCache_1.14.0    
    ##  [91] rmarkdown_2.6            jpeg_0.1-8.1             progress_1.2.2          
    ##  [94] locfit_1.5-9.4           grid_4.0.3               data.table_1.13.6       
    ##  [97] blob_1.2.1               Rgraphviz_2.34.0         digest_0.6.27           
    ## [100] xtable_1.8-4             brew_1.0-6               openssl_1.4.3           
    ## [103] munsell_0.5.0            askpass_1.1

# References

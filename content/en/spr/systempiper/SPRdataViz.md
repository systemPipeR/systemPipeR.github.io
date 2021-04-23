---
title: "SPR Data Visualization" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 20 April, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeR: Data Visualizations}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex.bib
type: docs
weight: 5
---

<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/datatables-binding/datatables.js"></script>
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.min.css" rel="stylesheet" />
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.extra.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-core/js/jquery.dataTables.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-fixedcolumns/css/fixedColumns.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-fixedcolumns/js/dataTables.fixedColumns.min.js"></script>
<link href="/rmarkdown-libs/dt-ext-scroller/css/scroller.dataTables.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-ext-scroller/js/dataTables.scroller.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/plotly-binding/plotly.js"></script>
<script src="/rmarkdown-libs/typedarray/typedarray.min.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
<link href="/rmarkdown-libs/plotly-htmlwidgets-css/plotly-htmlwidgets.css" rel="stylesheet" />
<script src="/rmarkdown-libs/plotly-main/plotly-latest.min.js"></script>
<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/plotly-binding/plotly.js"></script>
<script src="/rmarkdown-libs/typedarray/typedarray.min.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
<link href="/rmarkdown-libs/plotly-htmlwidgets-css/plotly-htmlwidgets.css" rel="stylesheet" />
<script src="/rmarkdown-libs/plotly-main/plotly-latest.min.js"></script>
<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/plotly-binding/plotly.js"></script>
<script src="/rmarkdown-libs/typedarray/typedarray.min.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
<link href="/rmarkdown-libs/plotly-htmlwidgets-css/plotly-htmlwidgets.css" rel="stylesheet" />
<script src="/rmarkdown-libs/plotly-main/plotly-latest.min.js"></script>
<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/plotly-binding/plotly.js"></script>
<script src="/rmarkdown-libs/typedarray/typedarray.min.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
<link href="/rmarkdown-libs/plotly-htmlwidgets-css/plotly-htmlwidgets.css" rel="stylesheet" />
<script src="/rmarkdown-libs/plotly-main/plotly-latest.min.js"></script>
<style type="text/css">
pre code {
white-space: pre !important;
overflow-x: scroll !important;
word-break: keep-all !important;
word-wrap: initial !important;
}
</style>
<!--
- Compile from command-line
Rscript -e "rmarkdown::render('systemPipeR_dataViz.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeR_dataViz.Rmd', tangle=TRUE)"; Rscript ../md2jekyll.R systemPipeR.knit.md 2; Rscript -e "rmarkdown::render('systemPipeR_dataViz.Rmd', c('BiocStyle::pdf_document'))"
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

# Data Visualization with `systemPipeR`

## Metadata and Reads Counting Information

The first step is importing the `targets` file and raw reads counting table.
- The `targets` file defines all FASTQ files and sample comparisons of the analysis workflow.
- The raw reads counting table represents all the reads that map to gene (row) for each sample (columns).

``` r
## Targets file
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
targets <- read.delim(targetspath, comment = "#")
cmp <- systemPipeR::readComp(file = targetspath, format = "matrix", delim = "-")
## Count table file
countMatrixPath <- system.file("extdata", "countDFeByg.xls", package = "systemPipeR")
countMatrix <- read.delim(countMatrixPath, row.names = 1)
systemPipeR::showDT(targets)
```

<div id="htmlwidget-1" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"filter":"none","extensions":["FixedColumns","Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["./data/SRR446027_1.fastq.gz","./data/SRR446028_1.fastq.gz","./data/SRR446029_1.fastq.gz","./data/SRR446030_1.fastq.gz","./data/SRR446031_1.fastq.gz","./data/SRR446032_1.fastq.gz","./data/SRR446033_1.fastq.gz","./data/SRR446034_1.fastq.gz","./data/SRR446035_1.fastq.gz","./data/SRR446036_1.fastq.gz","./data/SRR446037_1.fastq.gz","./data/SRR446038_1.fastq.gz","./data/SRR446039_1.fastq.gz","./data/SRR446040_1.fastq.gz","./data/SRR446041_1.fastq.gz","./data/SRR446042_1.fastq.gz","./data/SRR446043_1.fastq.gz","./data/SRR446044_1.fastq.gz"],["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],["M1","M1","A1","A1","V1","V1","M6","M6","A6","A6","V6","V6","M12","M12","A12","A12","V12","V12"],["Mock.1h.A","Mock.1h.B","Avr.1h.A","Avr.1h.B","Vir.1h.A","Vir.1h.B","Mock.6h.A","Mock.6h.B","Avr.6h.A","Avr.6h.B","Vir.6h.A","Vir.6h.B","Mock.12h.A","Mock.12h.B","Avr.12h.A","Avr.12h.B","Vir.12h.A","Vir.12h.B"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],["23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012","23-Mar-2012"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>FileName<\/th>\n      <th>SampleName<\/th>\n      <th>Factor<\/th>\n      <th>SampleLong<\/th>\n      <th>Experiment<\/th>\n      <th>Date<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"scrollX":true,"fixedColumns":true,"deferRender":true,"scrollY":200,"scroller":true,"columnDefs":[{"className":"dt-right","targets":5},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

``` r
head(countMatrix)
```

    ##           M1A M1B A1A A1B V1A V1B M6A M6B A6A A6B V6A  V6B M12A M12B A12A A12B
    ## AT1G01010  57 244 201 169 365 229  41  38 152  46 294  405  117  139  132   64
    ## AT1G01020  23  93  69 126 107  88  18  25  20   5  88  151   43   74   33   18
    ## AT1G01030  41  98  73  58  94 156   9  13   8   6  36  147   32   29   12    9
    ## AT1G01040 180 684 522 664 585 680 162 163 249  66 697 1060  338  604  360   80
    ## AT1G01050  60 127 102 166 125 303 116 180 139  37 236  679  362  746  194   50
    ## AT1G01060  26 264  59  56   8  26   5   2   0   0   0    4   89  203  118   24
    ##           V12A V12B
    ## AT1G01010  230  120
    ## AT1G01020   43   31
    ## AT1G01030   70   85
    ## AT1G01040  203  171
    ## AT1G01050  214  181
    ## AT1G01060   62   32

## Data Transformation

For gene differential expression, raw counts are required, however for data
visualization or clustering, it can be useful to work with transformed count data.
`exploreDDS` function is convenience wrapper to transform raw read counts using the
[`DESeq2`](@Love2014-sh) package transformations methods. The input file
has to contain all the genes, not just differentially expressed ones.

``` r
exploredds <- exploreDDS(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL, 
    transformationMethod = "rlog")
exploredds
```

    ## class: DESeqTransform 
    ## dim: 116 18 
    ## metadata(1): version
    ## assays(1): ''
    ## rownames(116): AT1G01010 AT1G01020 ... ATMG00180 ATMG00200
    ## rowData names(51): baseMean baseVar ... dispFit rlogIntercept
    ## colnames(18): M1A M1B ... V12A V12B
    ## colData names(2): condition sizeFactor

Users are strongly encouraged to consult the [`DESeq2`](@Love2014-sh) vignette for
more detailed information on this topic and how to properly run `DESeq2` on data
sets with more complex experimental designs.

## Scatterplot

To decide which transformation to choose, we can visualize the transformation effect
comparing two samples or a grid of all samples, as follows:

``` r
exploreDDSplot(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL, samples = c("M12A", 
    "A12A"), scattermatrix = FALSE)
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/exploreDDSplot-1.png" width="672" />

``` r
exploreDDSplot(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL, samples = c("M12A", 
    "M12A", "A12A", "A12A"), scattermatrix = TRUE)
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/exploreDDSplot-2.png" width="672" />

The scatterplots are created using the log2 transform normalized reads count,
variance stabilizing transformation (VST) (Anders and Huber 2010), and regularized-logarithm transformation
or `rlog` (Love, Huber, and Anders 2014).

## Hierarchical Clustering Dendrogram

The following computes the sample-wise correlation coefficients using the `stats::cor()`
function from the transformed expression values. After transformation to a distance matrix,
hierarchical clustering is performed with the `stats::hclust` function and the
result is plotted as a dendrogram, as follows:

``` r
hclustplot(exploredds, method = "spearman", savePlot = TRUE, filePlot = "cor.png")
```

    ## Saving 5.6 x 4 in image

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/hclustplot-1.png" width="672" />

![](cor.png)

The function provides the utility to save the plot automatically.

## Hierarchical Clustering HeatMap

This function performs hierarchical clustering on the transformed expression matrix
generated within the `DESeq2` package. It uses, by default, a `Pearson` correlation-based distance
measure and complete linkage for cluster join.
If `samples` selected in the `clust` argument, it will be applied the `stats::dist()`
function to the transformed count matrix to get sample-to-sample distances. Also,
it is possible to generate the `pheatmap` or `plotly` plot format.

``` r
## Samples plot
heatMaplot(exploredds, clust = "samples")
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/heatMaplot_samples-1.png" width="672" />

``` r
heatMaplot(exploredds, clust = "samples", plotly = TRUE)
```

<div id="htmlwidget-2" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-2">{"x":{"visdat":{"183f768656e97":["function () ","plotlyVisDat"]},"cur_data":"183f768656e97","attrs":{"183f768656e97":{"x":["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],"y":["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],"z":[[0,7.04650716301563,5.70678310405774,8.20976445672658,5.82667776225818,7.3279781790244,8.39986657356742,8.16733063204217,9.58637200173571,7.68841587215867,10.1640441508758,10.7676019921496,10.0039632569807,11.32498784981,9.8146750121175,7.74473230078491,9.45716343166999,7.95378561107353],[7.04650716301563,0,6.66154862259465,4.25865887783483,6.67960023884926,6.26668680998727,9.91630309634838,9.25451827523275,10.9564120825428,9.93575571094716,11.099388064366,10.6754670535994,9.90683653800534,10.9561298226477,10.7399675586854,9.18116169782986,9.77109863659917,9.40323019102986],[5.70678310405774,6.66154862259465,0,7.98994675562316,4.94593038167375,5.72836463615867,8.11235158724083,7.65256178153187,8.15065142907597,8.76007256265634,8.30988507282082,8.91309701678265,8.66629724080143,9.82426010379448,8.30870129249907,8.54268071001664,8.35323474316893,7.70897398227057],[8.20976445672658,4.25865887783483,7.98994675562316,0,6.99532785790822,6.43469620310431,10.4096764476556,9.51652950962973,11.1939050957909,10.4627147426448,11.1689702900908,10.546647320753,10.5708484745604,11.5547562063225,11.6160197603858,9.88406363111819,10.7020155017471,10.4675703563444],[5.82667776225818,6.67960023884926,4.94593038167375,6.99532785790822,0,4.8575131388009,8.46288752842871,8.0319315058583,8.726172089783,8.73161790330149,8.27286514155669,8.88152783442813,9.62675093908279,10.8109068917939,9.50867890759956,8.56129430593498,9.21166728284744,8.48571139105286],[7.3279781790244,6.26668680998727,5.72836463615867,6.43469620310431,4.8575131388009,0,10.051631844146,8.92833694901717,9.88801350128227,10.1968579735558,9.80606329541741,9.47694677716336,10.2032985748696,10.9502439173503,10.7118343889731,10.2485736407499,9.95124988126944,9.6455696901528],[8.39986657356742,9.91630309634838,8.11235158724083,10.4096764476556,8.46288752842871,10.051631844146,0,4.32289188181976,5.45401419571659,6.66929785847857,5.82333805363524,6.89960979808065,6.60846441830892,7.49378480640748,6.09490379797155,6.92856692552639,6.73658240504653,6.04084631483171],[8.16733063204217,9.25451827523275,7.65256178153187,9.51652950962973,8.0319315058583,8.92833694901717,4.32289188181976,0,5.86548263173596,6.92170483627566,6.43771467140554,5.936553276735,6.66918890392232,7.10201521498403,6.87338305585792,7.70858313971616,6.93977726065822,6.12205683109543],[9.58637200173571,10.9564120825428,8.15065142907597,11.1939050957909,8.726172089783,9.88801350128227,5.45401419571659,5.86548263173596,0,8.10337075683393,4.02970654063498,6.37598537189006,6.96355226928132,7.79890861008178,5.50539366529938,8.64913887544163,6.82883422186719,6.22801929982399],[7.68841587215867,9.93575571094716,8.76007256265634,10.4627147426448,8.73161790330149,10.1968579735558,6.66929785847857,6.92170483627566,8.10337075683393,0,9.22853479532283,10.1030591897721,9.35527845594351,11.0912154866989,8.92785474831708,6.32121021712703,9.14034499886722,7.20502415178336],[10.1640441508758,11.099388064366,8.30988507282082,11.1689702900908,8.27286514155669,9.80606329541741,5.82333805363524,6.43771467140554,4.02970654063498,9.22853479532283,0,5.40796455622463,7.23562402229216,8.05893271349359,5.83000947413891,8.94623155465764,6.52802367477244,6.94139936721835],[10.7676019921496,10.6754670535994,8.91309701678265,10.546647320753,8.88152783442813,9.47694677716336,6.89960979808065,5.936553276735,6.37598537189006,10.1030591897721,5.40796455622463,0,7.14309602773391,6.1610771391521,7.4911181113735,10.0381028337193,7.56298264238769,7.68916986877059],[10.0039632569807,9.90683653800534,8.66629724080143,10.5708484745604,9.62675093908279,10.2032985748696,6.60846441830892,6.66918890392232,6.96355226928132,9.35527845594351,7.23562402229216,7.14309602773391,0,5.69259437645614,5.58694500597765,8.50447659713418,5.53119139458227,6.33933832045536],[11.32498784981,10.9561298226477,9.82426010379448,11.5547562063225,10.8109068917939,10.9502439173503,7.49378480640748,7.10201521498403,7.79890861008178,11.0912154866989,8.05893271349359,6.1610771391521,5.69259437645614,0,6.42494730487994,10.5078546330517,7.19994521380774,7.82561653509729],[9.8146750121175,10.7399675586854,8.30870129249907,11.6160197603858,9.50867890759956,10.7118343889731,6.09490379797155,6.87338305585792,5.50539366529938,8.92785474831708,5.83000947413891,7.4911181113735,5.58694500597765,6.42494730487994,0,8.18110233128943,5.25899641633563,5.72577800197228],[7.74473230078491,9.18116169782986,8.54268071001664,9.88406363111819,8.56129430593498,10.2485736407499,6.92856692552639,7.70858313971616,8.64913887544163,6.32121021712703,8.94623155465764,10.0381028337193,8.50447659713418,10.5078546330517,8.18110233128943,0,7.99272460895717,6.58008064549415],[9.45716343166999,9.77109863659917,8.35323474316893,10.7020155017471,9.21166728284744,9.95124988126944,6.73658240504653,6.93977726065822,6.82883422186719,9.14034499886722,6.52802367477244,7.56298264238769,5.53119139458227,7.19994521380774,5.25899641633563,7.99272460895717,0,5.56397338345294],[7.95378561107353,9.40323019102986,7.70897398227057,10.4675703563444,8.48571139105286,9.6455696901528,6.04084631483171,6.12205683109543,6.22801929982399,7.20502415178336,6.94139936721835,7.68916986877059,6.33933832045536,7.82561653509729,5.72577800197228,6.58008064549415,5.56397338345294,0]],"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"heatmap"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":[]},"yaxis":{"domain":[0,1],"automargin":true,"title":[]},"scene":{"zaxis":{"title":[]}},"hovermode":"closest","showlegend":false,"legend":{"yanchor":"top","y":0.5}},"source":"A","config":{"showSendToCloud":false},"data":[{"colorbar":{"title":"","ticklen":2,"len":0.5,"lenmode":"fraction","y":1,"yanchor":"top"},"colorscale":[["0","rgba(68,1,84,1)"],["0.0416666666666667","rgba(70,19,97,1)"],["0.0833333333333333","rgba(72,32,111,1)"],["0.125","rgba(71,45,122,1)"],["0.166666666666667","rgba(68,58,128,1)"],["0.208333333333333","rgba(64,70,135,1)"],["0.25","rgba(60,82,138,1)"],["0.291666666666667","rgba(56,93,140,1)"],["0.333333333333333","rgba(49,104,142,1)"],["0.375","rgba(46,114,142,1)"],["0.416666666666667","rgba(42,123,142,1)"],["0.458333333333333","rgba(38,133,141,1)"],["0.5","rgba(37,144,140,1)"],["0.541666666666667","rgba(33,154,138,1)"],["0.583333333333333","rgba(39,164,133,1)"],["0.625","rgba(47,174,127,1)"],["0.666666666666667","rgba(53,183,121,1)"],["0.708333333333333","rgba(79,191,110,1)"],["0.75","rgba(98,199,98,1)"],["0.791666666666667","rgba(119,207,85,1)"],["0.833333333333333","rgba(147,214,70,1)"],["0.875","rgba(172,220,52,1)"],["0.916666666666667","rgba(199,225,42,1)"],["0.958333333333333","rgba(226,228,40,1)"],["1","rgba(253,231,37,1)"]],"showscale":true,"x":["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],"y":["M1A","M1B","A1A","A1B","V1A","V1B","M6A","M6B","A6A","A6B","V6A","V6B","M12A","M12B","A12A","A12B","V12A","V12B"],"z":[[0,7.04650716301563,5.70678310405774,8.20976445672658,5.82667776225818,7.3279781790244,8.39986657356742,8.16733063204217,9.58637200173571,7.68841587215867,10.1640441508758,10.7676019921496,10.0039632569807,11.32498784981,9.8146750121175,7.74473230078491,9.45716343166999,7.95378561107353],[7.04650716301563,0,6.66154862259465,4.25865887783483,6.67960023884926,6.26668680998727,9.91630309634838,9.25451827523275,10.9564120825428,9.93575571094716,11.099388064366,10.6754670535994,9.90683653800534,10.9561298226477,10.7399675586854,9.18116169782986,9.77109863659917,9.40323019102986],[5.70678310405774,6.66154862259465,0,7.98994675562316,4.94593038167375,5.72836463615867,8.11235158724083,7.65256178153187,8.15065142907597,8.76007256265634,8.30988507282082,8.91309701678265,8.66629724080143,9.82426010379448,8.30870129249907,8.54268071001664,8.35323474316893,7.70897398227057],[8.20976445672658,4.25865887783483,7.98994675562316,0,6.99532785790822,6.43469620310431,10.4096764476556,9.51652950962973,11.1939050957909,10.4627147426448,11.1689702900908,10.546647320753,10.5708484745604,11.5547562063225,11.6160197603858,9.88406363111819,10.7020155017471,10.4675703563444],[5.82667776225818,6.67960023884926,4.94593038167375,6.99532785790822,0,4.8575131388009,8.46288752842871,8.0319315058583,8.726172089783,8.73161790330149,8.27286514155669,8.88152783442813,9.62675093908279,10.8109068917939,9.50867890759956,8.56129430593498,9.21166728284744,8.48571139105286],[7.3279781790244,6.26668680998727,5.72836463615867,6.43469620310431,4.8575131388009,0,10.051631844146,8.92833694901717,9.88801350128227,10.1968579735558,9.80606329541741,9.47694677716336,10.2032985748696,10.9502439173503,10.7118343889731,10.2485736407499,9.95124988126944,9.6455696901528],[8.39986657356742,9.91630309634838,8.11235158724083,10.4096764476556,8.46288752842871,10.051631844146,0,4.32289188181976,5.45401419571659,6.66929785847857,5.82333805363524,6.89960979808065,6.60846441830892,7.49378480640748,6.09490379797155,6.92856692552639,6.73658240504653,6.04084631483171],[8.16733063204217,9.25451827523275,7.65256178153187,9.51652950962973,8.0319315058583,8.92833694901717,4.32289188181976,0,5.86548263173596,6.92170483627566,6.43771467140554,5.936553276735,6.66918890392232,7.10201521498403,6.87338305585792,7.70858313971616,6.93977726065822,6.12205683109543],[9.58637200173571,10.9564120825428,8.15065142907597,11.1939050957909,8.726172089783,9.88801350128227,5.45401419571659,5.86548263173596,0,8.10337075683393,4.02970654063498,6.37598537189006,6.96355226928132,7.79890861008178,5.50539366529938,8.64913887544163,6.82883422186719,6.22801929982399],[7.68841587215867,9.93575571094716,8.76007256265634,10.4627147426448,8.73161790330149,10.1968579735558,6.66929785847857,6.92170483627566,8.10337075683393,0,9.22853479532283,10.1030591897721,9.35527845594351,11.0912154866989,8.92785474831708,6.32121021712703,9.14034499886722,7.20502415178336],[10.1640441508758,11.099388064366,8.30988507282082,11.1689702900908,8.27286514155669,9.80606329541741,5.82333805363524,6.43771467140554,4.02970654063498,9.22853479532283,0,5.40796455622463,7.23562402229216,8.05893271349359,5.83000947413891,8.94623155465764,6.52802367477244,6.94139936721835],[10.7676019921496,10.6754670535994,8.91309701678265,10.546647320753,8.88152783442813,9.47694677716336,6.89960979808065,5.936553276735,6.37598537189006,10.1030591897721,5.40796455622463,0,7.14309602773391,6.1610771391521,7.4911181113735,10.0381028337193,7.56298264238769,7.68916986877059],[10.0039632569807,9.90683653800534,8.66629724080143,10.5708484745604,9.62675093908279,10.2032985748696,6.60846441830892,6.66918890392232,6.96355226928132,9.35527845594351,7.23562402229216,7.14309602773391,0,5.69259437645614,5.58694500597765,8.50447659713418,5.53119139458227,6.33933832045536],[11.32498784981,10.9561298226477,9.82426010379448,11.5547562063225,10.8109068917939,10.9502439173503,7.49378480640748,7.10201521498403,7.79890861008178,11.0912154866989,8.05893271349359,6.1610771391521,5.69259437645614,0,6.42494730487994,10.5078546330517,7.19994521380774,7.82561653509729],[9.8146750121175,10.7399675586854,8.30870129249907,11.6160197603858,9.50867890759956,10.7118343889731,6.09490379797155,6.87338305585792,5.50539366529938,8.92785474831708,5.83000947413891,7.4911181113735,5.58694500597765,6.42494730487994,0,8.18110233128943,5.25899641633563,5.72577800197228],[7.74473230078491,9.18116169782986,8.54268071001664,9.88406363111819,8.56129430593498,10.2485736407499,6.92856692552639,7.70858313971616,8.64913887544163,6.32121021712703,8.94623155465764,10.0381028337193,8.50447659713418,10.5078546330517,8.18110233128943,0,7.99272460895717,6.58008064549415],[9.45716343166999,9.77109863659917,8.35323474316893,10.7020155017471,9.21166728284744,9.95124988126944,6.73658240504653,6.93977726065822,6.82883422186719,9.14034499886722,6.52802367477244,7.56298264238769,5.53119139458227,7.19994521380774,5.25899641633563,7.99272460895717,0,5.56397338345294],[7.95378561107353,9.40323019102986,7.70897398227057,10.4675703563444,8.48571139105286,9.6455696901528,6.04084631483171,6.12205683109543,6.22801929982399,7.20502415178336,6.94139936721835,7.68916986877059,6.33933832045536,7.82561653509729,5.72577800197228,6.58008064549415,5.56397338345294,0]],"type":"heatmap","xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

If `ind` selected in the `clust` argument, it is necessary to provide the list of
differentially expressed genes for the `exploredds` subset.

``` r
## Individuals genes identified in DEG analysis DEG analysis with `systemPipeR`
degseqDF <- systemPipeR::run_DESeq2(countDF = countMatrix, targets = targets, cmp = cmp[[1]], 
    independent = FALSE)
```

    ## Warning in DESeqDataSet(se, design = design, ignoreRank): some variables in
    ## design formula are characters, converting to factors

``` r
DEG_list <- systemPipeR::filterDEGs(degDF = degseqDF, filter = c(Fold = 2, FDR = 10))
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/heatMaplot_DEG-1.png" width="672" />

``` r
### Plot
heatMaplot(exploredds, clust = "ind", DEGlist = unique(as.character(unlist(DEG_list[[1]]))))
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/heatMaplot_DEG-2.png" width="672" />

The function provides the utility to save the plot automatically.

## Principal Component Analysis

This function plots a Principal Component Analysis (PCA) from transformed expression
matrix. This plot shows samples variation based on the expression values and identifies
batch effects.

``` r
PCAplot(exploredds, plotly = TRUE, save = TRUE, filePlot = "PCAplot.png")
```

    ## Saving 7 x 5 in image

<div id="htmlwidget-3" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-3">{"x":{"data":[{"x":[-3.03168381476885,-6.03412691707515],"y":[-0.535073099413187,-2.0971750907225],"text":["colour: A1<br />PC1: -3.0316838<br />PC2: -0.5350731","colour: A1<br />PC1: -6.0341269<br />PC2: -2.0971751"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(248,118,109,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)"}},"hoveron":"points","name":"A1","legendgroup":"A1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[3.88869312311426,-0.383756141678079],"y":[0.0701335027868824,4.53821439195817],"text":["colour: A12<br />PC1:  3.8886931<br />PC2:  0.0701335","colour: A12<br />PC1: -0.3837561<br />PC2:  4.5382144"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(211,146,0,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(211,146,0,1)"}},"hoveron":"points","name":"A12","legendgroup":"A12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[3.28184331604165,-0.416809087724184],"y":[0.185372641000547,5.30010399483779],"text":["colour: A6<br />PC1:  3.2818433<br />PC2:  0.1853726","colour: A6<br />PC1: -0.4168091<br />PC2:  5.3001040"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(147,170,0,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(147,170,0,1)"}},"hoveron":"points","name":"A6","legendgroup":"A6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[-4.23478929449673,-5.72288504075975],"y":[2.46441944072604,-1.3362445127839],"text":["colour: M1<br />PC1: -4.2347893<br />PC2:  2.4644194","colour: M1<br />PC1: -5.7228850<br />PC2: -1.3362445"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,186,56,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,186,56,1)"}},"hoveron":"points","name":"M1","legendgroup":"M1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[3.08219911545694,4.0916538760623],"y":[-1.26931397709069,-3.52388688937858],"text":["colour: M12<br />PC1:  3.0821991<br />PC2: -1.2693140","colour: M12<br />PC1:  4.0916539<br />PC2: -3.5238869"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,193,159,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,193,159,1)"}},"hoveron":"points","name":"M12","legendgroup":"M12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[2.40175386965523,1.53523865252027],"y":[1.67449958551854,0.392038639964049],"text":["colour: M6<br />PC1:  2.4017539<br />PC2:  1.6744996","colour: M6<br />PC1:  1.5352387<br />PC2:  0.3920386"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,185,227,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,185,227,1)"}},"hoveron":"points","name":"M6","legendgroup":"M6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[-4.10114199086997,-5.13397514161901],"y":[-0.524772724724376,-2.59419479868824],"text":["colour: V1<br />PC1: -4.1011420<br />PC2: -0.5247727","colour: V1<br />PC1: -5.1339751<br />PC2: -2.5941948"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(97,156,255,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(97,156,255,1)"}},"hoveron":"points","name":"V1","legendgroup":"V1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[2.70779870992001,1.85669227563915],"y":[-0.325101355885941,1.77346995606566],"text":["colour: V12<br />PC1:  2.7077987<br />PC2: -0.3251014","colour: V12<br />PC1:  1.8566923<br />PC2:  1.7734700"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(219,114,251,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(219,114,251,1)"}},"hoveron":"points","name":"V12","legendgroup":"V12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[3.29098889669914,2.92230559388278],"y":[-0.928463576912153,-3.26402612725811],"text":["colour: V6<br />PC1:  3.2909889<br />PC2: -0.9284636","colour: V6<br />PC1:  2.9223056<br />PC2: -3.2640261"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(255,97,195,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(255,97,195,1)"}},"hoveron":"points","name":"V6","legendgroup":"V6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":37.2602739726027},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Principal Component Analysis (PCA)","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-6.54041595673202,4.59794291571917],"tickmode":"array","ticktext":["-6","-4","-2","0","2","4"],"tickvals":[-6,-4,-2,0,2,4],"categoryorder":"array","categoryarray":["-6","-4","-2","0","2","4"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"PC1: 39% variance","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"scaleanchor":"y","scaleratio":1,"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-3.9650864335894,5.74130353904861],"tickmode":"array","ticktext":["-2","0","2","4"],"tickvals":[-2,0,2,4],"categoryorder":"array","categoryarray":["-2","0","2","4"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"PC2: 17% variance","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"scaleanchor":"x","scaleratio":1,"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.96751968503937},"annotations":[{"text":"colour","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"183f736a3aeed":{"colour":{},"x":{},"y":{},"type":"scatter"}},"cur_data":"183f736a3aeed","visdat":{"183f736a3aeed":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

![](PCAplot.png)

The function provides the utility to save the plot automatically.

## Multidimensional scaling with `MDSplot`

This function computes and plots multidimensional scaling analysis for dimension
reduction of count expression matrix. Internally, it is applied the `stats::dist()`
function to the transformed count matrix to get sample-to-sample distances.

``` r
MDSplot(exploredds, plotly = TRUE, save = TRUE, filePlot = "MDSplot.png")
```

    ## Saving 7 x 5 in image

<div id="htmlwidget-4" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-4">{"x":{"data":[{"x":[-0.0385691257375645,-0.0756465550222067],"y":[0.0121348112883654,-0.0263185211619564],"text":["colour: A1<br />X1: -0.0385691257<br />X2: -0.0121348113","colour: A1<br />X1: -0.0756465550<br />X2:  0.0263185212"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(248,118,109,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)"}},"hoveron":"points","name":"A1","legendgroup":"A1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[0.0471312515186602,-0.000702385152090552],"y":[-0.00846046530513539,0.0179460735463539],"text":["colour: A12<br />X1:  0.0471312515<br />X2:  0.0084604653","colour: A12<br />X1: -0.0007023852<br />X2: -0.0179460735"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(211,146,0,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(211,146,0,1)"}},"hoveron":"points","name":"A12","legendgroup":"A12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[0.0358833473747432,-0.00698971620844441],"y":[0.00545825889678074,0.0218008001814644],"text":["colour: A6<br />X1:  0.0358833474<br />X2: -0.0054582589","colour: A6<br />X1: -0.0069897162<br />X2: -0.0218008002"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(147,170,0,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(147,170,0,1)"}},"hoveron":"points","name":"A6","legendgroup":"A6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[-0.0555141654157414,-0.0695498036732859],"y":[0.0118604318806951,-0.0241184563060315],"text":["colour: M1<br />X1: -0.0555141654<br />X2: -0.0118604319","colour: M1<br />X1: -0.0695498037<br />X2:  0.0241184563"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,186,56,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,186,56,1)"}},"hoveron":"points","name":"M1","legendgroup":"M1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[0.0388440472952876,0.0478911346735303],"y":[-0.0117752224280402,-0.0330674144060864],"text":["colour: M12<br />X1:  0.0388440473<br />X2:  0.0117752224","colour: M12<br />X1:  0.0478911347<br />X2:  0.0330674144"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,193,159,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,193,159,1)"}},"hoveron":"points","name":"M12","legendgroup":"M12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[0.0336430182081294,0.0247109258766723],"y":[0.011533547712276,0.0102886348222388],"text":["colour: M6<br />X1:  0.0336430182<br />X2: -0.0115335477","colour: M6<br />X1:  0.0247109259<br />X2: -0.0102886348"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,185,227,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,185,227,1)"}},"hoveron":"points","name":"M6","legendgroup":"M6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[-0.049148445393543,-0.0588363893574552],"y":[0.0135847221710498,-0.000110011861092134],"text":["colour: V1<br />X1: -0.0491484454<br />X2: -0.0135847222","colour: V1<br />X1: -0.0588363894<br />X2:  0.0001100119"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(97,156,255,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(97,156,255,1)"}},"hoveron":"points","name":"V1","legendgroup":"V1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[0.030330635804856,0.0260585388758099],"y":[-0.0116374454684681,0.015319846717863],"text":["colour: V12<br />X1:  0.0303306358<br />X2:  0.0116374455","colour: V12<br />X1:  0.0260585389<br />X2: -0.0153198467"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(219,114,251,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(219,114,251,1)"}},"hoveron":"points","name":"V12","legendgroup":"V12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[0.0348355992486336,0.0356280870840091],"y":[0.00266781598250113,-0.00710740626277818],"text":["colour: V6<br />X1:  0.0348355992<br />X2: -0.0026678160","colour: V6<br />X1:  0.0356280871<br />X2:  0.0071074063"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(255,97,195,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(255,97,195,1)"}},"hoveron":"points","name":"V6","legendgroup":"V6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":54.7945205479452},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Multidimensional Scaling (MDS)","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-0.0818234395069935,0.0540680191583172],"tickmode":"array","ticktext":["-0.075","-0.050","-0.025","0.000","0.025","0.050"],"tickvals":[-0.075,-0.05,-0.025,0,0.025,0.05],"categoryorder":"array","categoryarray":["-0.075","-0.050","-0.025","0.000","0.025","0.050"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"X1","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-0.0358108251354639,0.0245442109108419],"tickmode":"array","ticktext":["-0.02","0.00","0.02"],"tickvals":[0.02,0,-0.02],"categoryorder":"array","categoryarray":["-0.02","0.00","0.02"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"X2","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.96751968503937},"annotations":[{"text":"colour","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"183f747fcefeb":{"colour":{},"x":{},"y":{},"type":"scatter"}},"cur_data":"183f747fcefeb","visdat":{"183f747fcefeb":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

The function provides the utility to save the plot automatically.

## Dimension Reduction with `GLMplot`

This function computes and plots generalized principal components analysis for
dimension reduction of count expression matrix.

``` r
exploredds <- exploreDDS(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL, 
    transformationMethod = "raw")
```

    ## Warning in DESeqDataSet(se, design = design, ignoreRank): some variables in
    ## design formula are characters, converting to factors

``` r
GLMplot(exploredds, plotly = TRUE)
```

<div id="htmlwidget-5" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-5">{"x":{"data":[{"x":[-2.98246193775229,-11.1995631939151],"y":[1.08054237785685,-1.80486283679573],"text":["Samples: A1<br />dim1:  -2.98246194<br />dim2:  1.0805424","Samples: A1<br />dim1: -11.19956319<br />dim2: -1.8048628"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(248,118,109,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)"}},"hoveron":"points","name":"A1","legendgroup":"A1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[6.77009982284712,-2.90177989583962],"y":[-0.334806148434798,6.81973533867811],"text":["Samples: A12<br />dim1:   6.77009982<br />dim2: -0.3348061","Samples: A12<br />dim1:  -2.90177990<br />dim2:  6.8197353"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(211,146,0,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(211,146,0,1)"}},"hoveron":"points","name":"A12","legendgroup":"A12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[5.82567217643932,4.02326613215582],"y":[-0.272181639853457,5.22371838572104],"text":["Samples: A6<br />dim1:   5.82567218<br />dim2: -0.2721816","Samples: A6<br />dim1:   4.02326613<br />dim2:  5.2237184"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(147,170,0,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(147,170,0,1)"}},"hoveron":"points","name":"A6","legendgroup":"A6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[-1.90356810084558,-10.1442223824312],"y":[5.5061121810527,0.185451003199279],"text":["Samples: M1<br />dim1:  -1.90356810<br />dim2:  5.5061122","Samples: M1<br />dim1: -10.14422238<br />dim2:  0.1854510"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,186,56,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,186,56,1)"}},"hoveron":"points","name":"M1","legendgroup":"M1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[3.71342644880976,1.64793948933061],"y":[-2.87597277573363,-7.55759524547694],"text":["Samples: M12<br />dim1:   3.71342645<br />dim2: -2.8759728","Samples: M12<br />dim1:   1.64793949<br />dim2: -7.5575952"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,193,159,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,193,159,1)"}},"hoveron":"points","name":"M12","legendgroup":"M12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[5.39405476672273,5.35287386970579],"y":[2.81541924848648,1.37065269428376],"text":["Samples: M6<br />dim1:   5.39405477<br />dim2:  2.8154192","Samples: M6<br />dim1:   5.35287387<br />dim2:  1.3706527"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,185,227,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,185,227,1)"}},"hoveron":"points","name":"M6","legendgroup":"M6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[-7.67858494649502,-10.9739292602958],"y":[0.866353676014889,-3.40218236579063],"text":["Samples: V1<br />dim1:  -7.67858495<br />dim2:  0.8663537","Samples: V1<br />dim1: -10.97392926<br />dim2: -3.4021824"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(97,156,255,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(97,156,255,1)"}},"hoveron":"points","name":"V1","legendgroup":"V1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[5.22586269819975,4.66851541189112],"y":[0.523656077092424,2.29412753010815],"text":["Samples: V12<br />dim1:   5.22586270<br />dim2:  0.5236561","Samples: V12<br />dim1:   4.66851541<br />dim2:  2.2941275"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(219,114,251,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(219,114,251,1)"}},"hoveron":"points","name":"V12","legendgroup":"V12","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[5.20506836107594,-0.0426694596034132],"y":[-2.47367847132066,-7.96448902908784],"text":["Samples: V6<br />dim1:   5.20506836<br />dim2: -2.4736785","Samples: V6<br />dim1:  -0.04266946<br />dim2: -7.9644890"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(255,97,195,1)","opacity":1,"size":11.3385826771654,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(255,97,195,1)"}},"hoveron":"points","name":"V6","legendgroup":"V6","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":37.2602739726027},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Generalized PCA (GLM-PCA)","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-12.0980463447532,7.66858297368523],"tickmode":"array","ticktext":["-12","-8","-4","0","4"],"tickvals":[-12,-8,-4,0,4],"categoryorder":"array","categoryarray":["-12","-8","-4","0","4"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"dim1","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"scaleanchor":"y","scaleratio":1,"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-8.70370024747614,7.55894655706641],"tickmode":"array","ticktext":["-8","-4","0","4"],"tickvals":[-8,-4,0,4],"categoryorder":"array","categoryarray":["-8","-4","0","4"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"dim2","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"scaleanchor":"x","scaleratio":1,"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.96751968503937},"annotations":[{"text":"Samples","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"183f7d994e3f":{"colour":{},"x":{},"y":{},"type":"scatter"}},"cur_data":"183f7d994e3f","visdat":{"183f7d994e3f":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

The function provides the utility to save the plot automatically.

## MA plot

This function plots log2 fold changes (y-axis) versus the mean of normalized counts
(on the x-axis). Statistically significant features are colored.

``` r
MAplot(degseqDF, FDR.cutoff = 0.05, comparison = "M12-A12", filter = c(Fold = 2, 
    FDR = 10), genes = "ATCG00280")
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/MAplot-1.png" width="672" />

The function provides the utility to save the plot automatically.

## t-Distributed Stochastic Neighbor embedding with `tSNEplot`

This function computes and plots t-Distributed Stochastic Neighbor embedding (t-SNE)
analysis for unsupervised nonlinear dimensionality reduction of count expression
matrix. Internally, it is applied the `Rtsne::Rtsne()` function, using the exact
t-SNE computing with `theta=0.0`.

``` r
tSNEplot(countMatrix, targets, perplexity = 5)
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/tSNEplot-1.png" width="672" />

## Volcano plot

A simple function that shows statistical significance (`p-value`) versus magnitude
of change (`log2 fold change`).

``` r
volcanoplot(degseqDF, comparison = "M12-A12", filter = c(Fold = 1, FDR = 20), genes = "ATCG00280")
```

<img src="/en/spr/systempiper/SPRdataViz_files/figure-html/volcanoplot-1.png" width="672" />

# Version information

``` r
sessionInfo()
```

    ## R Under development (unstable) (2021-02-04 r79940)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.2 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
    ## LAPACK: /home/dcassol/src/R-devel/lib/libRlapack.so
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
    ##  [1] systemPipeR_1.25.12         ShortRead_1.49.2           
    ##  [3] GenomicAlignments_1.27.2    SummarizedExperiment_1.21.3
    ##  [5] Biobase_2.51.0              MatrixGenerics_1.3.1       
    ##  [7] matrixStats_0.58.0          BiocParallel_1.25.5        
    ##  [9] Rsamtools_2.7.2             Biostrings_2.59.2          
    ## [11] XVector_0.31.1              GenomicRanges_1.43.4       
    ## [13] GenomeInfoDb_1.27.11        IRanges_2.25.8             
    ## [15] S4Vectors_0.29.15           BiocGenerics_0.37.1        
    ## [17] BiocStyle_2.19.2           
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] backports_1.2.1          BiocFileCache_1.99.5     plyr_1.8.6              
    ##   [4] lazyeval_0.2.2           splines_4.1.0            crosstalk_1.1.1         
    ##   [7] ggplot2_3.3.3            digest_0.6.27            htmltools_0.5.1.1       
    ##  [10] fansi_0.4.2              magrittr_2.0.1           checkmate_2.0.0         
    ##  [13] memoise_2.0.0            BSgenome_1.59.2          base64url_1.4           
    ##  [16] limma_3.47.12            annotate_1.69.2          prettyunits_1.1.1       
    ##  [19] jpeg_0.1-8.1             colorspace_2.0-0         blob_1.2.1              
    ##  [22] rappdirs_0.3.3           ggrepel_0.9.1            xfun_0.22               
    ##  [25] dplyr_1.0.5              hexbin_1.28.2            crayon_1.4.1            
    ##  [28] RCurl_1.98-1.3           jsonlite_1.7.2           genefilter_1.73.1       
    ##  [31] VariantAnnotation_1.37.1 brew_1.0-6               survival_3.2-10         
    ##  [34] ape_5.4-1                glue_1.4.2               gtable_0.3.0            
    ##  [37] zlibbioc_1.37.0          DelayedArray_0.17.10     V8_3.4.0                
    ##  [40] scales_1.1.1             pheatmap_1.0.12          DBI_1.1.1               
    ##  [43] GGally_2.1.1             edgeR_3.33.3             Rcpp_1.0.6              
    ##  [46] viridisLite_0.4.0        xtable_1.8-4             progress_1.2.2          
    ##  [49] tidytree_0.3.3           bit_4.0.4                DT_0.18                 
    ##  [52] rsvg_2.1                 htmlwidgets_1.5.3        httr_1.4.2              
    ##  [55] RColorBrewer_1.1-2       ellipsis_0.3.1           farver_2.1.0            
    ##  [58] pkgconfig_2.0.3          reshape_0.8.8            XML_3.99-0.6            
    ##  [61] sass_0.3.1               dbplyr_2.1.1             locfit_1.5-9.4          
    ##  [64] utf8_1.2.1               labeling_0.4.2           later_1.1.0.1           
    ##  [67] tidyselect_1.1.0         rlang_0.4.10             AnnotationDbi_1.53.1    
    ##  [70] munsell_0.5.0            tools_4.1.0              cachem_1.0.4            
    ##  [73] generics_0.1.0           RSQLite_2.2.6            evaluate_0.14           
    ##  [76] stringr_1.4.0            fastmap_1.1.0            yaml_2.2.1              
    ##  [79] ggtree_2.5.2             knitr_1.32               bit64_4.0.5             
    ##  [82] purrr_0.3.4              KEGGREST_1.31.1          nlme_3.1-152            
    ##  [85] mime_0.10                formatR_1.9              aplot_0.0.6             
    ##  [88] biomaRt_2.47.7           compiler_4.1.0           plotly_4.9.3            
    ##  [91] filelock_1.0.2           curl_4.3                 png_0.1-7               
    ##  [94] treeio_1.15.6            tibble_3.1.0             geneplotter_1.69.0      
    ##  [97] bslib_0.2.4              stringi_1.5.3            highr_0.8               
    ## [100] blogdown_1.3             GenomicFeatures_1.43.8   lattice_0.20-41         
    ## [103] Matrix_1.3-2             glmpca_0.2.0             vctrs_0.3.7             
    ## [106] pillar_1.6.0             lifecycle_1.0.0          BiocManager_1.30.12     
    ## [109] jquerylib_0.1.3          data.table_1.14.0        bitops_1.0-6            
    ## [112] httpuv_1.5.5             patchwork_1.1.1          rtracklayer_1.51.5      
    ## [115] R6_2.5.0                 BiocIO_1.1.2             latticeExtra_0.6-29     
    ## [118] hwriter_1.3.2            promises_1.2.0.1         bookdown_0.21           
    ## [121] codetools_0.2-18         MASS_7.3-53.1            assertthat_0.2.1        
    ## [124] DESeq2_1.31.18           rjson_0.2.20             withr_2.4.1             
    ## [127] batchtools_0.9.15        GenomeInfoDbData_1.2.4   hms_1.0.0               
    ## [130] grid_4.1.0               tidyr_1.1.3              DOT_0.1                 
    ## [133] rmarkdown_2.7            rvcheck_0.1.8            Rtsne_0.15              
    ## [136] shiny_1.6.0              restfulr_0.0.13

# Funding

This project is funded by NSF award [ABI-1661152](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1661152).

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Anders2010-tp" class="csl-entry">

Anders, Simon, and Wolfgang Huber. 2010. “Differential Expression Analysis for Sequence Count Data.” *Genome Biol.* 11 (10): R106.

</div>

<div id="ref-Love2014-sh" class="csl-entry">

Love, Michael, Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for <span class="nocase">RNA-seq</span> Data with DESeq2.” *Genome Biol.* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.

</div>

</div>
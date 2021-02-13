---
title: "Configuration"
linkTitle: "Configuration"
type: docs
weight: 1
---
*****
## Config SPS

Let us start by creating an example SPS project. For demo purpose, we are using the 
`/tmp` folder but one should use a regular location instead of the temp in a  real 
case.


```r
suppressPackageStartupMessages(library(systemPipeShiny))
spsInit(app_path = tempdir(), project_name = "config_demo", overwrite = TRUE, change_wd = FALSE)
```

```
## [SPS-INFO] 2021-02-12 17:56:02 Start to create a new SPS project
```

```
## [SPS-INFO] 2021-02-12 17:56:02 Create project under /tmp/Rtmp3dzki3/config_demo
```

```
## [SPS-INFO] 2021-02-12 17:56:02 Now copy files
```

```
## [SPS-INFO] 2021-02-12 17:56:03 Create SPS database
```

```
## [SPS-INFO] 2021-02-12 17:56:03 Created SPS database method container
```

```
## [SPS-INFO] 2021-02-12 17:56:03 Creating SPS db...
```

```
## [SPS-DANGER] 2021-02-12 17:56:03 Db created at '/tmp/Rtmp3dzki3/config_demo/config/sps.db'. DO NOT share this file with others
## [SPS-INFO] 2021-02-12 17:56:03 Key md5 ade535c7b129259899081ba344c1b843
## [SPS-INFO] 2021-02-12 17:56:03 SPS project setup done!
```

```r
## save project path 
(sps_dir <- file.path(tempdir(), "config_demo"))
```

```
## [1] "/tmp/Rtmp3dzki3/config_demo"
```

To reproduce code locally, run the following chunk instead. 


```r
library(systemPipeShiny)
spsInit()
sps_dir <- normalizePath(".")
```


## SPS structure

<pre>
SPS_xx/  
├── server.R               <span class="text-success">|</span> 
├── global.R               <span class="text-success">| Most important server, UI and global files, unless special needs, `global.R` is the only file you need to edit manually</span>   
├── ui.R                   <span class="text-success">|</span>  
├── deploy.R               <span class="text-info">| Deploy helper file</span>  
├── config                 <span class="text-success">| Important app config files. Do not edit them if you don't know</span>  
│   ├── sps.db             <span class="text-gray">| SPS database</span> 
│   ├── sps_options.yaml   <span class="text-gray">| SPS default option list</span> 
│   └── tabs.csv           <span class="text-gray">| SPS tab information</span> 
├── data                   <span class="text-primary">| App example data files</span> 
│   ├── xx.csv             
├── R                      <span class="text-primary">| All SPS additional tab files and helper R function files</span> 
│   ├── tab_xx.R            
├── README.md              
├── results                <span class="text-gray">| Not in use for this current version, you can store some data been generated from the app</span> 
│   └── README.md          
└── www                    <span class="text-primary">| Internet resources</span>  
    ├── about              <span class="text-gray">| About tab information</span> 
    │   └── xx.md          
    ├── css                <span class="text-info">| CSS files</span>  
    │   └── sps.css         
    ├── img                <span class="text-info">| App image resources</span>    
    │   └── xx.png         
    ├── js                 <span class="text-info">| Javascripts</span>
    │   └── xx.js           
    ├── loading_themes     <span class="text-info">| Loading screen files</span> 
    │   └── xx.html         
    └── plot_list          <span class="text-info">| Image files for plot gallery</span>  
        └── plot_xx.jpg      
</pre>

This is a reminder of what you will get when a SPS project is initiated with `spsInit()`.

1. For most users, the `global.R` file is the only file that one needs to make change.
2. The second important files are the files inside `config` folder. For normal users,
these files are controlled by SPS functions. No need to make any modification. For advanced users, deep customization 
is possible. Please read the [Developer sections](/sps/dev/).
    - `sps_options.yaml` stores all default and valid values for SPS.
    - `tabs.csv` all SPS tab registration information.
    - `sps.db` A SQLite database to store data generated in SPS. Since we have 
      the new Canvas module which is purely client-side served, this database is not 
      heavily used. However, it provides you some tables storing project information and 
      a SHA key pair in case you want to encrypt password or files. Read [Developer sections](/sps/dev/)
      for more information.
3. `R` folder stores all custom tab files, your helper functions. This `.R` or `.r` files under this 
folder **will be automatically sourced** when SPS starts.
4. `www` folder is where you add the internet resources, like images you want to show in 
the app, `css` style sheets to attach. Read more [here](https://stevenmortimer.com/tips-for-making-professional-shiny-apps-with-r/#create-a-www-folder).

    
## App options

App options in SPS are controlled by "SPS options". These options can change 
app appearance, debugging level, server behaviors, *etc*. The valid options can 
be found and change on the `global.R` file. They are similar to *Shiny* options, 
but unlike *shiny* options are single values, SPS options are passed using the `Option(sps = list(...))` 
function in `global.R` as a group. To view all options and their default, valid
values('*' means any value is okay). All the options are listed in `global.R` from 
the line starting with *## SPS options*. We provided some comments below that line to 
generally describe what each option is and valid values for options. Use function 
`viewSpsDefaults` to see the default and other valid options. 


```r
viewSpsDefaults(app_path = sps_dir)
```

```
## mode: list(default = "local", other = "server")
##  loading_screen: list(default = TRUE, other = FALSE)
##  loading_theme: list(default = "vhelix", other = "*")
##  use_crayon: list(default = TRUE, other = FALSE)
##  verbose: list(default = FALSE, other = TRUE)
##  admin_page: list(default = FALSE, other = TRUE)
##  admin_url: list(default = "admin", other = "*")
##  warning_toast: list(default = TRUE, other = FALSE)
##  module_wf: list(default = TRUE, other = FALSE)
##  module_rnaseq: list(default = TRUE, other = FALSE)
##  module_ggplot: list(default = TRUE, other = FALSE)
```

Options are first set in `global.R` with these following lines, and you can change
their values. 


```r
options(sps = list(
    mode = "server",
    warning_toast = FALSE,
    loading_screen = TRUE,
    loading_theme = "vhelix",
    use_crayon = TRUE,
    verbose = FALSE,
    admin_page = FALSE,
    admin_url = "admin",
    module_wf = TRUE,
    module_rnaseq = TRUE,
    module_ggplot = TRUE
))
```


<p style="color:var(--danger)">Note: Do not worry if you set some invalid values, on app start, `sps()` will check all SPS
options, ignore unknown values and set invalid values back to default. You will see warning 
messages on console to tell you specifically what is wrong with your options.</p>

| Option          | Description                       | Default | Other     |
|-----------------|-----------------------------------|---------|-----------|
| mode            | running mode                      | "local" | "server"  |
| warning_toast   | show security warnings?           | TRUE    | FALSE     |
| loading_screen  | show loading screen?              | TRUE    | FALSE     |
| loading_theme   | loading screen theme              | "vhelix"| any string|
| use_crayon      | colorful console message?         | TRUE    | FALSE     |
| verbose         | more details for SPS functions?   | FALSE   | TRUE      |
| admin_page      | show admin page?                  | FALSE   | TRUE      |
| admin_url       | admin_page query url              | "admin" | any string|
| warning_toast   | for internal test only            | TRUE    | FALSE     |
| module_wf       | load workflow module?             | TRUE    | FALSE     |
| module_rnaseq   | load RNAseq module?               | TRUE    | FALSE     |
| module_ggplot   | load quick ggplot module?         | TRUE    | FALSE     |
| app_path        | hidden, automatically added       | N.A.    | N.A.      |


### Some details

- mode: this option will change how the upload files are selected.
    - local: You can choose file from server side, and it is a direct link, no file will be copied to server. Most often used when you are on you own computer. <span style="color:var(--primary)">It is still choosing files from the server side, because you are using your own computer as a Shiny server.</span>
    - server: Choose files from the client side, and upload as a temp file to the server.
    - If you are on you own computer, there is no difference, but `local` mode can avoid copy your files to temp. <span style="color:var(--primary)">If you are deploying the app to cloud, please **use server mode**</span>
    - Functions directly associated with this option are `dynamicFile` and `dynamicFileServer`. We will discuss details in [Developer sections](/sps/dev/)
- warning_toast: A toast pop-up message when you are under some dangerous options when app starts (For internal testing only under current version).
- loading_theme: `loading_screen` must be `TRUE`. Only one theme for now, we will add more in future.
- verbose: Give you more information on debugging. Most SPS core functions has this option. If it is on, more debugging information will be printed on console.
- admin_url (disabled in current version): the admin page URL, `admin_page` must be `TRUE` for it to work. It will be added in an upcoming version, a preview can be seen by adding "/?admin" to the end of app url, e.g. "[https://tgirke.shinyapps.io/systemPipeShiny/?admin](https://tgirke.shinyapps.io/systemPipeShiny/?admin)".

### get/set option values
SPS values are globally set, which means you can get/change the these options at 
inside any R code, R functions and while the app is running (change options after app started 
is not recommended).


To view a single option value, use `spsOption(opt = "OPTION_NAME")`; to overwrite a single 
option, use `spsOption(opt = "OPTION_NAME", value = "NEW_VALUE")`.


```r
spsOption(opt = "mode")
```

```
## [1] "server"
```
To overwrite the "mode" option:


```r
spsOption(opt = "mode", "local")
```

Check again, the value has changed to "local":


```r
spsOption(opt = "mode")
```

```
## [1] "local"
```

If any option does not exist, or the value is "empty" or `0`, when getting the value `spsOption` will return `FALSE`.
Common "empty" values: 

- `NA`
- `NULL`
- `length(value) == 0`
- `""` (empty string)
    
Read the help file of `?emptyIsFalse` for more information.


```r
spsOption(opt = "random_opt")
```

```
## [1] FALSE
```

However, these "empty" values can be meaningful in some cases, so use `empty_is_false = FALSE`
to return the original value instead of `FALSE`

```r
spsOption(opt = "random_opt", empty_is_false = FALSE)
```

```
## NULL
```



## session info

```r
sessionInfo()
```

```
## R version 4.0.3 (2020-10-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.5 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
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
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] systemPipeShiny_1.1.11 shinyTree_0.2.7        shiny_1.6.0.9000      
## 
## loaded via a namespace (and not attached):
##   [1] shinydashboard_0.7.1        R.utils_2.10.1             
##   [3] esquisse_0.3.1              tidyselect_1.1.0           
##   [5] RSQLite_2.2.3               AnnotationDbi_1.52.0       
##   [7] htmlwidgets_1.5.3           grid_4.0.3                 
##   [9] BiocParallel_1.24.1         Rtsne_0.15                 
##  [11] munsell_0.5.0               base64url_1.4              
##  [13] DT_0.17                     systemPipeR_1.24.3         
##  [15] miniUI_0.1.1.1              withr_2.4.1                
##  [17] shinytoastr_2.1.1           colorspace_2.0-0           
##  [19] Biobase_2.50.0              Category_2.56.0            
##  [21] knitr_1.31                  rstudioapi_0.13            
##  [23] stats4_4.0.3                shinyWidgets_0.5.6         
##  [25] MatrixGenerics_1.2.0        GenomeInfoDbData_1.2.4     
##  [27] hwriter_1.3.2               bit64_4.0.5                
##  [29] pheatmap_1.0.12             batchtools_0.9.15          
##  [31] vctrs_0.3.6                 treeio_1.14.3              
##  [33] generics_0.1.0              xfun_0.20                  
##  [35] BiocFileCache_1.14.0        R6_2.5.0                   
##  [37] markdown_1.1                GenomeInfoDb_1.26.2        
##  [39] locfit_1.5-9.4              rsvg_2.1                   
##  [41] bitops_1.0-6                cachem_1.0.1               
##  [43] shinyAce_0.4.1              DelayedArray_0.16.1        
##  [45] assertthat_0.2.1            vroom_1.3.2                
##  [47] promises_1.1.1              networkD3_0.4              
##  [49] scales_1.1.1                gtable_0.3.0               
##  [51] processx_3.4.5              systemPipeRdata_1.18.1     
##  [53] rlang_0.4.10                genefilter_1.72.1          
##  [55] splines_4.0.3               rtracklayer_1.50.0         
##  [57] lazyeval_0.2.2              shinyjqui_0.3.3            
##  [59] bsplus_0.1.2                brew_1.0-6                 
##  [61] checkmate_2.0.0             BiocManager_1.30.10        
##  [63] yaml_2.2.1                  GenomicFeatures_1.42.1     
##  [65] backports_1.2.1             httpuv_1.5.5               
##  [67] RBGL_1.66.0                 tools_4.0.3                
##  [69] bookdown_0.21.6             ggplot2_3.3.3              
##  [71] ellipsis_0.3.1              RColorBrewer_1.1-2         
##  [73] BiocGenerics_0.36.0         Rcpp_1.0.6                 
##  [75] plyr_1.8.6                  progress_1.2.2             
##  [77] zlibbioc_1.36.0             purrr_0.3.4                
##  [79] RCurl_1.98-1.2              ps_1.5.0                   
##  [81] prettyunits_1.1.1           openssl_1.4.3              
##  [83] S4Vectors_0.28.1            SummarizedExperiment_1.20.0
##  [85] fs_1.5.0                    magrittr_2.0.1             
##  [87] data.table_1.13.6           blogdown_1.1.7             
##  [89] colourpicker_1.1.0          matrixStats_0.58.0         
##  [91] hms_1.0.0                   patchwork_1.1.1            
##  [93] shinyjs_2.0.0               mime_0.9                   
##  [95] evaluate_0.14               xtable_1.8-4               
##  [97] XML_3.99-0.5                jpeg_0.1-8.1               
##  [99] IRanges_2.24.1              gridExtra_2.3              
## [101] compiler_4.0.3              biomaRt_2.46.1             
## [103] tibble_3.0.6                V8_3.4.0                   
## [105] crayon_1.3.4                R.oo_1.24.0                
## [107] htmltools_0.5.1.1           GOstats_2.56.0             
## [109] later_1.1.0.1               tidyr_1.1.2                
## [111] geneplotter_1.68.0          aplot_0.0.6                
## [113] lubridate_1.7.9.2           DBI_1.1.1                  
## [115] dbplyr_2.0.0                MASS_7.3-53                
## [117] rappdirs_0.3.2              ShortRead_1.48.0           
## [119] Matrix_1.3-2                readr_1.4.0                
## [121] glmpca_0.2.0                R.methodsS3_1.8.1          
## [123] parallel_4.0.3              igraph_1.2.6               
## [125] GenomicRanges_1.42.0        pkgconfig_2.0.3            
## [127] rvcheck_0.1.8               GenomicAlignments_1.26.0   
## [129] plotly_4.9.3                xml2_1.3.2                 
## [131] ggtree_2.4.1                annotate_1.68.0            
## [133] XVector_0.30.0              AnnotationForge_1.32.0     
## [135] VariantAnnotation_1.36.0    stringr_1.4.0              
## [137] callr_3.5.1                 digest_0.6.27              
## [139] graph_1.68.0                Biostrings_2.58.0          
## [141] rmarkdown_2.6               tidytree_0.3.3             
## [143] edgeR_3.32.1                GSEABase_1.52.1            
## [145] curl_4.3                    Rsamtools_2.6.0            
## [147] rjson_0.2.20                lifecycle_0.2.0            
## [149] nlme_3.1-151                jsonlite_1.7.2             
## [151] BSgenome_1.58.0             viridisLite_0.3.0          
## [153] askpass_1.1                 limma_3.46.0               
## [155] pillar_1.4.7                lattice_0.20-41            
## [157] shinyFiles_0.9.0            fastmap_1.1.0              
## [159] httr_1.4.2                  survival_3.2-7             
## [161] GO.db_3.12.1                remotes_2.2.0              
## [163] glue_1.4.2                  zip_2.1.1                  
## [165] UpSetR_1.4.0                png_0.1-7                  
## [167] rhandsontable_0.3.7         bit_4.0.4                  
## [169] Rgraphviz_2.34.0            stringi_1.5.3              
## [171] blob_1.2.1                  DESeq2_1.30.0              
## [173] latticeExtra_0.6-29         shinydashboardPlus_0.7.5   
## [175] memoise_2.0.0               DOT_0.1                    
## [177] styler_1.3.2                dplyr_1.0.3                
## [179] ape_5.4-1
```



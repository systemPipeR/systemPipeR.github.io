---
title: "Configuration"
linkTitle: "Configuration"
type: docs
weight: 1
---

SPS has many options you can change. These options will determine how the app 
behaves.

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
## [SPS-DANGER] 2021-04-16 18:02:46 Done, Db created at '/tmp/RtmpEwPsQa/config_demo/config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-16 18:02:46 Key md5 2f47cb4559f0517a50321c504f2a8ce5
## [SPS-INFO] 2021-04-16 18:02:46 SPS project setup done!
```

```r
## save project path 
(sps_dir <- file.path(tempdir(), "config_demo"))
```

```
## [1] "/tmp/RtmpEwPsQa/config_demo"
```

To reproduce code locally, run the following chunk instead. 


```r
library(systemPipeShiny)
spsInit()
sps_dir <- normalizePath(".")
```


<STYLE type='text/css' scoped>
PRE.fansi SPAN {padding-top: .25em; padding-bottom: .25em};
</STYLE>

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
values('*' means any value is okay) see `global.R` from 
the line starting with *## SPS options*. We provided some comments below that line to 
generally describe what each option is and valid values for options. Use function 
`spsOptDefaults` to see the default and other valid options. 


```r
spsOptDefaults(app_path = sps_dir)
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #0000BB;font-weight: bold;'>title</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>systemPipeShiny 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>* 
## </span><span style='color: #0000BB;font-weight: bold;'>title_logo</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>img/sps_small.png 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>* 
## </span><span style='color: #0000BB;font-weight: bold;'>mode</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>local 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>server 
## </span><span style='color: #0000BB;font-weight: bold;'>login_screen</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>login_theme</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>vhelix 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>* 
## </span><span style='color: #0000BB;font-weight: bold;'>use_crayon</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>verbose</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>FALSE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>TRUE 
## </span><span style='color: #0000BB;font-weight: bold;'>admin_page</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>FALSE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>TRUE 
## </span><span style='color: #0000BB;font-weight: bold;'>admin_url</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>admin 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>* 
## </span><span style='color: #0000BB;font-weight: bold;'>warning_toast</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>module_wf</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>module_rnaseq</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>module_ggplot</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>tab_welcome</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>tab_vs_main</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>tab_canvas</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>tab_about</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>TRUE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>FALSE 
## </span><span style='color: #0000BB;font-weight: bold;'>note_url</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>* 
## </span><span style='color: #0000BB;font-weight: bold;'>traceback</span><span>:
## </span><span style='color: #00BB00;font-weight: bold;'>    Default: </span><span>FALSE 
## </span><span style='color: #00BB00;font-weight: bold;'>    Other: </span><span>TRUE 
## * means any value will be accepted
</span></CODE></PRE>

After the app has started once, you can use `spsOptions()` to see all current settings.


```r
spsOptions(app_path = sps_dir)
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #00BB00;font-weight: bold;'>Current project option settings:</span><span> 
## </span><span style='color: #0000BB;font-weight: bold;'>verbose</span><span>:
##     </span><span style='color: #00BB00;font-weight: bold;'>FALSE </span><span>
## </span><span style='color: #0000BB;font-weight: bold;'>use_crayon</span><span>:
##     </span><span style='color: #00BB00;font-weight: bold;'>TRUE </span><span>
## ********
## Option legend:
## </span><span style='color: #0000BB;font-weight: bold;'>    known options    </span><span style='color: #BBBB00;font-weight: bold;'>    Hidden/custom options* and values+
## </span><span>Value legend:
## </span><span style='color: #00BB00;font-weight: bold;'>    same as default values    </span><span>    different from defaults+
</span></CODE></PRE>

A copy of options in `global.R`: 


```r
options(sps = list(
    title = "systemPipeShiny",
    title_logo = "img/sps_small.png",
    mode = "local",
    warning_toast = FALSE,
    login_screen = FALSE,
    login_theme = "random",
    use_crayon = TRUE,
    verbose = FALSE,
    admin_page = TRUE,
    admin_url = "admin",
    note_url = 'https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml',
    tab_welcome = TRUE,
    tab_vs_main = TRUE,
    tab_canvas = TRUE,
    tab_about = TRUE,
    module_wf = TRUE,
    module_rnaseq = TRUE,
    module_ggplot = TRUE,
    traceback = FALSE
))
```


<p style="color:var(--danger)">Note: Do not worry if you set some invalid values, on app start, `sps()` will check all SPS
options, ignore unknown values and set invalid values back to default. You will see warning 
messages on console to tell you specifically what is wrong with your options.</p>

| Option          | Description                       | Default | Other     |
|-----------------|-----------------------------------|---------|-----------|
| mode            | running mode                      | "local" | "server"  |
| title           | App title                         | "systemPipeShiny" | any string|
| title_logo      | App logo to display on browser tab| "img/sps_small.png" | any path  |
| warning_toast   | show security warnings?           | TRUE    | FALSE     |
| login_screen    | add login screen?                 | TRUE    | FALSE     |
| login_theme     | login screen theme                | "random"| see details|
| use_crayon      | colorful console message?         | TRUE    | FALSE     |
| verbose         | more details for SPS functions?   | FALSE   | TRUE      |
| admin_page      | enable admin page?                  | FALSE   | TRUE      |
| admin_url       | admin_page query url              | "admin" | any string|
| warning_toast   | for internal test only            | TRUE    | FALSE     |
| module_wf       | load workflow module?             | TRUE    | FALSE     |
| module_rnaseq   | load RNAseq module?               | TRUE    | FALSE     |
| module_ggplot   | load quick ggplot module?         | TRUE    | FALSE     |
| tab_welcome     | load welcome tab?                 | TRUE    | FALSE     |  
| tab_vs_main     | load custom visualization main tab?| TRUE    | FALSE     |  
| tab_canvas      | load Canvas tab?                  | TRUE    | FALSE     |  
| tab_about       | load about tab?                   | TRUE    | FALSE     | 
| note_url        | SPS notification remote URL       | see code above| any URL| 
| app_path        | hidden, automatically added       | N.A.    | N.A.      |


### Details

- **mode**: see [[App security](../app_security)] this option will change how 
  the upload files are selected.
- **title & title_logo**: see [[Other customizations](../other_customizations)]
- **warning_toast**: see [[App security](../app_security)], 
  A toast pop-up message to help you check pre-deploy for security problems.
- **login_screen & login_theme & admin_page & admin_url**: 
  see [[Accounts, Login and Admin](../login)].
- **verbose**: Give you more information on debugging. Most SPS core functions 
  has this option. If it is on, more debugging information will be printed 
  on console. See [[Debugging](../debug)]
- **module_xx -- tab_xx**: see [[Toggle tabs](../displaytabs)] for loading and unloading 
  tabs.
- **tab_xx**: see [[Overwrite tabs](../overwritetabs)] for customizing core SPS default tabs.
- **note_url**: see [[Notification system](../notification)] for customizing SPS notifications.

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
## [1] FALSE
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
## [1] systemPipeShiny_1.1.37 drawer_0.1.0.9         spsComps_0.1.9.99     
## [4] spsUtil_0.1.0.9        shiny_1.6.0.9000      
## 
## loaded via a namespace (and not attached):
##  [1] httr_1.4.2               sass_0.3.1               shinyFiles_0.9.0        
##  [4] tidyr_1.1.2              bit64_4.0.5              vroom_1.3.2             
##  [7] jsonlite_1.7.2           viridisLite_0.3.0        bslib_0.2.4             
## [10] assertthat_0.2.1         askpass_1.1              blob_1.2.1              
## [13] yaml_2.2.1               backports_1.2.1          pillar_1.5.0            
## [16] RSQLite_2.2.3            glue_1.4.2               digest_0.6.27           
## [19] promises_1.1.1           colorspace_2.0-0         htmltools_0.5.1.1       
## [22] httpuv_1.5.5             pkgconfig_2.0.3          bookdown_0.21.6         
## [25] purrr_0.3.4              xtable_1.8-4             scales_1.1.1            
## [28] later_1.1.0.1            tibble_3.1.0             openssl_1.4.3           
## [31] styler_1.3.2             generics_0.1.0           ggplot2_3.3.3           
## [34] ellipsis_0.3.1           DT_0.17                  shinyjs_2.0.0           
## [37] cachem_1.0.1             lazyeval_0.2.2           magrittr_2.0.1          
## [40] crayon_1.4.1             mime_0.9                 memoise_2.0.0           
## [43] evaluate_0.14            shinytoastr_2.1.1        fs_1.5.0                
## [46] fansi_0.4.2              shinydashboard_0.7.1     blogdown_1.2            
## [49] tools_4.0.3              data.table_1.13.6        lifecycle_1.0.0         
## [52] stringr_1.4.0            plotly_4.9.3             munsell_0.5.0           
## [55] shinyAce_0.4.1           compiler_4.0.3           jquerylib_0.1.3         
## [58] rlang_0.4.10             shinyjqui_0.3.3          grid_4.0.3              
## [61] shinydashboardPlus_2.0.0 rstudioapi_0.13          htmlwidgets_1.5.3       
## [64] rmarkdown_2.7.7          shinyWidgets_0.6.0       gtable_0.3.0            
## [67] DBI_1.1.1                R6_2.5.0                 lubridate_1.7.9.2       
## [70] knitr_1.31               dplyr_1.0.3              fastmap_1.1.0           
## [73] bit_4.0.4                utf8_1.1.4               bsplus_0.1.2            
## [76] stringi_1.5.3            Rcpp_1.0.6               vctrs_0.3.6             
## [79] tidyselect_1.1.0         xfun_0.22
```



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
## [SPS-DANGER] 2021-12-15 00:08:50 Done, Db created at '/tmp/Rtmpgas05w/config_demo/config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-12-15 00:08:50 Key md5 405b200ceb5c90dbb5c097c88d582dcb
## [SPS-INFO] 2021-12-15 00:08:50 SPS project setup done!
```

```r
## save project path 
(sps_dir <- file.path(tempdir(), "config_demo"))
```

```
## [1] "/tmp/Rtmpgas05w/config_demo"
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
├── config                 <span class="text-success">| Important app config files. Do not edit them by hand if you don't know</span>  
│   ├── sps.db             <span class="text-gray">| SPS database</span> 
│   ├── sps_options.yaml   <span class="text-gray">| SPS default option list</span> 
│   └── tabs.csv           <span class="text-gray">| SPS tab registration information</span> 
├── data                   <span class="text-primary">| App example data files</span> 
│   ├── xx.csv             
├── R                      <span class="text-primary">| All SPS additional tab files, helper R function, interactive guides files</span> 
│   ├── tab_xx.R            
├── README.md              
├── results                <span class="text-gray">| Not in use for this current version, but you can store some data been generated from the app</span> 
│   └── README.md          
└── www                    <span class="text-primary">| Internet resources</span>  
    ├── css                <span class="text-info">| CSS files</span>  
    │   └── sps.css         
    ├── img                <span class="text-info">| App image resources</span>    
    │   └── xx.png         
    ├── js                 <span class="text-info">| Javascripts</span>
    │   └── xx.js           
    ├── loading_themes     <span class="text-info">| Loading screen files</span> 
    │   └── xx.html         
    └── plot_list          <span class="text-info">| Image files for custom visualization tab thumbnails</span>  
        └── plot_xx.jpg      
</pre>

This is a reminder of what you will get when a SPS project is initiated with `spsInit()`.

1. For most users, the `global.R` file is the only file that one needs to make change.
2. The second important files are the files inside `config` folder. For normal users,
these files are controlled by SPS functions. No need to make any modification. For advanced users, deep customization is possible. 
    - `sps_options.yaml` stores all default and valid values for SPS, details are 
      listed [below](#app-options)
    - `tabs.csv` all SPS tab registration information. Read [Manage tabs](../tabs)
    - `sps.db` A SQLite database to store data generated in SPS. Read [SPS database](../database)
      for more information.
3. `R` folder stores all custom tab files, your helper functions. This `.R` or `.r` files under this 
folder **will be automatically sourced** when SPS starts. This is discussed in 
[Manage tabs](../tabs).
4. `www` folder is where you add the internet resources, like images you want to show in 
the app, `css` style sheets to attach. Read more [here](https://stevenmortimer.com/tips-for-making-professional-shiny-apps-with-r/#create-a-www-folder).

    
## App options

### View/Set all options 

App options in SPS are controlled by "SPS options". These options can change 
app appearance, debugging level, server behaviors, *etc*. The valid options can 
be found and change on the `global.R` file. They are similar to *Shiny* options, 
but unlike *shiny* options that are single values, SPS options are passed using the `Option(sps = list(...))` 
function in `global.R` as a group. To view all options and their default, valid
values('*' means any value is okay) see `global.R` from 
the line starting with *## SPS options*. We provided some comments below that line to 
generally describe what each option is and valid values for options. Use function 
`spsOptDefaults` to see the default and other valid options. 


```r
spsOptDefaults(app_path = sps_dir)
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #0000BB; font-weight: bold;'>title</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>systemPipeShiny 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>title_logo</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>img/sps_small.png 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>mode</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>local 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>server 
## <span style='color: #0000BB; font-weight: bold;'>login_screen</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>login_theme</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>random 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>use_crayon</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>verbose</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>admin_page</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>admin_url</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>admin 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>warning_toast</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>module_wf</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>module_rnaseq</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>module_ggplot</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_welcome</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_vs_main</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_canvas</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_about</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>note_url</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>traceback</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>is_demo</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>welcome_guide</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## * means any value will be accepted
</CODE></PRE>

After the app has started once, you can use `spsOptions()` to see all current settings.


```r
spsOptions(app_path = sps_dir)
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #00BB00; font-weight: bold;'>Current project option settings:</span> 
## <span style='color: #0000BB; font-weight: bold;'>title</span>:
##     <span style='color: #00BB00; font-weight: bold;'>systemPipeShiny </span>
## <span style='color: #0000BB; font-weight: bold;'>title_logo</span>:
##     <span style='color: #00BB00; font-weight: bold;'>img/sps_small.png </span>
## <span style='color: #0000BB; font-weight: bold;'>mode</span>:
##     <span style='color: #00BB00; font-weight: bold;'>local </span>
## <span style='color: #0000BB; font-weight: bold;'>login_screen</span>:
##     <span style='color: #00BB00; font-weight: bold;'>FALSE </span>
## <span style='color: #0000BB; font-weight: bold;'>login_theme</span>:
##     <span style='color: #00BB00; font-weight: bold;'>random </span>
## <span style='color: #0000BB; font-weight: bold;'>use_crayon</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>verbose</span>:
##     <span style='color: #00BB00; font-weight: bold;'>FALSE </span>
## <span style='color: #0000BB; font-weight: bold;'>admin_page</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>admin_url</span>:
##     <span style='color: #00BB00; font-weight: bold;'>admin </span>
## <span style='color: #0000BB; font-weight: bold;'>warning_toast</span>:
##     <span style='color: #00BB00; font-weight: bold;'>FALSE </span>
## <span style='color: #0000BB; font-weight: bold;'>module_wf</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>module_rnaseq</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>module_ggplot</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>tab_welcome</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>tab_vs_main</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>tab_canvas</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>tab_about</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## <span style='color: #0000BB; font-weight: bold;'>note_url</span>:
##     <span style='color: #00BB00; font-weight: bold;'>https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml </span>
## <span style='color: #0000BB; font-weight: bold;'>traceback</span>:
##     <span style='color: #00BB00; font-weight: bold;'>FALSE </span>
## <span style='color: #0000BB; font-weight: bold;'>is_demo</span>:
##     <span style='color: #00BB00; font-weight: bold;'>FALSE </span>
## <span style='color: #0000BB; font-weight: bold;'>welcome_guide</span>:
##     <span style='color: #00BB00; font-weight: bold;'>TRUE </span>
## ********
## Option legends:
## <span style='color: #0000BB; font-weight: bold;'>    known options    </span><span style='color: #BBBB00; font-weight: bold;'>    Hidden/custom options* and values+
## </span>Value legends:
## <span style='color: #00BB00; font-weight: bold;'>    same as default values    </span>    different from defaults+
</CODE></PRE>

A copy of options in `global.R`: 


```r
spsOption(.list = list(
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
    traceback = FALSE,
    is_demo = FALSE,
    welcome_guide = TRUE
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
| admin_page      | enable admin page?                | FALSE   | TRUE      |
| admin_url       | admin_page query url              | "admin" | any string|
| warning_toast   | for internal test only            | TRUE    | FALSE     |
| module_wf       | load workflow module?             | TRUE    | FALSE     |
| module_rnaseq   | load RNAseq module?               | TRUE    | FALSE     |
| module_ggplot   | load quick ggplot module?         | TRUE    | FALSE     |
| tab_welcome     | load welcome tab?                 | TRUE    | FALSE     |  
| tab_vs_main     | load custom visualization main tab?| TRUE   | FALSE     |  
| tab_canvas      | load Canvas tab?                  | TRUE    | FALSE     |  
| tab_about       | load about tab?                   | TRUE    | FALSE     | 
| note_url        | SPS notification remote URL       | see code above| any URL| 
| is_demo         | useful if deploy the app as a demo | FALSE  | TRUE      | 
| welcome_guide   | enable the welcome guide          | TRUE    | FALSE     | 
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
- **is_demo**: see [[Workflow module](/sps/modules/workflow/#is_demo-option)].
- **welcome_guide**: whether to enable the welcome guide on app start, see first image on [SPS guide](../guide).
- **app_path**: a hidden option. This will be added after the app starts. If not specified in 
  `sps()`, use current working directory.

### View/Set a single option

SPS values are globally set, which means you can get/change the these options at 
inside any R code, R functions and while the app is running (change options after app started 
is not recommended).

To view a single option value, use `spsOption(opt = "OPTION_NAME")`; to overwrite a single 
option, use `spsOption(opt = "OPTION_NAME", value = "NEW_VALUE")`.


```r
spsOption(opt = "mode")
```

```
## [1] "local"
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

## Add your own options
SPS is very flexible which allows you to add your own options. To do so, you need 
to edit the "`config/sps_options.yaml`" file under your project root. 

You can use other options as templates to add more. There are two required entries:
- `default`: will be used as default when you load SPS package.
- `other`: Other valid options. If your user provided a value that is other than 
  the `default` or the `other`, SPS will show warnings and use default instead. 
  You can write `"*"` as the `other` value. It means any value will be accepted. 
  SPS will skip to check `other` valid values for this option. 
  
Currently, the `default` value can only be length of 1 but `other` value can be a
yaml array, which use `[]` to define: `[value1, value2, ...]`.

For example, we can add some but opening the file with a text editor, here we do 
it programmatically:

```r
new_options <- 
'
my_opt1:
    default: true
    other: [false]

my_opt2:
    default: "a"
    other: ["*"]
'
write(x = new_options, file = file.path(sps_dir, "config", "sps_options.yaml"), append = TRUE)
```


Then we can use `spsOptDefaults` to check 

```r
spsOptDefaults(app_path = sps_dir)
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #0000BB; font-weight: bold;'>title</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>systemPipeShiny 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>title_logo</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>img/sps_small.png 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>mode</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>local 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>server 
## <span style='color: #0000BB; font-weight: bold;'>login_screen</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>login_theme</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>random 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>use_crayon</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>verbose</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>admin_page</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>admin_url</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>admin 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>warning_toast</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>module_wf</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>module_rnaseq</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>module_ggplot</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_welcome</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_vs_main</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_canvas</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>tab_about</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>note_url</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>https://raw.githubusercontent.com/systemPipeR/systemPipeShiny/master/inst/remote_resource/notifications.yaml 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## <span style='color: #0000BB; font-weight: bold;'>traceback</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>is_demo</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>FALSE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>TRUE 
## <span style='color: #0000BB; font-weight: bold;'>welcome_guide</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>my_opt1</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>TRUE 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>FALSE 
## <span style='color: #0000BB; font-weight: bold;'>my_opt2</span>:
## <span style='color: #00BB00; font-weight: bold;'>    Default: </span>a 
## <span style='color: #00BB00; font-weight: bold;'>    Other: </span>* 
## * means any value will be accepted
</CODE></PRE>

You can see the `my_opt1` and `my_opt2` have been added to SPS options.














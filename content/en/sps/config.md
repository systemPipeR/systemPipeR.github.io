---
title: "Configuration"
linkTitle: "Configuration"
type: docs
weight: 6
---
*****
### App options

App options in SPS are controlled by "SPS options". These options can change 
app appearance, debugging level, server server behaviors, *etc*. The valid options can 
be found and change on the `global.R` file. They are similar to *Shiny* options, 
but unlike *shiny* options are single values, SPS options are passed using the `Option(sps = list(...))` 
function in `global.R` as a group. To view all options and their default, valid
values('*' means any value is okay):

```{r, eval=TRUE}
viewSpsDefaults(app_path = sps_dir)
```

To view a single option value, use `spsOption(opt = "OPTION_NAME")`; to overwrite a single 
option, use `spsOption(opt = "OPTION_NAME", value = "NEW_VALUE")`.

<p style="color:var(--primary)">Note: Do not worry if you set some invalid values, on app start, `sps()` will check all SPS
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

some details:

- mode: this option will change how the upload files are selected.
    - local: You can choose file from server side, and it is a direct link, no file will be copied to server. Most often used when you are on you own computer. <span style="color:var(--info)">It is still choosing files from the server side, because you are using your own computer as a Shiny server.</span>
    - server: Choose files from the client side, and upload as a temp file to the server.
    - If you are on you own computer, there is no difference, but `local` mode can avoid copy your files to temp. <span style="color:var(--info)">If you are deploying the app to cloud, please **use server mode**</span>
- warning_toast: A toast pop-up message when you are under some dangerous options when app starts.
- loading_theme: `loading_screen` must be `TRUE`. Only one theme for now, we will add more in future.
- verbose: Give you more information on debugging.
- admin_url (disabled in current version): the admin page url, `admin_page` must be `TRUE` for it to work. It will be added in an upcoming version, a preview can be seen by adding "/?admin" to the end of app url, e.g. "[https://tgirke.shinyapps.io/systemPipeShiny/?admin](https://tgirke.shinyapps.io/systemPipeShiny/?admin)".

### Tab configurations

Tabs are registered(defined) by the *tabs.csv* file under SPS project *config* folder. It contains information for all 
the tabs. Do not modify it if you don't plan to build new tabs. See [developer section](#extend-spsfor-developers) for how 
to operate this file. 

To control what tabs to appear(load/unload) on SPS, pass the tab IDs of tabs you want to see to 
`tabs =` argument on `sps()`

```{r , eval=FALSE}
sps_app <- sps(tabs = c("ID1", "ID2", ...))
```

*tabs.csv* has all the tab IDs. Under current version of SPS, you can only load/unload 
tabs in the "vs" type. Tabs under "core" and "wf" types are unable to change.

## A variety of additional shiny widgets 

There are many useful HTML components that 
can be use outside out SPS. You can include these widgets in your own Shiny apps without 
loading SPS main framework. 

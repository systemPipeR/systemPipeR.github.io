---
title: "Toggle tabs"
linkTitle: "Toggle tabs"
type: docs
weight: 3
---
*****

## Load and unload tabs

In SPS, all tabs including tabs for modules and other default tabs can be 
loaded and unloaded. This is controlled by [SPS options](../config#app-options)

Under current version, these options are:

| Option          | Description                       | Default | Other     |
|-----------------|-----------------------------------|---------|-----------|
| module_wf       | load workflow module?             | TRUE    | FALSE     |
| module_rnaseq   | load RNAseq module?               | TRUE    | FALSE     |
| module_ggplot   | load quick ggplot module?         | TRUE    | FALSE     |
| tab_welcome     | load welcome tab?                 | TRUE    | FALSE     |  
| tab_vs_main     | load custom visualization main tab?| TRUE    | FALSE     |  
| tab_canvas      | load Canvas tab?                  | TRUE    | FALSE     |  
| tab_about       | load about tab?                   | TRUE    | FALSE     | 

Each of them controls whether to load or unload a tab. By default, all tabs 
are loaded, but you can unload them by turn them to `FALSE`.


The original UI look like this:
<center>

![](../sps_default_ui.png)

<caption>Default UI</caption>

</center>

To unload some tabs, scroll to the option lines in **`global.R`** file:

```r
options(sps = list(
    ...
    tab_welcome = TRUE,
    tab_vs_main = TRUE,
    tab_canvas = FALSE,
    tab_about = FALSE,
    module_wf = FALSE,
    module_rnaseq = FALSE,
    module_ggplot = TRUE,
    ...
))
```
We unload the "Canvas tab", "workflow module tab", "RNASeq module tab" and
"About tab". When you restart the app, you should see some tabs are gone:

The original UI look like this:
<center>

![](../sps_unload_tabs.png)

<caption>Unload some tabs</caption>

</center>

### Exception for module main page
You may have noticed, there is no option to unload the *module main tab*, which is 
named "<i class="fa fa-layer-group"></i>Modules" on the left sidebar. This is 
because this tab is controlled by its sub-tabs, the module tab options. To unload this tab, all 
the module tabs have to be unloaded the same time like following. If any module 
is loaded, this module main tab cannot be unloaded. 

```r
options(sps = list(
    ...
    module_wf = FALSE,
    module_rnaseq = FALSE,
    module_ggplot = FALSE,
    ...
))
```

<center>

![](../sps_no_module.png)

<caption>No module loaded</caption>

</center>












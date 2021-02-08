---
title: "New custom tabs"
linkTitle: "New custom tabs"
type: docs
weight: 7
---
*****

As a framework, `SPS` allows users to add/remove/customize individual tabs. At current 
version, you can only modify tabs in Visualization module (data tabs, plot tabs). 
Use `spsNewTab` to create new tabs. This function
will help you to **create the tab file**, store it to the *R* folder in your SPS project, and
**register tab information** by adding records to *config/tabs.csv*.
Most arguments are self-explanatory or can be 
easily understood by reading the the help file. 

## Adding the new tabs at your SPS application 

In your *global.R*, scroll down to the bottom, you should see:


```r
sps_app <- sps(
    tabs = c("data_example", "plot_example1", "plot_example2"),
    server_expr = {
        msg("Custom expression runs -- Hello World", "GREETING", "green")
    }
)
```

This is the SPS main function. You can load/unload tabs by providing tab IDs in `vstabs` argument, like
`c("tab1", "tab2)`. Open *config/tabs.csv* or use `spsTabInfo()` to see what tabs IDs can be load and other
tab information. Currently you can only load/unload visualization tabs, the key word `vs` under column "*type*";
essential framework tabs(*core*) and workflow tabs (*wf*) are loaded automatically and these tabs cannot be modified.

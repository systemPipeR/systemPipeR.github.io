---
title: "Server functions"
linkTitle: "Server functions"
type: docs
weight: 2
---


SPS provides a many user Shiny server-end functions. If you want to design your next 
Shiny App, take a look at these server functions. Here is a [online demo](https://lezhang.shinyapps.io/spsComps)
of these server components. 

After SPS 1.1, these components are separated into a supporting package called 
**spsComps** (systemPipeShiny Components), and you can install from CRAN.

```r
install.packages("spsComps")
```
Develop version:
```r
if (!requireNamespace("spsComps", quietly=TRUE))
    remotes::install_github("lz100/spsComps")
```

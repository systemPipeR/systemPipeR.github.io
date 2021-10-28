---
title: "Developer tools"
linkTitle: "Developer tools"
type: docs
weight: 9
---

SPS is not only a framework to run interactive workflow and visualize data, but 
also a framework with a abundant developer tools for building Shiny apps, writing R markdowns,
integrating R-HTML and general R utilities. 

These developer toolkits are distributed in supporting packages. If you like 
some of the functionality from SPS and think installing the whole framework is 
too expensive (time consuming), cherry-pick the functionality you want in following
categories:

- **spsCpmps**: Shiny/Rmarkdown UI components, and Shiny server functions.
- **drawer**: Shiny/Rmarkdown/HTML interactive image editing tool.
- **spsUtil**: General R utilities, like pretty logging functions.


## Install
All these supporting packages are available on CRAN. We recommend to use the 
modern package manager {[pak](https://github.com/r-lib/pak)} to install packages. 


```r
if(!requireNamespace("pak", quietly = TRUE))
  install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")
```


Pick and install packages as your need 

```r
pak::pkg_install("spsCpmps")
pak::pkg_install("drawer")
pak::pkg_install("spsUtil")
```

### Linux 

If you are on Linux, you need to install some system dependencies **before** R package
installation. To figure out 
what system dependencies and command, run: 




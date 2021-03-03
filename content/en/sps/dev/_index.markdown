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
  install.packages("pak")
```

If you are on Linux, you need to install some system dependencies. To figure out 
what system dependencies and command, run: 


```r
paste("sudo", pak::pkg_system_requirements("spsComps"))
```

```
## [1] "sudo apt-get install -y libcurl4-openssl-dev"
## [2] "sudo apt-get install -y libssl-dev"          
## [3] "sudo apt-get install -y make"                
## [4] "sudo apt-get install -y libicu-dev"          
## [5] "sudo apt-get install -y pandoc"
```

```r
paste("sudo", pak::pkg_system_requirements("drawer")) # dependencies not updated when the time of writing this document, should be now
```

```
## [1] "sudo "
```

```r
paste("sudo", pak::pkg_system_requirements("spsUtil"))
```

```
## [1] "sudo apt-get install -y libcurl4-openssl-dev"
## [2] "sudo apt-get install -y libssl-dev"          
## [3] "sudo apt-get install -y libicu-dev"
```


<b class = "text-primary">We are rendering this doc in Ubuntu. If your Linux distribution is different, commands above will be different.</b>

Pick and install packages as your need 

```r
pak::pkg_install("spsCpmps")
pak::pkg_install("drawer")
pak::pkg_install("spsUtil")
```

## Functions reference manual
In documents, we only highlight some important functions. Please read 
the [reference manuals](/sps/sps_funcs) for details of every function. 






---
title: "Installation"
linkTitle: "Installation"
type: docs
weight: 2
---

### Full

``` r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("systemPipeShiny", dependencies=TRUE)

```
This will install **all** required packages including suggested packages that 
are required by the core modules. Be aware, it will take quite some time if you 
are installing on Linux where only source installation is available. Windows and Mac
binary installations will be much faster. 

### Minimum

To install the package, please use the `BiocManager::install` command:

``` r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("systemPipeShiny")

```

By the minimum installation, all the 3 core modules are not installed. You 
can still start the app, and When you start the app and click on these modules, 
it will tell to enable these modules, what packages and command you need to run. 
Just follow the instructions. So, install as you need.

### Most recent 

To obtain the most recent updates immediately, one can install it directly from 
[GitHub{blk}](https://github.com/systemPipeR/systemPipeShiny) as follow:

``` r
if (!requireNamespace("remotes", quietly=TRUE))
    install.packages("remotes")
remotes::install("systemPipeR/systemPipeShiny", dependencies=TRUE)
```

Similarly, `remotes::install("systemPipeR/systemPipeShiny")` for the minimum develop
version. 

### Linux

If you are on Linux, you may also need the following libraries **before installing SPS**.
Different distributions 
may have different commands, but the following commands are examples for Ubuntu:

```bash
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install libv8-dev
sudo apt-get install libxm12-dev
sudo apt-get install libssl-dev
```

On other Linux distributions, the install commands may be slightly different. 

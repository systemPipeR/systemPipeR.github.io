---
title: "Installation"
linkTitle: "Installation"
type: docs
weight: 2
---

# Installation

The `systemPipeShiny` package can be installed from a user's R console as follows.

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("systemPipeShiny")

# or use "pak"
if (!requireNamespace("pak", quietly=TRUE))
    install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")
pak::pkg_install("systemPipeShiny")
```

If the user's OS is Linux then one may need to install the following dependencies 
**before** installing SPS.
The following example applies to Ubuntu.

```bash
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libv8-dev
# other dependencies
sudo apt-get install -y libicu-dev
sudo apt-get install -y pandoc
sudo apt-get install -y make
sudo apt-get install -y libglpk-dev
sudo apt-get install -y libgmp3-dev
sudo apt-get install -y zlib1g-dev
```

Most likely you only need to install first 3, *libcurl4-openssl-dev* may not be 
required for Ubuntu > 18.04. In case any other problem happens, try to install 
other system dependencies.

On other Linux distributions, the install commands may be slightly different. 

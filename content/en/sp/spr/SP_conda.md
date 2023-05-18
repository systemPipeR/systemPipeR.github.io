---
title: "Use Conda Environment" 
fontsize: 14pt
type: docs
weight: 11
---

> Conda is an open source package management system and environment management system that runs on Windows, macOS, and Linux. Conda quickly installs, runs and updates packages and their dependencies.

SystempipeR is also available through conda environment. 

## Install conda
conda can be installed on different OS. Please find your system information, and 
the according method to install on [conda installation page](https://conda.io/projects/conda/en/latest/user-guide/install/index.html).

## Create a conda environemnt 
Conda environment is an isolated space where users can install tools and packages 
specifically to each project with different versions. To create a conda environment, 
on your bash console, use:

```bash
# create an environment called "myenv" and install the 
# latest release version of R
conda create -n myenv r-essentials r-base
```

Here is the simplest way to create the environment. There are more options in environment creation. Please read the 
[Managing environments](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) section for more options.

To work in the new environment, use:

```bash 
conda activate myenv
```

### Other versions of R
To install other versions of R, one would need to take two steps: 

First, only create the environment and activate it. 
```bash
conda create -n myenv
conda activate myenv
```

Then, install the version of R you want
```bash 
# this installs R 4.3
conda install -c conda-forge r-base=4.3.0 r-essentials
```

## Install packages 
One could use the traditional R way of installing packages after environment 
activation. 

```bash
conda activate myenv
R
```

```r
# for CRAN 
install.packages(c("dplyr"))
# for Bioconductor
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("systemPipeR")
```

Since some packages have system dependencies, and we are working with a conda
environment, one could use `conda install` instead. This would also install most 
system dependencies for you also. For example: 

```bash
# systemPipeR
conda install -c bioconda bioconductor-systempiper
# systemPipeShiny
conda install -c bioconda bioconductor-systempipeshiny
```

>The version of packages on bioconda is usually weeks or a months behind the versions 
on Bioconductor, especially when there is a new Bioconductor new release. Please 
use `BiocManager` or `devtools` to install the lastest package. 

## Exit environment 
To exit or swtch different environments, use this first:

```bash 
conda deactivate 
```

## Work with Rstudio
Unfortunately, the free version of Rstudio does not provide support for running 
R from conda as of today (May, 2023). We would recommend using 
[JupyterLab](https://jupyterlab.readthedocs.io/en/latest/) as your IDE. The 
installation of JupyterLab from conda can be found 
[here](https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html).


## Resources

- [conda](https://docs.conda.io/en/latest/)
- [Install conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html)


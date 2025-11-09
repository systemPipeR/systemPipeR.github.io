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
## Install command-line tools
Running bioinformatic analysis in systemPipeR often requires command-line tools,
such as `samtools`, `hisat2`, `gatk`, 
to be installed and the tools need to be callable from current R environment. 

Installing these tools usually requires one to also install the system dependencies, 
and compiling may also be needed. However, most times, conda is able to figure 
out the right system dependencies and can download the binary complied files directly 
for you. Therefore, installing these tools with conda is much easier. 

Here we demonstate how to install `samtools` as an example. 

1. Go to [anaconda](https://anaconda.org/) and search the tool you want to install. 
2. If you type the name correctly, the tool should be the first result of the search. 
3. Click the results, you should see the install instruction page. 
4. Copy the code and we can start to install. 


After we activate conda, we can directly type `samtools` on console to check. 
However, sometimes if a tool is callable from console does not mean it can be 
found in R environment. It is usually related to PATH problems, but can be complicated. Here is not expanded. A better way of checking in R is to use 
`tryCMD` function in systemPipeR. Please see [Before running](../sp_run/step_run/#before-running) section for details. 

```bash
lz@hpcc:~/test$ conda activate myenv
(myenv)lz@hpcc:~/test$ samtools
# -bash: samtools: command not found
(myenv)lz@hpcc:~/test$ Rscript -e "systemPipeR::tryCMD('samtools')"
#ERROR:  
# samtools : COMMAND NOT FOUND.  
#Please make sure to configure your PATH environment variable according to the software in use. 
```

After the two ways of checking, we can see `samtools` is not installed. To install,
copy the code from anaconda and run

```bash
(myenv)lz@hpcc:~/test$ conda install -c bioconda samtools
#Collecting package metadata (current_repodata.json): done
#Solving environment: done
#
### Package Plan ##
#  environment location: /rhome/lz/shared/le/py/myenv
#
#  added / updated specs:
#    - samtools
#
#The following packages will be downloaded:
#
#    package                    |            build
#    ---------------------------|-----------------
#    c-ares-1.19.0              |       h5eee18b_0         118 KB
#    ------------------------------------------------------------
#                                           Total:         118 KB
#
#The following NEW packages will be INSTALLED:
#
#  _libgcc_mutex      pkgs/main/linux-64::_libgcc_mutex-0.1-main 
#  _openmp_mutex      pkgs/main/linux-64::_openmp_mutex-5.1-1_gnu 
#  bzip2              pkgs/main/linux-64::bzip2-1.0.8-h7b6447c_0 
#  c-ares             pkgs/main/linux-64::c-ares-1.19.0-h5eee18b_0 
#  ca-certificates    pkgs/main/linux-64::ca-certificates-2023.01.10-h06a4308_0 
#  curl               pkgs/main/linux-64::curl-7.88.1-h5eee18b_0 
#  krb5               pkgs/main/linux-64::krb5-1.19.4-h568e23c_0 
#  libcurl            pkgs/main/linux-64::libcurl-7.88.1-h91b91d3_0 
#  libedit            pkgs/main/linux-64::libedit-3.1.20221030-h5eee18b_0 
#  libev              pkgs/main/linux-64::libev-4.33-h7f8727e_1 
#  libgcc-ng          pkgs/main/linux-64::libgcc-ng-11.2.0-h1234567_1 
#  libgomp            pkgs/main/linux-64::libgomp-11.2.0-h1234567_1 
#  libnghttp2         pkgs/main/linux-64::libnghttp2-1.46.0-hce63b2e_0 
#  libssh2            pkgs/main/linux-64::libssh2-1.10.0-h8f2d780_0 
#  libstdcxx-ng       pkgs/main/linux-64::libstdcxx-ng-11.2.0-h1234567_1 
#  ncurses            pkgs/main/linux-64::ncurses-6.4-h6a678d5_0 
#  openssl            pkgs/main/linux-64::openssl-1.1.1t-h7f8727e_0 
#  samtools           bioconda/linux-64::samtools-1.6-hb116620_7 
#  xz                 pkgs/main/linux-64::xz-5.2.10-h5eee18b_1 
#  zlib               pkgs/main/linux-64::zlib-1.2.13-h5eee18b_0 
#
#Proceed ([y]/n)? y
#
#Downloading and Extracting Packages
#
#Preparing transaction: done
#Verifying transaction: done
#Executing transaction: done
#(myenv)lz@hpcc:~/test$ which samtools
```

When conda finishes installation, we can check again

```bash 
(myenv)lz@hpcc:~/test$ which samtools
#~/test/myenv/bin/samtools
(myenv)lz@hpcc:~/test$ Rscript -e "systemPipeR::tryCMD('samtools')"
#[1] "All set up, proceed!"
```

Both `which` command and `tryCMD` function return positive results.

### Specify version
Similar to installation of R, you can specify the version number for command-line 
tools as well. Different workflows may require different software versions. In
systemPipeR, after loading the workflow, you can use `listCmdTools` and `listCmdModules` to check required tools for current workflow. The version number
is usually listed in `listCmdModules`. See [Before running](../sp_run/step_run/#before-running).

> `listCmdModules` is usually used for modular system, but it is okay if you do 
not have it. It is helpful to display the version number. 

Above, for example, the latest possible version is installed by default. 
If we want to install `satmools` version `1.5`.

```bash
conda install -y -c bioconda samtools=1.5
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


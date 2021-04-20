---
title: "SPR detailed installation instructions"
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 20 April, 2021"
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{WF: Workflow Template}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex_install.bib
editor_options:
  chunk_output_type: console
type: docs
weight: 7
---

<style type="text/css">
pre code {
white-space: pre !important;
overflow-x: scroll !important;
word-break: keep-all !important;
word-wrap: initial !important;
}
</style>
<!--
- Compile from command-line
Rscript -e "rmarkdown::render('SPRinstall.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('SPRinstall.Rmd', tangle=TRUE)"; Rscript -e "rmarkdown::render('SPRinstall.Rmd', c('BiocStyle::pdf_document'))"
-->
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("h1").className = "title";
});
</script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  var links = document.links;
  for (var i = 0, linksLength = links.length; i < linksLength; i++)
    if (links[i].hostname != window.location.hostname)
      links[i].target = '_blank';
});
</script>

#

## `systemPipeR` Installation

To install the `systemPipeR` package (H Backman and Girke 2016), please use the *`BiocManager::install`* command:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("systemPipeR")
```

To obtain the most recent updates immediately, one can install it directly from
[github](https://github.com/tgirke/systemPipeR) as follow:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("tgirke/systemPipeR", build_vignettes = TRUE,
    dependencies = TRUE)
```

## Third-party software tools in *`SPR`*

This guide provides detailed installation instructions for the software tools used within `systemPipeR` package. This guide provides the instruction for a Linux system.

### BWA

[Burrow-Wheeler Aligner (BWA)](https://github.com/lh3/bwa) for short-read alignment (Li 2013).

``` bash
git clone https://github.com/lh3/bwa.git
cd bwa
make
vim ~/.bashrc ## Open the Bash shell script
export PATH=$PATH:/path/to/bwa ## "/path/to/bwa" is an example! Replace with real PATH
source ~/.bashrc
bwa ## Test if the installation was successful
```

Note: In some systems, `~/.bash_profile` is used in place of `~/.bashrc`.

More information about how to set an enviroment variable [here](https://en.wikipedia.org/wiki/Environment_variable).

### BLAST

Please check the [BLAST Command Line Applications User Manual](https://www.ncbi.nlm.nih.gov/books/NBK279671/) to
find the installation introduction for your system environment.

Download the latest version from [here](https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/), as the following example:

``` bash
wget https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.11.0+-x64-linux.tar.gz
tar zxvpf ncbi-blast-2.11.0+-x64-linux.tar.gz ncbi-blast-2.11.0+/
cd ncbi-blast-2.11.0+/
export PATH=$PATH:/path/to//ncbi-blast-2.11.0+/bin ## "/path/to/ncbi-blast-2.11.0+" is an example! Replace with real PATH
```

### Cutadapt

Please check the [Cutadapt Manual](https://cutadapt.readthedocs.io/en/stable/installation.html) to
find the installation introduction for your system environment.

``` bash
sudo apt install cutadapt
```

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-H_Backman2016-bt" class="csl-entry">

H Backman, Tyler W, and Thomas Girke. 2016. “<span class="nocase">systemPipeR: NGS workflow and report generation environment</span>.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

<div id="ref-Li2013-sw" class="csl-entry">

Li, Heng. 2013. “Aligning Sequence Reads, Clone Sequences and Assembly Contigs with BWA-MEM,” March. <http://arxiv.org/abs/1303.3997>.

</div>

</div>

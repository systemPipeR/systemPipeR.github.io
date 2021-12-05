---
title: "Introduction" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 05 December, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeR: Workflow design and reporting generation environment}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex.bib
editor_options: 
  chunk_output_type: console
type: docs
weight: 1
---

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

# Introduction

[*`systemPipeR`*](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html)
provides flexible utilities for designing, building, and running automated nd-to-end analysis
workflows for a wide range of research applications, including next-generation
sequencing (NGS) experiments (H Backman and Girke 2016). Important features include a
uniform workflow interface across different data analysis applications, automated
report generation, and support for running both R and command-line software,
on local computers or compute clusters (see Figure <a href="#fig:utilities">1</a>).
The latter supports interactive job submissions and batch submissions to queuing
systems of clusters.

It has been designed to improve the reproducibility of large-scale data analysis
projects while substantially reducing the time it takes to analyze complex omics
data sets. Its unique features include a uniform workflow interface and management
system that allows the user to run selected steps, customize, and design entirely
new workflows. Also, the package features take advantage of central community S4
classes of the Bioconductor ecosystem and command-line-based software support.

The main motivation and advantages of using *`systemPipeR`* for complex data analysis tasks are:

1.  Facilitates the design of complex workflows involving multiple R/Bioconductor packages
2.  Common workflow interface for different applications
3.  Makes analysis with Bioconductor utilities more accessible to new users
4.  Simplifies usage of command-line software from within R
5.  Reduces the complexity of using compute clusters for R and command-line software
6.  Accelerates runtime of workflows via parallelization on computer systems with multiple CPU cores and/or multiple compute nodes
7.  Improves reproducibility by automating analyses and generation of analysis reports

<div class="figure" style="text-align: center">

<img src="utilities.png" alt="Relevant features in `systemPipeR`. Workflow design concepts are illustrated under (A &amp; B). Examples of *systemPipeR's* visualization functionalities are given under (C)." width="100%" />
<p class="caption">
Figure 1: Relevant features in `systemPipeR`. Workflow design concepts are illustrated under (A & B). Examples of *systemPipeR’s* visualization functionalities are given under (C).
</p>

</div>

A central concept for designing workflows within the *`systemPipeR`* environment
is the use of workflow management containers.
Workflow management containers allow the automation of design, build, run and
scale different steps and tools in data analysis.
*`systemPipeR`* adopted the widely used community standard [Common Workflow Language](https://www.commonwl.org/) (CWL)
(Amstutz et al. 2016) for describing parameters analysis workflows in a generic and reproducible
manner. Using this community standard in *`systemPipeR`*
has many advantages. For instance, the integration of CWL allows running *`systemPipeR`*
workflows from a single specification instance either entirely from within R, from various command-line wrappers (e.g., *cwl-runner*) or from other languages (*, e.g.,* Bash or Python).
*`systemPipeR`* includes support for both command-line and R/Bioconductor software
as well as resources for containerization, parallel evaluations on computer clusters
along with the automated generation of interactive analysis reports.

An important feature of *`systemPipeR's`* CWL interface is that it provides two
options to run command-line tools and workflows based on CWL. First, one can
run CWL in its native way via an R-based wrapper utility for *cwl-runner* or
*cwl-tools* (CWL-based approach). Second, one can run workflows using CWL’s
command-line and workflow instructions from within R (R-based approach). In the
latter case the same CWL workflow definition files (*e.g.* `*.cwl` and `*.yml`)
are used but rendered and executed entirely with R functions defined by
*`systemPipeR`*, and thus use CWL mainly as a command-line and workflow
definition format rather than software to run workflows. In this regard
*`systemPipeR`* also provides several convenience functions that are useful for
designing and debugging workflows, such as a command-line rendering function to
retrieve the exact command-line strings for each data set and processing step
prior to running a command-line.

This overview introduces the design of a workflow management container, an S4
class in *`systemPipeR`*, as well as the custom command-line interface,
combined with the overview of all the common analysis steps of NGS experiments.

## New workflow management interface

*`systemPipeR`* allows creation (multi-step analyses) and execution of workflow
entirely for R, with control, flexibility, and scalability of the all process.
The execution of the workflow can be sent to a HPC, can be parallelizes,
accelerating results acquisition.

The flexibility of *`systemPipeR's`* new interface workflow management class is
the driving factor behind the use of as many steps necessary for the analysis,
as well as the connection between command-line- or R-based software. The
connectivity among all workflow steps is achieved by the `SYSargsList` workflow
management class.

`SYSargsList` S4 class is a list-like container where each instance stores all the
input/output paths and parameter components required for a particular data
analysis step (see Figure <a href="#fig:sysargslistImage">2</a>).

The `SYSargsList` constructor function will generate the instances, using as data
input initial targets files, as well as two-parameter files (for details, see below).
When running preconfigured workflows, the only input the user needs to provide
is the initial targets file containing the paths to the input files (e.g., FASTQ)
along with unique sample labels. Subsequent targets instances are created
automatically, based on the connectivity establish between the steps. The
parameters required for running command-line software is provided by the
parameter (`*.cwl` and `*.yml`)) files described below.

The class store one or multiple steps, allowing central control for running,
checking status, and monitor complex workflows from start to finish. This design
enhances the systemPipeR workflow framework with a generalized, flexible, and
robust design.

<div class="figure" style="text-align: center">

<img src="sysargslist.png" alt="Workflow steps with input/output file operations are controlled by SYSargs2 objects. Each SYSargs2 instance is constructed from one targets and two param files. The only input provided by the user is the initial targets file. Subsequent targets instances are created automatically, from the previous output files. Any number of predefined or custom workflow steps are supported. One or many SYSargs2 objects are organized in an SYSargsList container." width="100%" />
<p class="caption">
Figure 2: Workflow steps with input/output file operations are controlled by SYSargs2 objects. Each SYSargs2 instance is constructed from one targets and two param files. The only input provided by the user is the initial targets file. Subsequent targets instances are created automatically, from the previous output files. Any number of predefined or custom workflow steps are supported. One or many SYSargs2 objects are organized in an SYSargsList container.
</p>

</div>

### Reference

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Amstutz2016-ka" class="csl-entry">

Amstutz, Peter, Michael R Crusoe, Nebojša Tijanić, Brad Chapman, John Chilton, Michael Heuer, Andrey Kartashov, et al. 2016. “Common Workflow Language, V1.0,” July. <https://doi.org/10.6084/m9.figshare.3115156.v2>.

</div>

<div id="ref-H_Backman2016-bt" class="csl-entry">

H Backman, Tyler W, and Thomas Girke. 2016. “<span class="nocase">systemPipeR: NGS workflow and report generation environment</span>.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

</div>

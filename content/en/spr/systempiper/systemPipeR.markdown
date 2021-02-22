---
title: "Introduction" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 21 February, 2021" 
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

<!--
- Compile from command-line
Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeR.Rmd', tangle=TRUE)"; Rscript ../md2jekyll.R systemPipeR.knit.md 2; Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::pdf_document'))"
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

**Note:** if you use *`systemPipeR`* in published research, please cite:
Backman, T.W.H and Girke, T. (2016). *`systemPipeR`*: NGS Workflow and Report Generation Environment. *BMC Bioinformatics*, 17: 388. [10.1186/s12859-016-1241-0](https://doi.org/10.1186/s12859-016-1241-0).

## Introduction

[*`systemPipeR`*](http://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) provides flexible utilities for building and running automated end-to-end analysis workflows for a wide range of research applications, including next-generation sequencing (NGS) experiments, such as RNA-Seq, ChIP-Seq, VAR-Seq and Ribo-Seq (H Backman and Girke 2016). Important features include a uniform workflow interface across different data analysis applications, automated report generation, and support for running both R and command-line software, such as NGS aligners or peak/variant callers, on local computers or compute clusters (Figure 1). The latter supports interactive job submissions and batch submissions to queuing systems of clusters. For instance, *`systemPipeR`* can be used with most command-line aligners such as `BWA` (Heng Li 2013; H. Li and Durbin 2009), `HISAT2` (Kim, Langmead, and Salzberg 2015), `TopHat2` (Kim et al. 2013) and `Bowtie2` (Langmead and Salzberg 2012), as well as the R-based NGS aligners [*`Rsubread`*](http://www.bioconductor.org/packages/devel/bioc/html/Rsubread.html) (Liao, Smyth, and Shi 2013) and [*`gsnap (gmapR)`*](http://www.bioconductor.org/packages/devel/bioc/html/gmapR.html) (Wu and Nacu 2010). Efficient handling of complex sample sets (*e.g.* FASTQ/BAM files) and experimental designs are facilitated by a well-defined sample annotation infrastructure which improves reproducibility and user-friendliness of many typical analysis workflows in the NGS area (Lawrence et al. 2013).

The main motivation and advantages of using *`systemPipeR`* for complex data analysis tasks are:

1.  Facilitates the design of complex NGS workflows involving multiple R/Bioconductor packages
2.  Common workflow interface for different NGS applications
3.  Makes NGS analysis with Bioconductor utilities more accessible to new users
4.  Simplifies usage of command-line software from within R
5.  Reduces the complexity of using compute clusters for R and command-line software
6.  Accelerates runtime of workflows via parallelization on computer systems with multiple CPU cores and/or multiple compute nodes
7.  Improves reproducibility by automating analyses and generation of analysis reports

<center>
<img src="utilities.png">
</center>

**Figure 1:** Relevant features in *`systemPipeR`*.
Workflow design concepts are illustrated under (A & B). Examples of
*systemPipeR’s* visualization functionalities are given under (C). </br>

A central concept for designing workflows within the *`systemPipeR`* environment
is the use of workflow management containers. In previous versions, *`systemPipeR`*
used a custom command-line interface called *`SYSargs`* (see Figure 3) and for
this purpose will continue to be supported for some time. With the latest [Bioconductor Release 3.9](http://www.bioconductor.org/packages/release/bioc/html/systemPipeR.html),
we are adopting for this functionality the widely used community standard
[Common Workflow Language](https://www.commonwl.org/) (CWL) for describing
analysis workflows in a generic and reproducible manner, introducing *`SYSargs2`*
workflow control class (see Figure 2). Using this community standard in *`systemPipeR`*
has many advantages. For instance, the integration of CWL allows running *`systemPipeR`*
workflows from a single specification instance either entirely from within R, from various command-line
wrappers (e.g., *cwl-runner*) or from other languages (*, e.g.,* Bash or Python).
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

This overview introduces the design of a new CWL S4 class in *`systemPipeR`*,
as well as the custom command-line interface, combined with the overview of all
the common analysis steps of NGS experiments.

### Workflow design structure using *`SYSargs2`*

The flexibility of *`systemPipeR's`* new interface workflow control class is the driving factor behind
the use of as many steps necessary for the analysis, as well as the connection
between command-line- or R-based software. The connectivity among all
workflow steps is achieved by the *`SYSargs2`* workflow control class (see Figure 3).
This S4 class is a list-like container where each instance stores all the
input/output paths and parameter components required for a particular data
analysis step. *`SYSargs2`* instances are generated by two constructor
functions, *loadWorkflow* and *renderWF*, using as data input *targets* or
*yaml* files as well as two *cwl* parameter files (for details see below). When
running preconfigured workflows, the only input the user needs to provide is
the initial *targets* file containing the paths to the input files (*e.g.*
FASTQ) along with unique sample labels. Subsequent targets instances are
created automatically. The parameters required for running command-line
software is provided by the parameter (*.cwl*) files described below.

We also introduce the *`SYSargs2Pipe`* class that organizes one or many
SYSargs2 containers in a single compound object capturing all information
required to run, control and monitor complex workflows from start to finish. This
design enhances the *`systemPipeR`* workflow framework with a generalized,
flexible, and robust design.

<center>
<img src="SYS_WF.png">
</center>

**Figure 2:** Workflow steps with input/output file operations are controlled by
*`SYSargs2`* objects. Each *`SYSargs2`* instance is constructed from one *targets*
and two *param* files. The only input provided by the user is the initial *targets*
file. Subsequent *targets* instances are created automatically, from the previous
output files. Any number of predefined or custom workflow steps are supported. One
or many *`SYSargs2`* objects are organized in an *`SYSargs2Pipe`* container.

### Workflow Management using *`SYSargsList`*

**systemPipeR** allows creation (multi-step analyses) and execution of workflow entirely for R, with control, flexibility, and scalability of the all process. The execution of the workflow can be sent to a HPC, can be parallelizes, accelerating results acquisition. A workflow management system provides an infrastructure for the set-up, performance and monitoring of a defined sequence of tasks, arranged as a workflow application.

<center>
<img src="sysargslist.png">
</center>

**Figure 3:** Workflow Management using *`SYSargsList`*.

### Workflow design structure using *`SYSargs`*: Previous version

Instances of this S4 object class are constructed by the *`systemArgs`* function
from two simple tabular files: a *`targets`* file and a *`param`* file. The latter
is optional for workflow steps lacking command-line software. Typically, a
*`SYSargs`* instance stores all sample-level inputs as well as the paths to the
corresponding outputs generated by command-line- or R-based software generating
sample-level output files, such as read preprocessors (trimmed/filtered FASTQ
files), aligners (SAM/BAM files), variant callers (VCF/BCF files) or peak callers
(BED/WIG files). Each sample level input/output operation uses its own *`SYSargs`*
instance. The outpaths of *`SYSargs`* usually define the sample inputs for the
next *`SYSargs`* instance. This connectivity is established by writing the
outpaths with the *`writeTargetsout`* function to a new *`targets`* file that
serves as input to the next *`systemArgs`* call. Typically, the user has to
provide only the initial *`targets`* file. All downstream *`targets`* files are
generated automatically. By chaining several *`SYSargs`* steps together one can
construct complex workflows involving many sample-level input/output file
operations with any combination of command-line or R-based software.

<center>
<img src="SystemPipeR_Workflow.png">
</center>

**Figure 4:** Workflow design structure of *`systemPipeR`* using *`SYSargs`*.

### Reference

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-H_Backman2016-bt" class="csl-entry">

H Backman, Tyler W, and Thomas Girke. 2016. “<span class="nocase">systemPipeR: NGS workflow and report generation environment</span>.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

<div id="ref-Kim2015-ve" class="csl-entry">

Kim, Daehwan, Ben Langmead, and Steven L Salzberg. 2015. “HISAT: A Fast Spliced Aligner with Low Memory Requirements.” *Nat. Methods* 12 (4): 357–60.

</div>

<div id="ref-Kim2013-vg" class="csl-entry">

Kim, Daehwan, Geo Pertea, Cole Trapnell, Harold Pimentel, Ryan Kelley, and Steven L Salzberg. 2013. “TopHat2: Accurate Alignment of Transcriptomes in the Presence of Insertions, Deletions and Gene Fusions.” *Genome Biol.* 14 (4): R36. <https://doi.org/10.1186/gb-2013-14-4-r36>.

</div>

<div id="ref-Langmead2012-bs" class="csl-entry">

Langmead, Ben, and Steven L Salzberg. 2012. “Fast Gapped-Read Alignment with Bowtie 2.” *Nat. Methods* 9 (4): 357–59. <https://doi.org/10.1038/nmeth.1923>.

</div>

<div id="ref-Lawrence2013-kt" class="csl-entry">

Lawrence, Michael, Wolfgang Huber, Hervé Pagès, Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T Morgan, and Vincent J Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Comput. Biol.* 9 (8): e1003118. <https://doi.org/10.1371/journal.pcbi.1003118>.

</div>

<div id="ref-Li2009-oc" class="csl-entry">

Li, H, and R Durbin. 2009. “Fast and Accurate Short Read Alignment with Burrows-Wheeler Transform.” *Bioinformatics* 25 (14): 1754–60. <https://doi.org/10.1093/bioinformatics/btp324>.

</div>

<div id="ref-Li2013-oy" class="csl-entry">

Li, Heng. 2013. “Aligning Sequence Reads, Clone Sequences and Assembly Contigs with BWA-MEM.” *arXiv \[q-Bio.GN\]*, March. <http://arxiv.org/abs/1303.3997>.

</div>

<div id="ref-Liao2013-bn" class="csl-entry">

Liao, Yang, Gordon K Smyth, and Wei Shi. 2013. “The Subread Aligner: Fast, Accurate and Scalable Read Mapping by Seed-and-Vote.” *Nucleic Acids Res.* 41 (10): e108. <https://doi.org/10.1093/nar/gkt214>.

</div>

<div id="ref-Wu2010-iq" class="csl-entry">

Wu, T D, and S Nacu. 2010. “Fast and <span class="nocase">SNP-tolerant</span> Detection of Complex Variants and Splicing in Short Reads.” *Bioinformatics* 26 (7): 873–81. <https://doi.org/10.1093/bioinformatics/btq057>.

</div>

</div>

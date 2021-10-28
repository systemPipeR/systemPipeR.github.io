---
title: "SPR detailed installation instructions" 
author: "Author: Daniela Cassol (danicassol@gmail.com)"
date: "Last update: 28 October, 2021" 
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
weight: 8
---

<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>

<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />

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

## `systemPipeR` Installation

To install the `systemPipeR` package (H Backman and Girke 2016), please use
the *`BiocManager::install`* command:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("systemPipeR")
```

To obtain the most recent updates immediately, one can install it directly from
[GitHub](https://github.com/tgirke/systemPipeR) as follow:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("tgirke/systemPipeR", dependencies = TRUE)
```

## Third-party software tools in *`SPR`*

Current, *systemPipeR* provides the *`param`* file templates for third-party
software tools. Please check the listed software tools.

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;">
Tool Name
</th>
<th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;">
Description
</th>
<th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;">
Step
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
<a href="http://bio-bwa.sourceforge.net/bwa.shtml">bwa</a>
</td>
<td style="text-align:center;">
BWA is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome. 
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #8FBC8F !important;">Alignment</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml">Bowtie2</a>
</td>
<td style="text-align:center;">
Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #8FBC8F !important;">Alignment</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="http://hannonlab.cshl.edu/fastx_toolkit/commandline.html">FASTX-Toolkit</a>
</td>
<td style="text-align:center;">
FASTX-Toolkit is a collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #EC7770 !important;">Read Preprocessing</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="http://hibberdlab.com/transrate/">TransRate</a>
</td>
<td style="text-align:center;">
Transrate is software for de-novo transcriptome assembly quality analysis.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #D98576 !important;">Quality</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="http://research-pub.gene.com/gmap/">Gsnap</a>
</td>
<td style="text-align:center;">
GSNAP is a genomic short-read nucleotide alignment program.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #8FBC8F !important;">Alignment</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="http://www.htslib.org/doc/samtools-1.2.html">Samtools</a>
</td>
<td style="text-align:center;">
Samtools is a suite of programs for interacting with high-throughput sequencing data.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #D08C79 !important;">Post-processing</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="http://www.usadellab.org/cms/?page=trimmomatic">Trimmomatic</a>
</td>
<td style="text-align:center;">
Trimmomatic is a flexible read trimming tool for Illumina NGS data.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #EC7770 !important;">Read Preprocessing</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://bioconductor.org/packages/release/bioc/vignettes/Rsubread/inst/doc/SubreadUsersGuide.pdf">Rsubread</a>
</td>
<td style="text-align:center;">
Rsubread is a Bioconductor software package that provides high-performance alignment and read counting functions for RNA-seq reads.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #8FBC8F !important;">Alignment</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://broadinstitute.github.io/picard/">Picard</a>
</td>
<td style="text-align:center;">
Picard is a set of command line tools for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #B4A082 !important;">Manipulating HTS data</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://busco.ezlab.org/">Busco</a>
</td>
<td style="text-align:center;">
BUSCO assesses genome assembly and annotation completeness with Benchmarking Universal Single-Copy Orthologs.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #D98576 !important;">Quality</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://ccb.jhu.edu/software/hisat2/manual.shtml">Hisat2</a>
</td>
<td style="text-align:center;">
HISAT2 is a fast and sensitive alignment program for mapping NGS reads (both DNA and RNA) to reference genomes.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #8FBC8F !important;">Alignment</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://ccb.jhu.edu/software/tophat/manual.shtml">Tophat2</a>
</td>
<td style="text-align:center;">
TopHat is a fast splice junction mapper for RNA-Seq reads.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #8FBC8F !important;">Alignment</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://gatk.broadinstitute.org/hc/en-us">GATK</a>
</td>
<td style="text-align:center;">
Variant Discovery in High-Throughput Sequencing Data.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #FF6A6A !important;">Variant Discovery</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://github.com/alexdobin/STAR">STAR</a>
</td>
<td style="text-align:center;">
STAR is an ultrafast universal RNA-seq aligner.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #8FBC8F !important;">Alignment</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://github.com/FelixKrueger/TrimGalore">Trim\_galore</a>
</td>
<td style="text-align:center;">
Trim Galore is a wrapper around Cutadapt and FastQC to consistently apply adapter and quality trimming to FastQ files.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #EC7770 !important;">Read Preprocessing</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://github.com/TransDecoder/TransDecoder/wiki">TransDecoder</a>
</td>
<td style="text-align:center;">
TransDecoder identifies candidate coding regions within transcript sequences.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #ABA785 !important;">Find Coding Regions</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://github.com/trinityrnaseq/trinityrnaseq/wiki">Trinity</a>
</td>
<td style="text-align:center;">
Trinity assembles transcript sequences from Illumina RNA-Seq data.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #A1AE88 !important;">denovo Transcriptome Assembly</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://github.com/Trinotate/Trinotate.github.io/wiki">Trinotate</a>
</td>
<td style="text-align:center;">
Trinotate is a comprehensive annotation suite designed for automatic functional annotation of transcriptomes.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #F5706D !important;">Transcriptome Functional Annotation</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://macs3-project.github.io/MACS/">MACS2</a>
</td>
<td style="text-align:center;">
MACS2 identifies transcription factor binding sites in ChIP-seq data.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #C7937C !important;">Peak calling</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://pachterlab.github.io/kallisto/manual">Kallisto</a>
</td>
<td style="text-align:center;">
kallisto is a program for quantifying abundances of transcripts from RNA-Seq data.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #E37E73 !important;">Read counting</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://samtools.github.io/bcftools/howtos/index.html">BCFtools</a>
</td>
<td style="text-align:center;">
BCFtools is a program for variant calling and manipulating files in the Variant Call Format (VCF) and its binary counterpart BCF.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #FF6A6A !important;">Variant Discovery</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://www.bioinformatics.babraham.ac.uk/projects/bismark/">Bismark</a>
</td>
<td style="text-align:center;">
Bismark is a program to map bisulfite treated sequencing reads to a genome of interest and perform methylation calls in a single step.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #98B58B !important;">Bisulfite mapping</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://www.bioinformatics.babraham.ac.uk/projects/fastqc/">Fastqc</a>
</td>
<td style="text-align:center;">
FastQC is a quality control tool for high throughput sequence data.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #D98576 !important;">Quality</span>
</td>
</tr>
<tr>
<td style="text-align:center;">
<a href="https://www.ncbi.nlm.nih.gov/books/NBK279690/">Blast</a>
</td>
<td style="text-align:center;">
BLAST finds regions of similarity between biological sequences.
</td>
<td style="text-align:center;">
<span style=" font-weight: bold;    color: white !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: #BD997F !important;">Blast</span>
</td>
</tr>
</tbody>
</table>

</div>

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-H_Backman2016-bt" class="csl-entry">

H Backman, Tyler W, and Thomas Girke. 2016. “<span class="nocase">systemPipeR: NGS workflow and report generation environment</span>.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

</div>

</div>

---
title: "RNAseq"
linkTitle: "RNAseq"
type: docs
weight: 2
---

## RNA-Seq Module

<video src="https://github.com/systemPipeR/sp_tutorials/blob/main/videos/sps1.8/module_rnaseq.webm?raw=true" style="width: 100%; aspect-ratio: 16 / 9"  controls></video>

This is a module which takes a **raw count table** to do normalization, 
Differential gene expression (DEG) analysis, and finally helps users to generate 
different plots to visualize the results. 


### Prepare metadata and count table
To start, we require two files, the metadata file (targets) and a raw count table (Fig. 5).  

<center>

![rna_data](../img/sps_rna_data.jpg)

</center>

**Figure 5** RNAseq 

1. This is the RNAseq module UI when you first click it. All sub-tabs are disbled 
at the beginning. Other tabs will enabled as you proceed with different options.
2. First, we need a metadata file to tell SPS what samples and conditions to use. 
Here, we use the metadata file from SPR, which is also known as "targets" file. 
If you are not familiar with the targets file, we suggest to use the workflow module 
step 2 to practice creating and checking the format. You can also use the example to 
see how it looks like. 
3. The loaded targets table is display here. You can use the box below each column 
name to filter what samples to include/exclude. Only the "SampleName" and "Factor"
columns are used, other columns are ignored. `SampleName` should be a unique character 
string without space for each row.  `Factor` is the experiment design factors, or 
conditions, or treatments. 
4. If you want to DEG analysis, DEG comparison groups are defined in the targets 
file header. 
5. The header will be parsed into comparison groups which contain individual comparisons.
If the parsed comparison is not what you want, edit the header lines and reupload.
6. If everything is expected, confirm to use this table. 
7. You should see the progress timeline of step 1 becomes green if your targets 
and header pass the format checking. 
8. (Not on  figure) Similarly, use example or upload a count table and confirm to use it. 

Note: For the count table, the first column will be used as gene names. Other column 
names will be treated as sample names, and values in these columns are treated as 
raw counts. Make sure columns except the first one are **numeric**, and replace `NA` 
with `0`.

Upon successfully confirm targets and count table, you should see the "Normalize Data"
subtab is enabled. You can click on the top navigation or click the pop-up for the next 
step. 

### Process raw count 
If this UI is displayed, that means your targets and count table are accepted by 
SPS (Fig 6). On this sub-tab, you can choose: 

1. Transform your count data with "raw", "rlog" or "VST" and visualize the results
in other sub-tabs.
2. Do DEG analysis. 

These two options are independent. 

<center>

![rna_norm](../img/sps_rna_norm.jpg)

</center>

**Figure 6** RNAseq Normalization

1. At step 1 panel, choose how SPS can help you, count transformation or DEG analysis. 
The former will jump you to step 2, latter will jump to step 3. 
2. There are many options. If you are not clear, hover your mouse on the option, 
and some tips will show up. 
3. To start data transformation or DEG analysis. 
4. A gallery of different plot options will show up when the data process is done. 
5. When the data process is done, you can download results from the right side panel.
Check all items you want and SPS will help you to zip it into one file to download.
6. If at least one item is checked, downloading is enabled. 
7. Progress timeline will also change upon successful data process.
8. Different visualization options will be enabled depending on the data process options. 


### Plot options

SPS RNAseq module provides 6 different plot options to cluster transformed count table. 

<center>

![rna_plot](../img/sps_rna_plot.jpg)

</center>

**Figure 6** RNAseq plots

1. Change plot options to customize your plots. 
2. Most plots are [Plotly](https://plotly.com) plots, which means you can interact 
with these plots, like hiding/show groups, zoom in/out, etc. 
3. All SPS plots are resizable. Drag the bottom-right corner icon to resize your 
plot.
4. Click "To canvas" to take a screenshot of current plot and edit it in `SPS Canvas`
tab. Or clicking the down-arrow button to directly save current plot to a png or jpg. 

### DEG report 
This is a special sub-tab designed to filter and visualize DEG results. This sub-tab 
can be accessed once the DEG is calculated on the "Normalize Data" sub-tab. 


<center>

![rna_deg](../img/sps_rna_deg.jpg)

</center>

**Figure 7** RNAseq DEG

1. DEG summary plot. You can view what are the DEG results across different comparision 
groups. 
2. Switch to view a ggplot friendly table. Different from the table you could download from 
"Normalize Data" subtab, this DEG table is rearranged so you can easily make a ggplot from it. 
3. You can change the filter settings here, so DEGs will be re-filtered and you do not need 
to go back to "Normalize Data" subtab to recalculate DEG. 
4. DEG plotting options. Choose from a volcano plot, an upset plot (intersection), 
a MA plot or a heatmap. 


### Interact with other bioconductor packages.

#### Locally
If you are familiar with R and want to continue other analysis after these, simple stop SPS: 

1. After count transformation, there is a `spsRNA_trans` object stored in your R 
environment. `raw` method gives you a normalized count table. Other two methods 
give you a `DESeq2` class object. You can use it for other analysis.
2.  After DEG analysis,  SPS stores a global object called `spsDEG.`
It is a `summerizedExperiment` object which has all individual tables from all 
DEG comparisons. You can use it for other downstream analysis.


#### Remotely
If you are using SPS from a remote server, you can choose to download results from 
"Normalize Data" sub-tab. Choose results in tabular format or `summerizedExperiment`
format which is saved in a `.rds` file. 

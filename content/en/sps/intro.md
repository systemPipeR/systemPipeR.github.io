---
title: "Introduction"
linkTitle: "Introduction"
type: docs
weight: 1
---

**<span style="color:#5DA7D6;">s</span>ystem<span
style="color:#5DA7D6;">P</span>ipe<span style="color:#5DA7D6;">S</span>hiny**
(SPS) extends the widely used [systemPipeR](/spr/) 
(SPR) workflow
environment with a versatile graphical user interface provided by a [Shiny
App](https://shiny.rstudio.com). This allows non-R users, such as
experimentalists, to run many systemPipeR's workflow designs, control, and
visualization functionalities interactively without requiring knowledge of R.
Most importantly, `SPS` has been designed as a general purpose framework for
interacting with other R packages in an intuitive manner. Like most Shiny Apps,
SPS can be used on both local computers as well as centralized server-based
deployments that can be accessed remotely as a public web service for using
SPR's functionalities with community and/or private data. The framework can
integrate many core packages from the R/Bioconductor ecosystem. Examples of
SPS' current functionalities include: (a) interactive creation of experimental
designs and metadata using an easy to use tabular editor or file uploader; (b)
visualization of workflow topologies combined with auto-generation of R
Markdown preview for interactively designed workflows; (c) access to a wide
range of data processing routines; (d) and an extendable set of visualization
functionalities. Complex visual results can be managed on a 'Canvas Workbench'
allowing users to organize and to compare plots in an efficient manner combined
with a session snapshot feature to continue work at a later time. The present
suite of pre-configured visualization examples include different methods to
plot a count table. The modular design of 
SPR makes it easy to design custom functions without any knowledge of Shiny, 
as well as extending the environment in the future with contributions from 
the community.

## Demo
Take a look at the demo app:

<a 
href="https://tgirke.shinyapps.io/systemPipeShiny/" 
style="background-color: #eee;border-radius: 10px;border: #c2daf7f5 solid 4px; font-weight: 800; font-size: 1.5rem; margin-left: 40%">
Try a demo!
</a>



## Main functionalities 

Currently, `SPS` includes 3 main functional categories (*Fig 1*): 

 1. Some pre-defined modules include: 
    a. A workbench for designing and configuring data analysis workflows, 
    b. Downstream analysis and visualization tools for RNA-Seq, and 
    c. A space to make quick ggplots. 
 2. A section with user custom tabs: users define their own shiny tabs.  
 3. An image editing tab "Canvas" which allows users to edit plots made from 
    the previous two categories. 

Besides, SPS provides many functions to extend the default Shiny development, like 
more UI components, server functions. Also, SPS has some useful general R ulitlies
like error catching, logging, and more. 

<center id="sps_structure">

![SPS_structure](../img/sps_structure.jpg)

</center>

**Figure 1.** Design of `systemPipeShiny.` 

The framework provides an
interactive web interface for workflow management and data visualization.

Within the functional categories, `SPS` functions are modularized in
sub-components, here referred to as **SPS tabs** that are similar to 
menu tabs in other GUI applications that organize related and inter-connected 
functionalies into groups. On the backend, **SPS tabs** are based on [Shiny modules](https://shiny.rstudio.com/articles/modules.html), 
that are stored in separate files. This modular structure is highly extensible 
and greatly simplifies the design of new `SPS` tabs by both users and/or developers. 
Details about extending existing tabs and designing new ones are provided in 
[advanced sections on our website](https://systempipe.org/sps/). 


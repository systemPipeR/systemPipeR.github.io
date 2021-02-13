---
title: "Introduction"
linkTitle: "Introduction"
type: docs
weight: 1
---

*****

## Main functionalities 

Currently, `SPS` includes 3 main functional categories (*Fig 1*): 

 1. Some pre-defined modules ([tabs](#sps-tabs)) include: 
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

**Figure 1.** Design of SPS

The framework provides an
interactive web interface for workflow management and data visualization.

## SPS tabs

Within the functional categories, `SPS` functions are modularized into
sub-components, here referred to as **SPS tabs** that are similar to 
menu tabs in other GUI applications that organize related and inter-connected 
functionalies into groups. On the backend, **SPS tabs** are based on [Shiny modules](https://shiny.rstudio.com/articles/modules.html), 
that are stored in separate files. This modular structure is highly extensible 
and greatly simplifies the design of new `SPS` tabs by both users and/or developers. 
Details about extending existing tabs and designing new ones are provided in 
[Manage tabs section on our website](https://systempipe.org/sps/adv_features/tabs/). 


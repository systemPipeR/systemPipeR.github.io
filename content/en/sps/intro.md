---
title: "Introduction"
linkTitle: "Introduction"
type: docs
weight: 1
---

<script src="/rmarkdown-libs/spsComps-js/js/sps-comps.js"></script>

<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />

------------------------------------------------------------------------

## Main functionalities

Currently, `SPS` includes 3 main functional categories (*Fig 1*):

1.  Some pre-defined modules ([tabs](#sps-tabs)) include:
    1.  A workbench for designing and configuring data analysis workflows,
    2.  Downstream analysis and visualization tools for RNA-Seq, and
    3.  A space to make quick ggplots.
2.  A section with user custom tabs: users define their own shiny tabs.  
3.  An image editing tab “Canvas” which allows users to edit plots made from
    the previous two categories.

Besides, SPS provides many functions to extend the default Shiny development, like
more UI components, server functions. Also, SPS has some useful general R ulitlies
like error catching, logging, and more.

<center id="sps_structure">
<img src="../img/sps_structure.png" style="height: 500px;"></img>
</center>

**Figure 1.** SPS Features

The framework provides an
interactive web interface for workflow management and data visualization.

## Detailed features

To know more about SPS features, find your favorite section below and click the link
below to navigate to the section, or use the left sidebar menu to navigate.

<div id="gallery4791515" class="col sps-gallery" style="">
<p class="text-center h2" style="color: #0275d8;">SPS Features</p>
<div class="row" style="  margin: 10px;"><div  id=gallery4791515-1 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="../img/sps_structure.png" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-1")
  >
  <a href="/sps/intro/" ><p class="text-center h4 ">App structure</p></a>
</div> <div  id=gallery4791515-2 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/user_login.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-2")
  >
  <a href="/sps/adv_features/login/#main-app-login" ><p class="text-center h4 ">User login</p></a>
</div> <div  id=gallery4791515-3 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://systempipe.org/sps/adv_features/login_theme.gif" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-3")
  >
  <a href="/sps/adv_features/login/#main-app-login" ><p class="text-center h4 ">Loading themes</p></a>
</div> <div  id=gallery4791515-4 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/wf_main.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-4")
  >
  <a href="/sps/modules/workflow/" ><p class="text-center h4 ">Workflow module</p></a>
</div> <div  id=gallery4791515-5 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/wf_targets.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-5")
  >
  <a href="/sps/modules/workflow/#2-prepare-a-target-file" ><p class="text-center h4 ">Workflow metadata</p></a>
</div> <div  id=gallery4791515-6 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/wf_wf.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-6")
  >
  <a href="/sps/modules/workflow/#3-prepare-a-workflow-file" ><p class="text-center h4 ">Workflow step selection & desgin</p></a>
</div> <div  id=gallery4791515-7 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/wf_run.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-7")
  >
  <a href="/sps/modules/workflow/#5-run-or-finish-workflow-preparation" ><p class="text-center h4 ">Workflow Execution</p></a>
</div> <div  id=gallery4791515-8 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/rnaseq_normalize.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-8")
  >
  <a href="/sps/modules/rnaseq/" ><p class="text-center h4 ">RNAseq normalization</p></a>
</div> <div  id=gallery4791515-9 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/rnaseq_deg.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-9")
  >
  <a href="/sps/modules/rnaseq/#deg-report" ><p class="text-center h4 ">RNAseq DEG</p></a>
</div> <div  id=gallery4791515-10 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/rnaseq_heatmap.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-10")
  >
  <a href="/sps/modules/rnaseq/#plot-options" ><p class="text-center h4 ">RNAseq plots</p></a>
</div> <div  id=gallery4791515-11 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/canvas.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-11")
  >
  <a href="/sps/canvas/" ><p class="text-center h4 ">Canvas Module</p></a>
</div> <div  id=gallery4791515-12 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/admin_login.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-12")
  >
  <a href="/sps/adv_features/login/#admin-page" ><p class="text-center h4 ">Admin login</p></a>
</div> <div  id=gallery4791515-13 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/admin_server_info.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-13")
  >
  <a href="/sps/adv_features/login/#app-information" ><p class="text-center h4 ">Admin app stats</p></a>
</div> <div  id=gallery4791515-14 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/admin_user_control.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-14")
  >
  <a href="/sps/adv_features/login/#account-control" ><p class="text-center h4 ">Admin user control</p></a>
</div> <div  id=gallery4791515-15 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/sps_notification.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-15")
  >
  <a href="/sps/adv_features/notification/" ><p class="text-center h4 ">Customizable notifications</p></a>
</div> <div  id=gallery4791515-16 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/sps_guide.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-16")
  >
  <a href="/sps/adv_features/guide/" ><p class="text-center h4 ">Customizable interactive tutorials</p></a>
</div> <div  id=gallery4791515-17 class="col-sm-2 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/logging.png?raw=true" class="img-gallery"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery4791515-17")
  >
  <a href="/sps/adv_features/debug/" ><p class="text-center h4 ">Logging and error handling</p></a>
</div></div>
<!--SHINY.SINGLETON[7fdec3ac87205a269983f4a367a45b9599c89d0b]-->
<div id="sps-gallery-modal" class="gallery-modal" onclick="galModalClose()">
<span class="gallery-modal-close">X</span>
<img id="sps-gallery-modal-content" class="gallery-modal-content"/>
<div class="gallery-caption"></div>
</div>
<!--/SHINY.SINGLETON[7fdec3ac87205a269983f4a367a45b9599c89d0b]-->
<script>fixGalHeight("gallery4791515")</script>
</div>

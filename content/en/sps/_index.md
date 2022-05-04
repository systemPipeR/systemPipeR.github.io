---
title: "systemPipeShiny Documentation"
linkTitle: "systemPipeShiny"
type: docs
---

<link href="/css/home_page.css" rel="stylesheet">
<div id="svg-logo"></div>

<script src="/js/home_page.js"></script>
<script>
  loadLogo("/images/sps_logos.svg")
</script>
<style>
#svg-logo {
  background: 
    radial-gradient(circle, transparent 0%,  rgba(255,255,255,1) 30%),
    linear-gradient(to right, var(--color), var(--color)), var(--image2);
  background-repeat: no-repeat;
  background-size: auto 1200px;
  background-position: center center;
  background-blend-mode: 
    var(--blend-top, normal),
    var(--blend-bottom, saturation),
    normal;
  --image2: url("/background.jpg");
  --color-v: rgba(76,169,237,1);
  --color: rgba(76,169,237,1);
}

#svg-logo svg {
  margin: 0 auto;
  display: block;
  padding: 50px;
}
</style>



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
SPS' current functionalities include: 

- A default interactive workflow module to 
create experimental designs, visualize and customize workflow topologies with previews, and 
programming free workflow execution within the application. 
- An interactive module with extensive plot options to visualize downstream analysis of a RNA-Seq workflow.
- A quick ggplot module to make all variety of scientific plots from any user defined 
tabular data. 
- An extendable set of visualization functionalities makes it easy to design 
custom Shiny Apps under SPS framework without any knowledge of Shiny. 
- A 'Canvas Workbench' to manage complex visual results. It allows users to 
organize and to compare plots in an efficient manner combined
with a session screenshot feature to edit scientific and publishable figures. 
- Three other supporting packages to help all users from beginners and advanced developers 
to extend under current SPS framework or on their own visualization apps. 

## Demo
View our online demo app:

| Type and link| option changed | notes |
| --- | --- | --- |
| [Default full installation{blk}](https://tgirke.shinyapps.io/systemPipeShiny/) | [See installation](#installation) | full app |
| [Minimum installation{blk}](https://tgirke.shinyapps.io/systemPipeShiny/) | [See installation](#installation) | no modules installed |
| [Login enabled{blk}](https://tgirke.shinyapps.io/systemPipeShiny_loading/) | `login_screen = TRUE; login_theme = "empty"` | no modules installed |
| [Login and login themes{blk}](https://tgirke.shinyapps.io/systemPipeShiny_loading_theme/) | `login_screen = TRUE; login_theme = "random"` | no modules installed |
| [App admin page{blk}](https://tgirke.shinyapps.io/systemPipeShiny_loading/?admin) | `admin_page = TRUE` | or simply add "?admin" to the end of URL of demos |

For the login required demos, the app account name is **"user"** password **"user"**.

For the admin panel login, account name **"admin"**, password **"admin"**.

**Please DO NOT delete or change password when you are using the admin features.**
_shinyapp.io_ will reset the app once a while, but this will affect other people 
who are trying the demo simultaneously. 

### Rstudio Cloud demo
There is an [Rstudio Cloud project](https://rstudio.cloud/project/2493103) instance 
that you can also play with. You need to create a free new account. Two Bioconductor
related modules - workflow & RNAseq are not installed. They require more than 1GB 
RAM to install and to run which is beyond the limit of a free account. 

## Other packages in systemPipeShiny

| Package | Description | Documents | Function reference | Demo |
| --- | --- | --- | :---: | --- |
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/sps_small.png?raw=true" align="right" height="30" width="30"/>[systemPipeShiny{blk}](https://github.com/systemPipeR/systemPipeShiny) | SPS main package |[website](https://systempipe.org/sps/)|[link](https://systempipe.org/sps/funcs/sps/reference/)  | [demo{blk}](https://tgirke.shinyapps.io/systemPipeShiny/)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spscomps.png?raw=true" align="right" height="30" width="30" />[spsComps{blk}](https://github.com/lz100/spsComps) | SPS UI and server components |[website](https://systempipe.org/sps/dev/spscomps/)|[link](https://systempipe.org/sps/funcs/spscomps/reference/)  | [demo{blk}](https://lezhang.shinyapps.io/spsComps)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/drawer.png?raw=true" align="right" height="30" width="30" />[drawer{blk}](https://github.com/lz100/drawer) | SPS interactive image editing tool |[website](https://systempipe.org/sps/dev/drawer/)|[link](https://systempipe.org/sps/funcs/drawer/reference/)  | [demo{blk}](https://lezhang.shinyapps.io/drawer)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spsutil.png?raw=true" align="right" height="30" width="30" />[spsUtil{blk}](https://github.com/lz100/spsUtil) | SPS utility functions |[website](https://systempipe.org/sps/dev/spsutil/)|[link](https://systempipe.org/sps/funcs/spsutil/reference/)  | NA|


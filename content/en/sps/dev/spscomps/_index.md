---
title: "spsComps"
linkTitle: "spsComps"
type: docs
weight: 1
---

## SPS Components package

systemPipeShiny Components (spsComps) package is a collection of custom UI  and 
server components that are used in SPS main framework. If you see a component 
in SPS but want to outside the SPS framework, like in your own Shiny apps, 
take a look at these components. Here is a **[online demo](https://lezhang.shinyapps.io/spsComps)**
of these components. 

## Installation 

Read the [developer tools](..) main page, not repeating here. 

## Category
{spsComps} can be divided into two major categories: [UI](ui) and [server](server).

- [**UI**](ui): Shiny or HTML UI components, for example, a box, a gallery, a button, etc. With 
these most of components, you do **NOT need a server**, so they are compatible with 
R markdown documents. See the [UI](ui) page and its source code how we use the 
components in a Rmd doucment. However, some UI components has server side functions, 
mostly like `updateXXX` functions. Mainly these functions are used to update/change the 
UI based on user behaviors. It is totally okay to use the UI functions without the 
server functions (you will get static UI). 
- [**server**](server): **can only be run in the Shiny server**. These functions are designed 
to make back-end progress easier, extensions of original shiny Server functions. 

## Functions reference manual
In documents, we only highlight some important functions. Please read 
the [reference manuals](/sps/sps_funcs) for details of every function. 

## some screenshots of spsComps

#### Animations

![animation](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/animations.gif?raw=true)

#### Loaders

![loader](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/loader.gif?raw=true)

#### Buttons

##### Code display button

![display_code](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/display_code.gif?raw=true)

##### Go top button

![gotop](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/gotop.gif?raw=true)

##### Input buttons

![buttons](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/buttons.png?raw=true)

##### Button groups

![buttons_tab](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/buttons_tab.png?raw=true)

##### Table of buttons

![buttons_table](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/buttons_table.png?raw=true)

#### Gallery

![gallery](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/gallery.png?raw=true)

#### Logos

![logos](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/logos.png?raw=true)

#### Progress tracking

##### Porgress panel

![pg_panel](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/pg_panel.gif?raw=true)


##### Timeline 

![timeline](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/timeline.gif?raw=true)









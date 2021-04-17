---
title: "UI components"
linkTitle: "UI components"
type: docs
weight: 1
---
<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />
<script src="/rmarkdown-libs/sps-gotop/js/sps_gotop.js"></script>
<script src="/rmarkdown-libs/spsComps-js/js/sps-comps.js"></script>
<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />
<script src="/rmarkdown-libs/spsComps-js/js/sps-comps.js"></script>
<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />
<script src="/rmarkdown-libs/spsComps-js/js/sps-comps.js"></script>
<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />
<script src="/rmarkdown-libs/spsComps-js/js/sps-comps.js"></script>
<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />
<script src="/rmarkdown-libs/spsComps-js/js/sps-comps.js"></script>
<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />
<script src="/rmarkdown-libs/spsComps-js/js/sps-comps.js"></script>
<link href="/rmarkdown-libs/spsComps-css/css/sps-comps.css" rel="stylesheet" />
<script src="/rmarkdown-libs/sps-pop-tip/js/bs3pop_tip.js"></script>
<script src="/rmarkdown-libs/sps-pop-tip/js/bs3pop_tip.js"></script>
<script src="/rmarkdown-libs/sps-pop-tip/js/bs3pop_tip.js"></script>

## load package
To start to use `spsComps`, load it in your Shiny app file or Rmarkdown file 


```r
library(spsComps)
```

```
## Loading required package: shiny
```

```
## Loading required package: spsUtil
```

```r
library(magrittr)
```

So you can see it depends on `shiny` and `spsUtil`. When you load it, there is no 
need to additionally load `shiny` or `spsUtil`.

## UI Components 
For most of the UI components, you can view them in the [online Shiny demo](https://lezhang.shinyapps.io/spsComps).
Here we just select a few to demonstrate how you can use them **in a R markdown**. 

### `spsGoTop`

A go top button. 


```r
spsGoTop()
```

<div class="sps-gotop" id="gotop" style="right: 1rem;&#10;bottom: 10rem;&#10;fill: #337ab7;" data-toggle="tooltip" data-placement="left" title="Go Top" onclick="goTop()">
          <svg viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg">
            <path d="M526.60727968 10.90185116
              a27.675 27.675 0 0 0-29.21455937 0
              c-131.36607665 82.28402758-218.69155461 228.01873535-218.69155402
              394.07834331a462.20625001 462.20625001 0 0 0 5.36959153 69.94390903
              c1.00431239 6.55289093-0.34802892 13.13561351-3.76865779 18.80351572-32.63518765
              54.11355614-51.75690182 118.55860487-51.7569018 187.94566865a371.06718723 371.06718723 0 0 0 11.50484808 91.98906777
              c6.53300375 25.50556257 41.68394495 28.14064038 52.69160883 4.22606766 17.37162448-37.73630017
              42.14135425-72.50938081 72.80769204-103.21549295 2.18761121 3.04276886 4.15646224 6.24463696
              6.40373557 9.22774369a1871.4375 1871.4375 0 0 0 140.04691725 5.34970492 1866.36093723 1866.36093723 0 0 0 140.04691723-5.34970492
              c2.24727335-2.98310674 4.21612437-6.18497483 6.3937923-9.2178004 30.66633723 30.70611158
              55.4360664 65.4791928 72.80769147 103.21549355 11.00766384 23.91457269 46.15860503 21.27949489
              52.69160879-4.22606768a371.15156223 371.15156223 0 0 0
              11.514792-91.99901164c0-69.36717486-19.13165746-133.82216804-51.75690182-187.92578088-3.42062944-5.66790279-4.76302748-12.26056868-3.76865837-18.80351632a462.20625001
              462.20625001 0 0 0 5.36959269-69.943909c-0.00994388-166.08943902-87.32547796-311.81420293-218.6915546-394.09823051zM605.93803103
              357.87693858a93.93749974 93.93749974 0 1 1-187.89594924 6.1e-7 93.93749974 93.93749974 0 0 1 187.89594924-6.1e-7z">
            </path>
            <path d="M429.50777625 765.63860547C429.50777625 803.39355007 466.44236686
              1000.39046097 512.00932183 1000.39046097c45.56695499 0 82.4922232-197.00623328
              82.5015456-234.7518555 0-37.75494459-36.9345906-68.35043303-82.4922232-68.34111062-45.57627738-0.00932239-82.52019037
              30.59548842-82.51086798 68.34111062z">
            </path>
          </svg>
        </div>

It will not be display inline of the Rmd, just simply call it and maybe change the 
style as you want. By default, a "go to top" button will be created on the **bottom-right**
**corner**. Now scroll this page, and you should see it (the rocket button).


### `gallery`


```r
texts <- c("p1", "p2", "", "p4", "p5")
hrefs <- c("https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true",
           "https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true",
           "",
           "https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true",
           "https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true")
images <- c("https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true",
            "https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true",
            "https://github.com/lz100/spsComps/blob/master/img/3.jpg?raw=true",
            "https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true",
            "https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true")
gallery(
  texts = texts, hrefs = hrefs, images = images,
  enlarge = TRUE,
  enlarge_method = "modal"
)
```

<div id="gallery9813595" class="col sps-gallery" style="">
<p class="text-center h2" style="color: #0275d8;">Gallery</p>
<div class="row" style="  margin: 10px;"><div  id=gallery9813595-1 class="col-sm-4 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true" class="img-gallery "
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery9813595-1")
  >
  <a href="https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true"><p class="text-center h4">p1</p></a>
</div> <div  id=gallery9813595-2 class="col-sm-4 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true" class="img-gallery "
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery9813595-2")
  >
  <a href="https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true"><p class="text-center h4">p2</p></a>
</div> <div  id=gallery9813595-3 class="col-sm-4 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/lz100/spsComps/blob/master/img/3.jpg?raw=true" class="img-gallery gallery-nohover"
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery9813595-3")
  >
  <a ><p class="text-center h4">&nbsp;</p></a>
</div> <div  id=gallery9813595-4 class="col-sm-4 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true" class="img-gallery "
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery9813595-4")
  >
  <a href="https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true"><p class="text-center h4">p4</p></a>
</div> <div  id=gallery9813595-5 class="col-sm-4 sps-tab-link" style="right: 1px;">
  <img
    src="https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true" class="img-gallery "
    height=300 width=400
    style="width: 100%;"
    onclick=galEnlarge("#gallery9813595-5")
  >
  <a href="https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true"><p class="text-center h4">p5</p></a>
</div></div>
<!--SHINY.SINGLETON[7fdec3ac87205a269983f4a367a45b9599c89d0b]-->
<div id="sps-gallery-modal" class="gallery-modal" onclick="galModalClose()">
<span class="gallery-modal-close">X</span>
<img id="sps-gallery-modal-content" class="gallery-modal-content"/>
<div class="gallery-caption"></div>
</div>
<!--/SHINY.SINGLETON[7fdec3ac87205a269983f4a367a45b9599c89d0b]-->
<script>fixGalHeight("gallery9813595")</script>
</div>


You can show a gallery of plots you make in the Rmd and when people click it, 
it will be enlarged. You can also specify a link for each image. 


### Logos

#### a single one with `hexLogo`


```r
hexLogo(
    "logo", "Logo",
    hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
    hex_link = "https://www.google.com",
    footer = "Footer",
    footer_link = "https://www.google.com"
)
```

<div id="logo" class="hex-container">
  <span class="text-info">Logo</span><br>
  <svg class="hex-box" viewBox="0 0 100 115" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <pattern id="logo-hex" patternUnits="userSpaceOnUse" height="100%" width="100%">
        <image href="https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg" x="-10" y="-20" height="125%" width="125%" />
      </pattern>
    </defs>
    <a href="https://www.google.com" target="_blank"><polygon class="hex" points="50 1 95 25 95 75 50 99 5 75 5 25"fill="url(#logo-hex)" stroke="var(--primary)"stroke-width="2"/></a>
    <text x=10 y=115><a class="powerby-link"href="https://www.google.com" target="_blank">Footer</a></text>
  </svg>
</div>

#### a panel of logos with `hexPanel`

```r
hexPanel(
    "demo1", "" ,
    rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 2)
)
```

<div class="row hex-panel">
<h5 class="text-primary"></h5>
<div class="hex-item"><div id="demo11" class="hex-container">
  
  <svg class="hex-box" viewBox="0 0 100 115" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <pattern id="demo11-hex" patternUnits="userSpaceOnUse" height="100%" width="100%">
        <image href="https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg" x="-10" y="-20" height="125%" width="125%" />
      </pattern>
    </defs>
    <polygon points="50 1 95 25 95 75 50 99 5 75 5 25"fill="url(#demo11-hex)" stroke="var(--primary)"stroke-width="2"/>
    
  </svg>
</div></div>
<div class="hex-item"><div id="demo12" class="hex-container">
  
  <svg class="hex-box" viewBox="0 0 100 115" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <pattern id="demo12-hex" patternUnits="userSpaceOnUse" height="100%" width="100%">
        <image href="https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg" x="-10" y="-20" height="125%" width="125%" />
      </pattern>
    </defs>
    <polygon points="50 1 95 25 95 75 50 99 5 75 5 25"fill="url(#demo12-hex)" stroke="var(--primary)"stroke-width="2"/>
    
  </svg>
</div></div>
</div>


### Buttons

#### Some colorful buttons `hrefTab`


```r
hrefTab(
    title = "Different background and text colors",
    label_texts = c("Go top", "Disabled", "Email me"),
    hrefs = c("#", "", "mailto:xxx@abc.com"),
    bg_colors = c("green", "#eee", "orange"),
    text_colors = c("#caffc1", "black", "blue")
)
```

<div id="list-tab9250586" class="col">
<p class="h4" style="color: #0275d8; text-align: left;">Different background and text colors</p>
<div><a
  href="#"
  class="href-button sps-tab-link "
  style="background-color: green; color: #caffc1;"
 >
  Go top
</a>
 <a
  href="javascript:null;"
  class="href-button sps-tab-link nohover"
  style="background-color: #eee; color: black;"
 >
  Disabled
</a>
 <a
  href="mailto:xxx@abc.com"
  class="href-button sps-tab-link "
  style="background-color: orange; color: blue;"
 >
  Email me
</a>
</div>
</div>


#### A table colorful buttons `hrefTable`

```r
hrefTable(
    title = "Change button color and text color",
    item_titles = c("workflow 1", "No links"),
    item_labels = list(c("tab 1"), c("tab 3", "tab 4")),
    item_hrefs = list(c("https://www.google.com/"), c("", "")),
    item_bg_colors =  list(c("blue"), c("red", "orange")),
    item_text_colors =  list(c("black"), c("yellow", "green")),
    style = "display: table;"
)
```

<table id="list-table6250655" class="table table-hover table-href table-striped" style="display: table;">
<caption class="text-center h2" style="color: #0275d8;">Change button color and text color</caption>
<thead>
  <tr class="info">
    <th>Category</th>
    <th>Options</th>
  </tr>
</thead>
<tbody>  <tr>
    <td class="h4" style="color: #0275d8;">workflow 1</td>
    <td><a
  href="https://www.google.com/"
  class="href-button  sps-tab-link"
  style="background-color: blue; color: black;"
>
  tab 1
</a></td>
  </tr>
   <tr>
    <td class="h4" style="color: #0275d8;">No links</td>
    <td><a
  href="javascript:null;"
  class="href-button nohover sps-tab-link"
  style="background-color: red; color: yellow;"
>
  tab 3
</a><a
  href="javascript:null;"
  class="href-button nohover sps-tab-link"
  style="background-color: orange; color: green;"
>
  tab 4
</a></td>
  </tr>
</tbody>
</table>

```r
hrefTable(
    title = "Change row name colors and width",
    item_titles = c("Green", "Red", "Orange"),
    item_labels = list(c("tab 1"), c("tab 3", "tab 4"), c("tab 5", "tab 6", "tab 7")),
    item_hrefs = list(
        c("https://www.google.com/"),
        c("", ""),
        c("https://www.google.com/", "https://www.google.com/", "")
    ),
    item_title_colors = c("green", "red", "orange"),
    style = "display: table;"
)
```

<table id="list-table2892511" class="table table-hover table-href table-striped" style="display: table;">
<caption class="text-center h2" style="color: #0275d8;">Change row name colors and width</caption>
<thead>
  <tr class="info">
    <th>Category</th>
    <th>Options</th>
  </tr>
</thead>
<tbody>  <tr>
    <td class="h4" style="color: green;">Green</td>
    <td><a
  href="https://www.google.com/"
  class="href-button  sps-tab-link"
  style="background-color: #337ab7; color: white;"
>
  tab 1
</a></td>
  </tr>
   <tr>
    <td class="h4" style="color: red;">Red</td>
    <td><a
  href="javascript:null;"
  class="href-button nohover sps-tab-link"
  style="background-color: #337ab7; color: white;"
>
  tab 3
</a><a
  href="javascript:null;"
  class="href-button nohover sps-tab-link"
  style="background-color: #337ab7; color: white;"
>
  tab 4
</a></td>
  </tr>
   <tr>
    <td class="h4" style="color: orange;">Orange</td>
    <td><a
  href="https://www.google.com/"
  class="href-button  sps-tab-link"
  style="background-color: #337ab7; color: white;"
>
  tab 5
</a><a
  href="https://www.google.com/"
  class="href-button  sps-tab-link"
  style="background-color: #337ab7; color: white;"
>
  tab 6
</a><a
  href="javascript:null;"
  class="href-button nohover sps-tab-link"
  style="background-color: #337ab7; color: white;"
>
  tab 7
</a></td>
  </tr>
</tbody>
</table>

The table caption is on top in Shiny but on bottom in Rmd. You may also want to 
add the `style = "display: table;"` in Rmd to make the table occupy full length of 
the document in R markdown. 


### show tips with  `bsHoverPopover`

Space in a document is valuable. Sometimes you do not want to explain too much in 
the main text but still want to give readers some additional information. Use 
a popover to hide your additional text can be useful. 

#### On a button

```r
actionButton("a_btn", "A button", class = "btn-primary") %>% 
   bsHoverPopover(
                title = "title a",
                content = "popover works on a button",
                placement = "bottom"
    )
```

<button class="btn btn-default action-button btn-primary" data-content="popover works on a button" data-placement="bottom" data-toggle="popover" id="a_btn" pop-toggle="hover" title="title a" type="button">A button</button>

#### On a link

```r
tags$a(href="mailto:xxx@abc.com", "Email") %>% 
   bsHoverPopover(
                title = "Email me",
                content = "popover works on a link",
                placement = "bottom"
    )
```

<a href="mailto:xxx@abc.com" title="Email me" data-toggle="popover" data-content="popover works on a link" data-placement="bottom" pop-toggle="hover">Email</a>


#### On a plot

```r
png("random_plot.png")
plot(1:10, 10:1)
dev.off()
```

```
## png 
##   2
```

```r
tags$img(src = "../random_plot.png") %>% 
  bsHoverPopover(
              title = "My plot",
              content = "popover works on a plot",
              placement = "right"
  )
```

<img src="../random_plot.png" title="My plot" data-toggle="popover" data-content="popover works on a plot" data-placement="right" pop-toggle="hover"/>

## Other components

Other components are either performed the best in a Shiny app or requires 
a server. Please see the [demo](https://lezhang.shinyapps.io/spsComps/)

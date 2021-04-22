---
title: "SPS Guide"
linkTitle: "SPS Guide"
type: docs
weight: 5
---
*****

## SPS interative guides (tutorials)

SPS provides some interactive guides for users to familiarize the app. There is a 
very simple one-step welcome guide that will initialize everytime on app start to indicate 
where the guide dropdown is (top-right corner). 

<center>

![](../guide_init.png)

<caption>Welcome guide on start</caption>

</center>

<br>By clicking the guide dropdown menu, you can open up the list of available guides. 
By default, we only proivde a main SPS guide. 

<center>

![](../guide_main.png)

<caption>Guide dropdown menu</caption>

</center>

<br>If any of the guide is clicked in the dropdown, the corresponding interactive guide 
will start. 

<center>

![](../guide_started.png)

<caption>Guide started</caption>

</center>

You can click "Next", "Previous" or "Close" to navigate the guide or close the guide.

## Custom guide

To build and provide your custom guides to your users, there is file `guide_content.R`
created on SPS project initialization under the `R` folder: `/R/guide_content.R`.
This is the place to define your own guide. 

This file look like this:

```r
#################### Define your custom SPS tutorials ##########################
# use `shinydashboardPlus::messageItem` to add your tutorials UI to this list
guide_ui <- list(
    ## An example is provided below
    shinydashboardPlus::messageItem(
        inputId = "guide_main",
        from = "Main Guide",
        icon = icon('home'),
        message = "Brief introduction"
    )
)

# use `cicerone::Cicerone$new()` to add your tutorials content to this list
# See help `?cicerone::Cicerone`
# A named list, each item's name must match the `inputId` in UI to trigger it in app.
guide_content <- try(list(
    ## An example is provided below, replace or add your own to the list
    guide_main = cicerone::Cicerone$new(overlay_click_next = TRUE)$
        step(el = "sidebarItemExpanded",
             title = "SPS tabs",
             description = "Browse SPS functionalities as tabs from the left",
             position = "right-center")$
        ...
))
```
There are two parts that you need to define: UI and actual guide content. 

### UI
UI is what users see inside the dropdown menu. Guides UI needs to be stored in a 
`list` and each item should be a `shinydashboardPlus::messageItem`. 

- `inputId` must be unique.
- `from` is the short description of the guide.
- `icon` should be a call of `shiny::icon()`, the icon of the guide in dropdown menu
- `message`: short description of the guide in dropdown menu

To add multiple guides' UI, for example:

```r
guide_ui <- list(
    ## An example is provided below
    shinydashboardPlus::messageItem(
        inputId = "guide1",
        ...
    ),
    shinydashboardPlus::messageItem(
        inputId = "guide2",
        ...
    ),
    ...
)
```


### Guide content
The guide content is defined with the {[cicerone{blk}](https://github.com/JohnCoene/cicerone)}
package with `cicerone::Cicerone` R6 class and also in a **named** list. 

The name of each item in a list must match the name of `inputId` in guide UI. 
For example, we have two guides

```r
guide_ui <- list(
    ## An example is provided below
    shinydashboardPlus::messageItem(
        inputId = "guide1",
        ...
    ),
    shinydashboardPlus::messageItem(
        inputId = "guide2",
        ...
    ),
    ...
)

guide_content <- try(list(
    guide1 = cicerone::Cicerone$new(overlay_click_next = TRUE)$
        ...,
    guide2 = cicerone::Cicerone$new(overlay_click_next = TRUE)$
        ...
))
```

The "guide1" of `inputId` in the `guide_ui` must match "guide1" in `guide_content` list.

The "guide2" of `inputId` in the `guide_ui` must match "guide2" in `guide_content` list.

#### Define guide content
How to define the guide content will not be expanded here, read details in the {[cicerone{blk}](https://github.com/JohnCoene/cicerone)} package manual. 
Here are some key points:
- The `cicerone::Cicerone` is R6 class, and it is obejct oriented, so 
  you need to use `cicerone::Cicerone$new()` method to create a new object before you 
  can add any guide step. 
- R6 methods calling can be chained together, like how to define steps:
  ```r
  guide_content <- try(list(
      guide1 = cicerone::Cicerone$new()$ # chain object creation with step defining
          step(...)$                     # chain step1 to step2
          step(...)$                     # step2 to step3
          step(...)$                     # step3 to step4
          step(...)                      # DO NOT use `$` for the last step
  ))
  ```

If you follow the manual of {cicerone} to define steps, the guide will look like this 
when users click it. 

<center>

![](../cicerone.gif)

<caption>Cicerone steps</caption>

</center>

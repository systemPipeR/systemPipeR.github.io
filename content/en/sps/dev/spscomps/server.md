---
title: "Server functions"
linkTitle: "Server functions"
type: docs
weight: 2
---


{spsComps} has some useful functions for exception catch, expression validation,
and more. Even though  we say they are Shiny server functions, but in fact most 
of them can be run without a Shiny server. We have designed the functions to detect 
whether there is a Shiny server, if not, they will work only in R console as well.

## load package


```r
library(spsComps)
```

```
## Loading required package: shiny
```

```r
library(magrittr)
```

## Server components

### `shinyCatch`

#### basic

The `shinyCatch` function is useful to capture exception. What we mean exception 
can be `message`, `warning` or `error`. For example

```r
shinyCatch({
  message("This is a message")
  warning("This is a warning")
  stop("This is an error")
})
```

```
## [SPS-INFO] 2021-12-15 01:36:28 This is a message
## 
## [SPS-WARNING] 2021-12-15 01:36:28 This is a warning
## [SPS-ERROR] 2021-12-15 01:36:28 This is an error
```

```
## NULL
```

You can see all 3 levels are captured inside the [SPS-XX] log on your console. If you run this 
in your Shiny app, a pop-up message with the corresponding log level message will 
be displayed in in app, like following:

![shinycatch](../shinycatch.png)

So the message on both UI and console is called **dual-end logging** in SPS. 

#### Shiny off
Of course, if you do not want users to see the message, you can hide it by 
`shiny = FALSE`, but the message will be still logged on R console. 
Run the following on your own computer and watch the difference. 


```r
library(shiny)

ui <- fluidPage(
  spsDepend("toastr")
)

server <- function(input, output, session) {
  shinyCatch({
    stop("This is an error")
  }, shiny = FALSE)
}

shinyApp(ui, server)
```

#### get return
`shinyCatch` is able to return you values if your expression has any. Imagine we 
have a function `addNum` that gives message, warning or error depeend on the input. 


```r
addNum <- function(num){
  if (num > 0) {message(num)}
  else if (num == 0) {warning("Num is 0")}
  else {stop("less than 0")}
  return(num + num)
}

value_a <- shinyCatch({
  addNum(1)
})
```

```
## [SPS-INFO] 2021-12-15 01:36:28 1
```

```r
value_a
```

```
## [1] 2
```

```r
value_b <- shinyCatch({
  addNum(0)
})
```

```
## [SPS-WARNING] 2021-12-15 01:36:28 Num is 0
```

```r
value_b
```

```
## [1] 0
```

```r
value_c <- shinyCatch({
  addNum(-1)
})
```

```
## [SPS-ERROR] 2021-12-15 01:36:28 less than 0
```

```r
value_c
```

```
## NULL
```

You can see at `message` and `warning` level, the expected value returned, and 
at `error` level, the return is `NULL`. So the following code `value_c` still runs 
and is not blocked by the `error` occurred in `shinyCatch`.

#### Blocking level

More often, if there is an error, we do want take the log in R console, inform the Shinyapp user 
and then stop the following code. In this case, we need to specify the `blocking_level`. So, 
default is `"none"`, do not block and return `NULL` if there is an error, and you can 
choose `"error"`, `"warning"` or `"message"`. 

- **error**: block downstream if the first `error` detected in `shinyCatch`
- **warning**: block downstream if the first `error` or `warning` detected in `shinyCatch`
- **message**: block downstream if the first `error`, `warning` or `message` detected in `shinyCatch`

You can see the stringency becomes tighter: message > warning > error

<b class="text-primary">Blocking code will generate error, in order to have the Rmd rendered, we wrap the expression in `try` </b>

```r
try({
  shinyCatch({
    stop("error level is the most commonly used level")
  }, blocking_level = "error")
  print("This will not be evaluated")
})
```

```
## [SPS-ERROR] 2021-12-15 01:36:28 error level is the most commonly used level
## Error : 
```

```r
try({
  shinyCatch({
    message("error level is the most commonly used level")
  }, blocking_level = "message")
  print("This will not be evaluated either")
})
```

```
## [SPS-INFO] 2021-12-15 01:36:28 error level is the most commonly used level
## 
## Error : 
```

You can see the following `print` in both cases are not got evaluated.

#### Block reative

The most useful case for `shinyCatch` is to use it in the [Shiny reactive](https://shiny.rstudio.com/tutorial/written-tutorial/lesson6/) 
context. Most errors in shiny::reactive,  shiny::observer, shiny::observeEvent,
or shiny::renderXXX series function will **crash** the app. With `shinyCatch`, it 
will not. It "dual-logs" the error and stop downstream code. 

<b class="text-primary">The following example use `shiny::reactiveConsole()` to mock a Shiny server session</b>


```r
shiny::reactiveConsole(TRUE)
y <- observe({
  stop("an error from a function")
  print("some other process")
})
```

```
## Warning: Error in <observer>: The value of x is 
##   38: stop
##   37: <observer> [#2]
##   35: contextFunc
##   34: env$runWith
##   27: ctx$run
##   26: run
##    7: flushCallback
##    6: FUN
##    5: lapply
##    4: ctx$executeFlushCallbacks
##    3: .getReactiveEnvironment()$flush
##    2: flushReact
##    1: <Anonymous>
```

It crashes the app. However, if you use `shinyCatch`


```r
shiny::reactiveConsole(TRUE)
y <- observe({
  shinyCatch({
    stop("an error from a function")
  }, blocking_level = "error")
  print("some other process")
})
```
```
## [SPS-ERROR] 2021-03-02 22:13:05 an error from a function
```

It only logs the error and prevent the downstream `print` to run. Now try following 
real Shiny apps and watch the difference:


```r
# with shinyCatch
library(shiny)
server <- function(input, output, session) {
  observe({
    shinyCatch({
      stop("an error from a function")
    }, blocking_level = "error")
    print("some other process")
  })
}
shinyApp(fluidPage(spsDepend("toastr")), server)
```



```r
# without shinyCatch
library(shiny)
server <- function(input, output, session) {
  observe({
    stop("an error from a function")
    print("some other process")
  })
}
shinyApp(fluidPage(spsDepend("toastr")), server)
```


### `spsValidate`

In data analysis, it is important we do some validations before the downstream 
process, like make a plot. It is epecially the case in Shiny apps. We cannot 
predict what the user inputs will be, like what kind of data they will use. 
Similar to `shinyCatch`, `spsValidate` is able to catch exceptions but more 
useful to handle validations. In addtion to `shinyCatch` functionalities, it 
will give users a success message if the expression goes through and return `TRUE`
(`shinyCatch` returns the final expression value).


```r
shiny::reactiveConsole(TRUE)
x <- reactiveVal(10)

y <- observe({
  spsValidate({
    # have multiple validations in one expression
    if (x() == 1) stop("cannot be 1")
    if (x() == 0) stop("cannot be 0")
    if (x() < 0) stop("less than 0")
  })
  message("The value of x is ", x())
})
x(0)
x(-10)
```
```
## The value of x is 10
## [ ERROR] 2021-03-02 22:36:16 cannot be 0
## [ ERROR] 2021-03-02 22:36:16 less than 0
```

Try this real Shiny app:


```r
library(shiny)
ui <- fluidPage(
  spsDepend("toastr"),
  shiny::sliderInput(
    "num", "change number", 
    min = -1, max = 2, value = 2, step = 1
  )
)
server <- function(input, output, session) {
  x <- reactive(as.numeric(input$num))
  
  y <- observe({
    spsValidate(vd_name = "check numbers", verbose = TRUE, {
      # have multiple validations in one expression
      if (x() == 1) stop("cannot be 1")
      if (x() == 0) stop("cannot be 0")
      if (x() < 0) stop("less than 0")
    })
    message("The value of x is ", x())
  })
}
shinyApp(ui, server)
```

You should see the success message like this:

![spsvalidate](../spsvalidate.png)


### `shinyCheckPkg`

Sometimes we want the app behave differently if users have certain packages installed. 
For example, if some packages are installed, we open up additional tabs on 
UI to allow more features. This can be done with the `shinyCheckPkg` function. 
This function has to run inside Shiny server, an alternative version to use 
without Shiny is from the [spsUtil](../../spsutil) package, `spsUtil::checkNameSpace`

Use it in Shiny server, specify the packages you want to check by different sources, 
like CRAN, Bioconductor, or github. 


```r
shinyCheckPkg(session, cran_pkg = c("pkg1", "pkg2"), bioc_pkg = "bioxxx", github = "user1/pkg1")
```

It will return `TRUE` if all packages are installed, otherwise `FALSE`

Now try this real example. We check if the `ggplot99` package is installed, if 
yes we make a plot. It also combines the `spsValidate` function. You can have 
a better idea how these functions work. 


```r
library(shiny)

ui <- fluidPage(
  tags$label('Check if package "pkg1", "pkg2", "bioxxx",
github package "user1/pkg1" are installed'), br(),
  actionButton("check_random_pkg", "check random_pkg"),
  br(), spsHr(),
  tags$label('We can combine `spsValidate` to block server code to prevent
crash if some packages are not installed.'), br(),
  tags$label('If "shiny" is installed, make a plot.'), br(),
  actionButton("check_shiny", "check shiny"), br(),
  tags$label('If "ggplot99" is installed, make a plot.'), br(),
  actionButton("check_gg99", "check ggplot99"), br(),
  plotOutput("plot_pkg")
)

server <- function(input, output, session) {
  observeEvent(input$check_random_pkg, {
    shinyCheckPkg(session, cran_pkg = c("pkg1", "pkg2"), bioc_pkg = "bioxxx", github = "user1/pkg1")
  })
  observeEvent(input$check_shiny, {
    spsValidate(verbose = FALSE, {
      if(!shinyCheckPkg(session, cran_pkg = c("shiny"))) stop("Install packages")
    })
    output$plot_pkg <- renderPlot(plot(1))
  })
  observeEvent(input$check_gg99, {
    spsValidate({
      if(!shinyCheckPkg(session, cran_pkg = c("ggplot99"))) stop("Install packages")
    })
    output$plot_pkg <- renderPlot(plot(99))
  })
}

shinyApp(ui, server)
```

You should see something like this if there is any missing package:

![shinycheckpkg](../shinycheckpkg.png)


### In-line  operation

In-place operations like i += 1, i -= 1 is not support in R. These functions implement these operations in R. This set of functions will apply this kind of operations on [`shiny::reactiveVal`] objects.



```r
reactiveConsole(TRUE)
rv <- reactiveVal(0)
incRv(rv) # add 1
rv()
```

```
## [1] 1
```

```r
incRv(rv) # add 1
rv()
```

```
## [1] 2
```

```r
incRv(rv, -1) # minus 1
rv()
```

```
## [1] 1
```

```r
incRv(rv, -1) # minus 1
rv()
```

```
## [1] 0
```

```r
rv2 <- reactiveVal(1)
multRv(rv2) # times 2
rv2()
```

```
## [1] 2
```

```r
multRv(rv2) # times 2
rv2()
```

```
## [1] 4
```

```r
diviRv(rv2) # divide 2
rv2()
```

```
## [1] 2
```

```r
diviRv(rv2) # divide 2
rv2()
```

```
## [1] 1
```

```r
reactiveConsole(FALSE)
```

If you are looking for inline operations on normal R objects or 
`shiny::reactiveValues`, check [spsUtil](../../spsutil)

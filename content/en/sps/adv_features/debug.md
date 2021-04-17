---
title: "Debugging"
linkTitle: "Debugging"
type: docs
weight: 11
---
*****

There are some options in SPS that will give you more information and help you on 
debugging. They are: `verbose` and `traceback`. You can [config](../config) 
(enable/disable) themin a SPS project's `global.R` file, or use 
`spsOption("verbose", TRUE)` and `spsOption("traceback", TRUE)` to turn on them.

Some setup:

```r
suppressPackageStartupMessages(library(systemPipeShiny))
app_dir <- tempdir()
spsInit(app_path = app_dir, overwrite = TRUE, change_wd = FALSE, open_files = FALSE)
## [SPS-INFO] 2021-04-16 17:46:53 Start to create a new SPS project
## [SPS-INFO] 2021-04-16 17:46:53 Create project under /tmp/RtmpUfKCYR/SPS_20210416
## [SPS-INFO] 2021-04-16 17:46:53 Now copy files
## [SPS-INFO] 2021-04-16 17:46:53 Create SPS database
## [SPS-INFO] 2021-04-16 17:46:53 Created SPS database method container
## [SPS-INFO] 2021-04-16 17:46:53 Creating SPS db...
## [SPS-DANGER] 2021-04-16 17:46:53 Done, Db created at '/tmp/RtmpUfKCYR/SPS_20210416/config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-16 17:46:53 Key md5 fc8c85a0e87073328864bd542d740801
## [SPS-INFO] 2021-04-16 17:46:53 SPS project setup done!
app_path <- file.path(app_dir, glue::glue("SPS_{format(Sys.time(), '%Y%m%d')}"))
```

## `verbose`
In many SPS functions, there is this argument `verbose` and usually default is `FALSE`.
It means do not print extra message, keep it clean. You can set in `spsOption("verbose", TRUE)`
or inside `global.R` file to turn on. These are called global settings, and you 
can use a local setting to overwrite it (`func(..., verbose = TRUE)`). 

Let's use SPS main function `sps` for example, without the verbose 



```r
spsOption("verbose", FALSE)
app <- sps(app_path = app_path)
## Warning: 
[SPS-WARNING] 2021-04-16 17:46:53 These plot tabs has no image path:
## 'vs_example'
## It is recommended to add an image. It will be used to generate gallery. Now an empty image is used for these tabs' gallery.
## [SPS-INFO] 2021-04-16 17:46:55 App starts ...
```

Turn on the verbose:

```r
spsOption("verbose", TRUE)
app <- sps(app_path = app_path)
## [SPS-INFO] 2021-04-16 17:46:55 App has 19 default configs, resolving 19 custom configs
## [SPS-INFO] 2021-04-16 17:46:55 Now check the tab info in tabs.csv
## Warning: 
[SPS-WARNING] 2021-04-16 17:46:55 These plot tabs has no image path:
## 'vs_example'
## It is recommended to add an image. It will be used to generate gallery. Now an empty image is used for these tabs' gallery.
## [SPS-INFO] 2021-04-16 17:46:55 tab.csv info check pass
## [SPS-INFO] 2021-04-16 17:46:55 Using default tabs
## [SPS-INFO] 2021-04-16 17:46:55 check guide
## [SPS-INFO] 2021-04-16 17:46:55 Start to generate UI
## [SPS-INFO] 2021-04-16 17:46:55 parse title and logo
## [SPS-INFO] 2021-04-16 17:46:55 resolve default tabs UI
## [SPS-INFO] 2021-04-16 17:46:55 Loading custom tab UI ...
## [SPS-INFO] 2021-04-16 17:46:55 Loading notifications from developer...
## [SPS-INFO] 2021-04-16 17:46:55 Loading guide UI
## [SPS-INFO] 2021-04-16 17:46:55 Create UI header ...
## [SPS-INFO] 2021-04-16 17:46:55 Create UI sidebar menu ...
## [SPS-INFO] 2021-04-16 17:46:55 Create UI tab content ...
## [SPS-INFO] 2021-04-16 17:46:55 Add tab content to body ...
## [SPS-INFO] 2021-04-16 17:46:55 Merge header, menu, body to dashboard ...
## [SPS-INFO] 2021-04-16 17:46:55 Add overlay loading screen, admin panel.
##             Merge everything to app container ...
## [SPS-INFO] 2021-04-16 17:46:55 UI created
## [SPS-INFO] 2021-04-16 17:46:55 Start to create server function
## [SPS-INFO] 2021-04-16 17:46:55 Resolve default tabs server
## [SPS-INFO] 2021-04-16 17:46:55 Load custom tabs servers
## [SPS-INFO] 2021-04-16 17:46:55 Server functions created
## [SPS-INFO] 2021-04-16 17:46:55 App starts ...
```


### Exception
There is one exception which is the `spsInit`. It is used to create a SPS project 
for you, so it assumes you do not have a SPS project yet and therefore do not have 
the chance to reach SPS options. So the `verbose` global setting will not work here. 
You need to turn it on locally with `verbose = TRUE`. 

Compare messages of this with the initial `spsInit` creation on top.

```r
spsInit(verbose = TRUE, app_path = app_path, overwrite = TRUE, change_wd = FALSE, open_files = FALSE)
## [SPS-INFO] 2021-04-16 17:46:55 Start to create a new SPS project
## [SPS-INFO] 2021-04-16 17:46:55 Create project under /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416
## [SPS-INFO] 2021-04-16 17:46:55 Now copy files
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/www
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/config
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/R
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/data
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/results
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/README.md
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/deploy.R
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/server.R
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/global.R
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/ui.R
## [SPS-INFO] 2021-04-16 17:46:55 File(s) copied for /tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/server.R
## [SPS-INFO] 2021-04-16 17:46:55 Create SPS database
## [SPS-INFO] 2021-04-16 17:46:55 Created SPS database method container
## [SPS-INFO] 2021-04-16 17:46:55 Db connected
## [SPS-INFO] 2021-04-16 17:46:55 Default SPS-db found and is working
## [SPS-INFO] 2021-04-16 17:46:55 Db connected
## [SPS-INFO] 2021-04-16 17:46:55 Creating SPS db...
## [SPS-INFO] 2021-04-16 17:46:55 Db write the meta table
## [SPS-INFO] 2021-04-16 17:46:56 Db write the raw table
## [SPS-INFO] 2021-04-16 17:46:56 Key generated and stored in db
## [SPS-INFO] 2021-04-16 17:46:56 Db create admin account
## [SPS-DANGER] 2021-04-16 17:46:56 Done, Db created at '/tmp/RtmpUfKCYR/SPS_20210416/SPS_20210416/config/sps.db'. DO NOT share this file with others or upload to open access domains.
## [SPS-INFO] 2021-04-16 17:46:56 Key md5 7dca8a45de4d7260f91ddb1a02d0a6bd
## [SPS-INFO] 2021-04-16 17:46:56 SPS project setup done!
```


## `traceback`
When error happens, it will be helpful if we can know where it happened. This option 
will give you additional information of which function it happened, the system call 
list and error file and line of code if possible. 

This feature is enabled in two functions `sps` and `shinyCatch`. 
- `sps`: Adding tracebacks if there are some errors sourcing helper functions located
  in your SPS project under the `R` folder.  
- `shinyCatch`: Traceback errors of expressions inside `shinyCatch`

Let's use `shinyCatch` to demo.

Before adding traceback:

```r
spsOption("traceback", FALSE)
shinyCatch({
  stop("some error message")
})
```

```
## [SPS-ERROR] 2021-04-16 17:46:56 some error message
```

```
## NULL
```

After

```r
spsOption("traceback", TRUE)
shinyCatch({
  stop("some error message")
})
```

```
## 1. local({
##     if (length(a <- commandArgs(TRUE)) != 2) 
##         stop("The number of arguments passed to Rscript should be 2.")
##     x = readRDS(a[1])
##     f = x[[1]]
##     if (is.character(f)) 
##         f = eval(parse(text = f), envir = globalenv())
##     r = do.call(f, x[[2]], envir = globalenv())
##     saveRDS(r, a[2])
## }) 
## 2. eval.parent(substitute(eval(quote(expr), envir))) 
## 3. eval(expr, p) 
## 4. eval(expr, p) 
## 5. eval(quote({
##     if (length(a <- commandArgs(TRUE)) != 2) stop("The number of arguments passed to Rscript should be 2.")
##     x = readRDS(a[1])
##     f = x[[1]]
##     if (is.character(f)) f = eval(parse(text = f), envir = globalenv())
##     r = do.call(f, x[[2]], envir = globalenv())
##     saveRDS(r, a[2])
## }), new.env()) 
## 6. eval(quote({
##     if (length(a <- commandArgs(TRUE)) != 2) stop("The number of arguments passed to Rscript should be 2.")
##     x = readRDS(a[1])
##     f = x[[1]]
##     if (is.character(f)) f = eval(parse(text = f), envir = globalenv())
##     r = do.call(f, x[[2]], envir = globalenv())
##     saveRDS(r, a[2])
## }), new.env()) 
## 7. do.call(f, x[[2]], envir = globalenv()) 
## 8. (function (input, output, to_md = file_ext(output) != "html", quiet = TRUE) 
## {
##     options(htmltools.dir.version = FALSE)
##     setwd(dirname(input))
##     input = basename(input)
##     if (to_md) 
##         options(bookdown.output.markdown = TRUE)
##     res = rmarkdown::render(input, "blogdown::html_page", output_file = output, envir = globalenv(), quiet = quiet, run_pandoc = !to_md, clean = !to_md)
##     x = read_utf8(res)
##     if (to_md) 
##         x = process_markdown(res, x)
##     unlink(res)
##     x
## })("content/en/sps/adv_features/debug.Rmd", "debug.md~", TRUE, TRUE) 
## 9. rmarkdown::render(input, "blogdown::html_page", output_file = output, envir = globalenv(), quiet = quiet, run_pandoc = !to_md, clean = !to_md) 
## 10. knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet) 
## 11. process_file(text, output) 
## 12. withCallingHandlers(if (tangle) process_tangle(group) else process_group(group), error = function(e) {
##     setwd(wd)
##     cat(res, sep = "\n", file = output %n% "")
##     message("Quitting from lines ", paste(current_lines(i), collapse = "-"), " (", knit_concord$get("infile"), ") ")
## }) 
## 13. process_group(group) 
## 14. process_group.block(group) 
## 15. call_block(x) 
## 16. block_exec(params) 
## 17. in_dir(input_dir(), evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALSE(options$warning), keep_message = !isFALSE(options$message), stop_on_error = if (options$error && options$include) 0 else 2, output_handler = knit_handlers(options$render, options))) 
## 18. evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALSE(options$warning), keep_message = !isFALSE(options$message), stop_on_error = if (options$error && options$include) 0 else 2, output_handler = knit_handlers(options$render, options)) 
## 19. evaluate::evaluate(...) 
## 20. evaluate_call(expr, parsed$src[[i]], envir = envir, enclos = enclos, debug = debug, last = i == length(out), use_try = stop_on_error != 2, keep_warning = keep_warning, keep_message = keep_message, output_handler = output_handler, include_timing = include_timing) 
## 21. timing_fn(handle(ev <- withCallingHandlers(withVisible(eval(expr, envir, enclos)), warning = wHandler, error = eHandler, message = mHandler))) 
## 22. handle(ev <- withCallingHandlers(withVisible(eval(expr, envir, enclos)), warning = wHandler, error = eHandler, message = mHandler)) 
## 23. withCallingHandlers(withVisible(eval(expr, envir, enclos)), warning = wHandler, error = eHandler, message = mHandler) 
## 24. withVisible(eval(expr, envir, enclos)) 
## 25. eval(expr, envir, enclos) 
## 26. eval(expr, envir, enclos) 
## 27. shinyCatch({
##     stop("some error message")
## }) 
## 28. tryCatch(suppressMessages(suppressWarnings(withCallingHandlers(expr, message = function(m) toastr_actions$message(m), warning = function(m) toastr_actions$warning(m), error = function(m) if (trace_back) printTraceback(sys.calls())))), error = function(m) {
##     toastr_actions$error(m)
##     return(NULL)
## }) 
## 29. tryCatchList(expr, classes, parentenv, handlers) 
## 30. tryCatchOne(expr, names, parentenv, handlers[[1]]) 
## 31. doTryCatch(return(expr), name, parentenv, handler) 
## 32. suppressMessages(suppressWarnings(withCallingHandlers(expr, message = function(m) toastr_actions$message(m), warning = function(m) toastr_actions$warning(m), error = function(m) if (trace_back) printTraceback(sys.calls())))) 
## 33. withCallingHandlers(expr, message = function(c) if (inherits(c, classes)) tryInvokeRestart("muffleMessage")) 
## 34. suppressWarnings(withCallingHandlers(expr, message = function(m) toastr_actions$message(m), warning = function(m) toastr_actions$warning(m), error = function(m) if (trace_back) printTraceback(sys.calls()))) 
## 35. withCallingHandlers(expr, warning = function(w) if (inherits(w, classes)) tryInvokeRestart("muffleWarning")) 
## 36. withCallingHandlers(expr, message = function(m) toastr_actions$message(m), warning = function(m) toastr_actions$warning(m), error = function(m) if (trace_back) printTraceback(sys.calls())) 
## [SPS-ERROR] 2021-04-16 17:46:56 some error message
```

```
## NULL
```

Or use local setting to overwrite the global, even we have `spsOption("traceback", TRUE)`,
but traceback is still muted by ` trace_back = FALSE`.

```r
spsOption("traceback", TRUE)
shinyCatch({
  stop("some error message")
}, trace_back = FALSE)
```

```
## [SPS-ERROR] 2021-04-16 17:46:56 some error message
```

```
## NULL
```

### Traceback with file and line number
Let's write an R file with functions, source it and then call the function from 
this file. Try it on your own computer:

```r
temp_file <- tempfile(fileext = ".R")
writeLines(
  "myFunc <- function(){
      myFunc2()
  }
  myFunc2 <- function(){
      stop('some error message')
  }
  ",
  temp_file
)
source(temp_file)

shinyCatch({
  myFunc()
})
```

![](../shinycatch_traceback.png)

You can see the error happened in `myFunc` line No. 2 and then inside this function 
it calls another function `myFunc2` which caused the final error. In `myFunc2` 
it is also the line No. 2 caused the issue and error is coming from `/tmp/...` file.

## other Shiny built-in options
There are some Shiny options can also be helpful on debugging:


```r
# developer mode, use ?devmode to see details 
devmode(TRUE)
# inspect reactivity in shiny
options(shiny.reactlog = TRUE)
# similar to SPS's traceback but on the whole app level 
options(shiny.fullstacktrace = TRUE)
# open the `browser` debug mode on error
options(shiny.error = browser)
# when a shiny app file saves, reload the app, not working with modular apps like SPS at this moment
options(shiny.autoreload = TRUE)
```

See [Shiny option website{blk}](https://shiny.rstudio.com/reference/shiny/0.14/shiny-options.html)
for more details 




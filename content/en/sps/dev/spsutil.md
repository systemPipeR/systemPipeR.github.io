---
title: "spsUtil"
linkTitle: "spsUtil"
type: docs
weight: 3
---
*****

SPS framework come with a plenty of useful general R utility functions, like 
pretty logging, package namespace checking, URL checking, and more.

Since SPS 1.1, these functions are separated into a supporting package called 
**spsUtil** (systemPipeShiny Utility). You can install it from CRAN.



## Installation 

Read the [developer tools](..) main page, not repeating here. 

## Functions reference manual
In documents, we only highlight some important functions. Please read 
the [reference manuals](/sps/sps_funcs) for details of every function. 


## Function highlights

```r
library(spsUtil)
```

### logging with `msg`

#### basic
Often times in an R function, we want to use some text to inform users the 
status and message. We can use functions like `message`, `warning`, `stop` to generate different 
levels of information. 

{spsUtil} provides some more informative and prettier ways to generate these kind of messages.


```r
msg("my message")
```

```
## [INFO] 2021-04-12 11:49:35 my message
```
You can see it starts with a `level` information, then a time stamp, and follows the 
actual message. By default, it uses the `INFO` level, and you can change to whatever
level you want. However, there are 3 keywords that have special meaning.

#### Levels

- **INFO**: equals `message` method in native R
- **WARNING**: generates warnings the same as `warning` function
- **ERROR**: generates error the same as `stop` function and will prevent downstream 
  code get evaluated. 
  
If the level is other than these 3, there is no special meaning in R, just `cat`
the message out. 


```r
msg("I am info", level = "INFO")
```

```
## [INFO] 2021-04-12 11:49:35 I am info
```

```r
msg("I am warning", level = "warning") # not case sensitive
```

```
## Warning: [WARNING] 2021-04-12 11:49:35 I am warning
```

```r
msg("I am error", level = "ERROR")
```

```
## Error: 
[ERROR] 2021-04-12 11:49:35 I am error
```

```r
msg("I am random level", level = "MY LEVEL")
```

```
## [MY LEVEL] 2021-04-12 11:49:35 I am random level
```

#### Prefix
For the 3 key levels, you can specify the prefix in front of the level text to 
over write the default level text `INFO`, `WARNING`, or `ERROR`

```r
msg("I am info", level = "INFO", info_text = "NEW-INFO")
```

```
## [NEW-INFO] 2021-04-12 11:49:35 I am info
```

```r
msg("I am warning", level = "warning", warning_text = "MY-WARNING")
```

```
## Warning: [MY-WARNING] 2021-04-12 11:49:35 I am warning
```

```r
msg("I am error", level = "ERROR", error_text = "STOP")
```

```
## Error: 
[STOP] 2021-04-12 11:49:35 I am error
```

#### Colors
Colors are automatically enabled if it is supported. If you try all code above in 
your terminal or Rstudio, they all have colors. In Rmd, to enable the color, 
you need to add the following code chunk. You also need to install the `fansi` package.
````
```{r echo=FALSE, results='asis'} 
options(crayon.enabled = TRUE)
old_hooks <- fansi::set_knit_hooks(knitr::knit_hooks, which = c("output", "message", "error", "warning"))
```
````


<STYLE type='text/css' scoped>
PRE.fansi SPAN {padding-top: .25em; padding-bottom: .25em};
</STYLE>


```r
msg("I am info", level = "INFO", info_text = "NEW-INFO")
```

<PRE class="fansi fansi-message"><CODE>## <span style='color: #0000BB;font-weight: bold;'>[NEW-INFO] 2021-04-12 11:49:35 I am info</span><span>
</span></CODE></PRE>

The 3 key levels has default colors:

- **INFO**: <span style="color:blue">blue</span>
- **WARNING**: <span style="color:orange">orange</span>
- **ERROR**: <span style="color:red">red</span>

You can specify colors for your own levels 

```r
msg("I am warning", level = "warning") ## not super orange in Rmd translation -_-=
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[WARNING] 2021-04-12 11:49:35 I am warning</span><span>
</span></CODE></PRE>

```r
msg("I am error", level = "error")
```

<PRE class="fansi fansi-error"><CODE>## Error: 
<span style='color: #BB0000;font-weight: bold;'>[ERROR] 2021-04-12 11:49:35 I am error</span><span>
</span></CODE></PRE>

```r
msg("oh yeah", level = "SUCCESS", .other_color = "green")
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #00BB00;font-weight: bold;'>[SUCCESS] 2021-04-12 11:49:35 oh yeah</span><span>
</span></CODE></PRE>

```r
msg("oh no", level = "FAIL", .other_color = "purple")
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #BB00BB;font-weight: bold;'>[FAIL] 2021-04-12 11:49:35 oh no</span><span>
</span></CODE></PRE>

#### Wrapper
You can use this logging function in your own projects by wrapping it inside a 
upper level function, like what we do for `spsinfo`, `spswarn`, `spserror`. They 
have `SPS-` prefix added, and have some SPS global settings appended.


```r
spsOption('use_crayon', TRUE)
spsinfo("info", verbose = TRUE) ## default `verbose` mute the message
```

<PRE class="fansi fansi-message"><CODE>## <span style='color: #0000BB;font-weight: bold;'>[SPS-INFO] 2021-04-12 11:49:35 info</span><span>
</span></CODE></PRE>

```r
spswarn("warning")
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[SPS-WARNING] 2021-04-12 11:49:35 warning</span><span>
</span></CODE></PRE>

```r
spserror("stop")
```

<PRE class="fansi fansi-error"><CODE>## Error: 
<span style='color: #BB0000;font-weight: bold;'>[SPS-ERROR] 2021-04-12 11:49:35 stop</span><span>
</span></CODE></PRE>

To create a simple one for project is very easy. Assume your project is named "My Project".
You can create logging as:


```r
mpInfo <- function(text){
  spsUtil::msg(text, info_text = "MP-INFO")
}
mpWarn <- function(text){
  spsUtil::msg(text, level = "warning", warning_text  = "MP-WARNING")
}
mpErr <- function(text){
  spsUtil::msg(text, level = "error", error_text = "MP-ERROR")
}
mpInfo("info")
```

<PRE class="fansi fansi-message"><CODE>## <span style='color: #0000BB;font-weight: bold;'>[MP-INFO] 2021-04-12 11:49:35 info</span><span>
</span></CODE></PRE>

```r
mpWarn("warning")
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[MP-WARNING] 2021-04-12 11:49:35 warning</span><span>
</span></CODE></PRE>

```r
mpErr("error")
```

<PRE class="fansi fansi-error"><CODE>## Error: 
<span style='color: #BB0000;font-weight: bold;'>[MP-ERROR] 2021-04-12 11:49:35 error</span><span>
</span></CODE></PRE>


## mute message with `quiet`
In R, you can easily mute message and warnings with `suppressMessages()`, and 
`suppressWarnings()`, but not so easy with `print` or `cat` methods. `spsUtil::quiet`
enables you to mute all these methods or choose what to mute.


```r
{
# muted
quiet(warning(123))
quiet(message(123))
quiet(print(123))
quiet(cat(123))
# not muted
quiet(warning(123), warning = FALSE)
quiet(message(123), message = FALSE)
quiet(print(123), print_cat = FALSE)
quiet(cat(123), print_cat = FALSE)
}
## Warning in force(x): 123
## 123
## [1] 123
## 123
```

## check "empty" values with `emptyIsFalse`
In R, values like `NA`, `""`, `NULL`, length(0) is not very meaningful in 
condition judgment and will give you errors. Yet, R does not have a native 
method to handle these "empty" values in `if` like other languages. They are 
meaningful in other ways, but in conditions, we may want to turn them to `FALSE`.


```r
if("") TRUE else FALSE
## Error in if ("") TRUE else FALSE: argument is not interpretable as logical
if(NULL) TRUE else FALSE
## Error in if (NULL) TRUE else FALSE: argument is of length zero
if(character(0)) TRUE else FALSE
## Error in if (character(0)) TRUE else FALSE: argument is of length zero
if(NA) TRUE else FALSE
## Error in if (NA) TRUE else FALSE: missing value where TRUE/FALSE needed
```

You can see they all give errors. In other languages (javascript in this example), 
these values are often treated as `FALSE`. 


```js
if (NaN) true; else false
//> false
if (undefined) true; else false
//> false
if ("") true; else false
//> false
if (null) true; else false
//> false
```


<script type="text/javascript">
if (NaN) true; else false
//> false
if (undefined) true; else false
//> false
if ("") true; else false
//> false
if (null) true; else false
//> false
</script>

This is how `emptyIsFalse`
work. If the input is one of these values, return `FALSE`, else `TRUE`


```r
if(emptyIsFalse("")) TRUE else FALSE
## [1] FALSE
if(emptyIsFalse(NULL)) TRUE else FALSE
## [1] FALSE
if(emptyIsFalse(character(0))) TRUE else FALSE
## [1] FALSE
if(emptyIsFalse(NA)) TRUE else FALSE
## [1] FALSE
```


## check missing packages `checkNameSpace`
In our functions, sometimes we want to have the users to install certain packages
to enable more functionalities, like the `DESeq2::lfcShrink` function. Or like 
in a Rmd source code, before other people can rerender the document, they must 
install certain packages. `checkNameSpace` checks all required packages and returns
the missing names. 


```r
checkNameSpace("random_pkg")
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[WARNING] 2021-04-12 11:49:35 These packages are missing from
## CRAN: random_pkg</span><span>
</span></CODE></PRE>

```
## [1] "random_pkg"
```

You can add it to your function to or on the top of your Rmd document to inform 
your users the missing packages and where to install.


```r
pkgs <- list(
  CRAN = c("pkg1", "pkg2"),
  Bioconductor = c("bio_pkg1", "bio_pkg2")
)

missing_pkg <- checkNameSpace(pkgs[[1]], from =  names(pkgs)[1])
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[WARNING] 2021-04-12 11:49:35 These packages are missing from
## CRAN: pkg1,pkg2</span><span>
</span></CODE></PRE>

```r
missing_pkg <- c(missing_pkg, checkNameSpace(pkgs[[2]], from =  names(pkgs)[2]))
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[WARNING] 2021-04-12 11:49:35 These packages are missing from
## Bioconductor: bio_pkg1,bio_pkg2</span><span>
</span></CODE></PRE>

```r
if(emptyIsFalse(missing_pkg)) stop("Install packages")
```

```
## Error in eval(expr, envir, enclos): Install packages
```

Or write your custom warning message:

```r
{
missing_pkg <- mapply(function(pkg, from) {
  checkNameSpace(pkg, quietly = TRUE, from)
}, pkg = pkgs, from = names(pkgs), SIMPLIFY = FALSE)


cat(
  "Use `install.packages(c('", 
  paste0(missing_pkg[['CRAN']], collapse = "','"), 
  "'))` to install CRAN packages\n", 
  sep = ""
)
cat(
  "Use `BiocManager::install(c('", 
  paste0(missing_pkg[['Bioconductor']], collapse = "','"), 
  "'))` to install Bioconductor packages\n", 
  sep = ""
)
if(emptyIsFalse(unlist(missing_pkg))) stop("Install packages")
}
```

```
## Use `install.packages(c('pkg1','pkg2'))` to install CRAN packages
## Use `BiocManager::install(c('bio_pkg1','bio_pkg2'))` to install Bioconductor packages
```

```
## Error in eval(expr, envir, enclos): Install packages
```

## check a URL is reachable with `checkUrl`
Useful if you need make some big HTTP requests. 


```r
checkUrl("https://google.com")
```

```
## [1] TRUE
```

```r
checkUrl("https://randomwebsite123.com", timeout = 1)
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[WARNING] 2021-04-12 11:49:37 Bad url https://
## randomwebsite123.com</span><span>
</span></CODE></PRE><PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00;font-weight: bold;'>[WARNING] 2021-04-12 11:49:37 Timeout was reached:
## [randomwebsite123.com] Connection timed out after 1001 milliseconds</span><span>
</span></CODE></PRE>

```
## [1] FALSE
```




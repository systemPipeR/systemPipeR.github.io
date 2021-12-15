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
## [INFO] 2021-12-15 01:57:33 my message
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
## [INFO] 2021-12-15 01:57:33 I am info
```

```r
msg("I am warning", level = "warning") # not case sensitive
```

```
## Warning: [WARNING] 2021-12-15 01:57:33 I am warning
```

```r
msg("I am error", level = "ERROR")
```

```
## Error: 
[ERROR] 2021-12-15 01:57:33 I am error
```

```r
msg("I am random level", level = "MY LEVEL")
```

```
## [MY LEVEL] 2021-12-15 01:57:33 I am random level
```

#### Prefix
For the 3 key levels, you can specify the prefix in front of the level text to 
over write the default level text `INFO`, `WARNING`, or `ERROR`

```r
msg("I am info", level = "INFO", info_text = "NEW-INFO")
```

```
## [NEW-INFO] 2021-12-15 01:57:33 I am info
```

```r
msg("I am warning", level = "warning", warning_text = "MY-WARNING")
```

```
## Warning: [MY-WARNING] 2021-12-15 01:57:33 I am warning
```

```r
msg("I am error", level = "ERROR", error_text = "STOP")
```

```
## Error: 
[STOP] 2021-12-15 01:57:33 I am error
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

<PRE class="fansi fansi-message"><CODE>## <span style='color: #0000BB; font-weight: bold;'>[NEW-INFO] 2021-12-15 01:57:33 I am info</span>
</CODE></PRE>

The 3 key levels has default colors:

- **INFO**: <span style="color:blue">blue</span>
- **WARNING**: <span style="color:orange">orange</span>
- **ERROR**: <span style="color:red">red</span>

You can specify colors for your own levels 

```r
msg("I am warning", level = "warning") ## not super orange in Rmd translation -_-=
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[WARNING] 2021-12-15 01:57:33 I am warning</span>
</CODE></PRE>

```r
msg("I am error", level = "error")
```

<PRE class="fansi fansi-error"><CODE>## Error: 
<span style='color: #BB0000; font-weight: bold;'>[ERROR] 2021-12-15 01:57:33 I am error</span>
</CODE></PRE>

```r
msg("oh yeah", level = "SUCCESS", .other_color = "green")
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #00BB00; font-weight: bold;'>[SUCCESS] 2021-12-15 01:57:33 oh yeah</span>
</CODE></PRE>

```r
msg("oh no", level = "FAIL", .other_color = "purple")
```

<PRE class="fansi fansi-output"><CODE>## <span style='color: #BB00BB; font-weight: bold;'>[FAIL] 2021-12-15 01:57:33 oh no</span>
</CODE></PRE>

#### Wrapper
You can use this logging function in your own projects by wrapping it inside a 
upper level function, like what we do for `spsinfo`, `spswarn`, `spserror`. They 
have `SPS-` prefix added, and have some SPS global settings appended.


```r
spsOption('use_crayon', TRUE)
spsinfo("info", verbose = TRUE) ## default `verbose` mute the message
```

<PRE class="fansi fansi-message"><CODE>## <span style='color: #0000BB; font-weight: bold;'>[SPS-INFO] 2021-12-15 01:57:33 info</span>
</CODE></PRE>

```r
spswarn("warning")
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[SPS-WARNING] 2021-12-15 01:57:33 warning</span>
</CODE></PRE>

```r
spserror("stop")
```

<PRE class="fansi fansi-error"><CODE>## Error: 
<span style='color: #BB0000; font-weight: bold;'>[SPS-ERROR] 2021-12-15 01:57:33 stop</span>
</CODE></PRE>

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

<PRE class="fansi fansi-message"><CODE>## <span style='color: #0000BB; font-weight: bold;'>[MP-INFO] 2021-12-15 01:57:33 info</span>
</CODE></PRE>

```r
mpWarn("warning")
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[MP-WARNING] 2021-12-15 01:57:33 warning</span>
</CODE></PRE>

```r
mpErr("error")
```

<PRE class="fansi fansi-error"><CODE>## Error: 
<span style='color: #BB0000; font-weight: bold;'>[MP-ERROR] 2021-12-15 01:57:33 error</span>
</CODE></PRE>


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


## timeout 
Run expressions with a time limit, stop an expression if it takes too long


```r
# default
timeout({Sys.sleep(0.1)}, time_out = 0.01)
```

```
## Error: Timout reached
```

```r
# timeout is evaluating expressions the same level as you call it
timeout({abc <- 123})
# so you should get `abc` even outside the function call
abc
```

```
## [1] 123
```

```r
# custom timeout callback
timeout({Sys.sleep(0.1)}, time_out = 0.01, on_timeout = {print("It takes too long")})
```

```
## [1] "It takes too long"
```

```r
# final call back
timeout({Sys.sleep(0.1)}, time_out = 0.01, on_final = {print("some final words")}) # on error
```

```
## Error: Timout reached
```

```
## [1] "some final words"
```

```r
timeout({invisible()}, on_final = {print("runs even success")})  # no return by have final expression on success
```

```
## [1] "runs even success"
```

```r
# assign to value
my_val <- timeout({10 + 1})
my_val
```

```
## [1] 11
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

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[WARNING] 2021-12-15 01:57:34 These packages are missing from
## CRAN: random_pkg</span>
</CODE></PRE>

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

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[WARNING] 2021-12-15 01:57:34 These packages are missing from
## CRAN: pkg1,pkg2</span>
</CODE></PRE>

```r
missing_pkg <- c(missing_pkg, checkNameSpace(pkgs[[2]], from =  names(pkgs)[2]))
```

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[WARNING] 2021-12-15 01:57:34 These packages are missing from
## Bioconductor: bio_pkg1,bio_pkg2</span>
</CODE></PRE>

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


## Stack methods

### Simple stack
A simple stack data structure in R, with supporting of assiocated methods, like push, pop and others.


```r
my_stack <- simepleStack$new()
# check length
my_stack$len()
#> [1] 0
# add some thing
my_stack$push(list(1, 2, 3))
# print current stack
str(my_stack$get())
#> List of 3
#>  $ : num 1
#>  $ : num 2
#>  $ : num 3
# check length
my_stack$len()
#> [1] 3
# add before the current first
my_stack$push(list(0), after = 0)
# print current stack
str(my_stack$get())
#> List of 4
#>  $ : num 0
#>  $ : num 1
#>  $ : num 2
#>  $ : num 3
# pop one item
my_stack$pop()
#> [[1]]
#> [1] 0
#> 
# print current stack
str(my_stack$get())
#> List of 3
#>  $ : num 1
#>  $ : num 2
#>  $ : num 3
# pop one item from the tail
my_stack$pop(tail = TRUE)
#> [[1]]
#> [1] 3
#> 
# print current stack
str(my_stack$get())
#> List of 2
#>  $ : num 1
#>  $ : num 2
# pop more than one items
my_stack$pop(2)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 2
#> 
# print current stack
str(my_stack$get()) # nothing left
#>  list()
```

### History stack
Methods for a history stack data structure. It can store history of certain 
repeating actions. For example, building the back-end of a file/image editor, 
allow undo/redo actions.


```r
his <- historyStack$new()
#> Created a history stack which can record  25 steps
# add some history
his$add(1)
#> Added one item to position 1
his$add(2)
#> Added one item to position 2
his$add(3)
#> Added one item to position 3
his$add(4)
#> Added one item to position 4
his$add(5)
#> Added one item to position 5
# check status
his$status()
#> $pos
#> [1] 5
#> 
#> $len
#> [1] 5
#> 
#> $limit
#> [1] 25
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] TRUE
#> 
# get item at current history position
his$get()
#> $item
#> [1] 5
#> 
#> $pos
#> [1] 5
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] TRUE
#> 
# go back to previous step
his$backward()
#> $item
#> [1] 4
#> 
#> $pos
#> [1] 4
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] FALSE
#> 
# going back to step 2
his$backward()
#> $item
#> [1] 3
#> 
#> $pos
#> [1] 3
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] FALSE
#> 
his$backward()
#> $item
#> [1] 2
#> 
#> $pos
#> [1] 2
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] FALSE
#> 
# going forward 1 step tp step 3
his$forward()
#> $item
#> [1] 3
#> 
#> $pos
#> [1] 3
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] FALSE
#> 
# check current status
his$status()
#> $pos
#> [1] 3
#> 
#> $len
#> [1] 5
#> 
#> $limit
#> [1] 25
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] FALSE
#> 
# adding a new step at position 3 will remove the old step 4,5 before adding
his$add("new 4")
#> Added one item to position 4
# only 3 steps + 1 new step = 4 steps left
his$status()
#> $pos
#> [1] 4
#> 
#> $len
#> [1] 4
#> 
#> $limit
#> [1] 25
#> 
#> $first
#> [1] FALSE
#> 
#> $last
#> [1] TRUE
#> 
```


## In-line operation

In-place operations like `i += 1` with `inc(x)`, `i -= 1` with `inc(x, -1)`,
`i *= 2` with `mult(x)`, `i /= 2` with `divi(x)`


```r
i <- 0
inc(i) # add 1
i
```

```
## [1] 1
```

```r
inc(i) # add 1
i
```

```
## [1] 2
```

```r
inc(i, -1) # minus 1
i
```

```
## [1] 1
```

```r
inc(i, -1) # minus 1
i
```

```
## [1] 0
```

```r
x <- 1
mult(x) # times 2
x
```

```
## [1] 2
```

```r
mult(x) # times 2
x
```

```
## [1] 4
```

```r
divi(x) # divide 2
x
```

```
## [1] 2
```

```r
divi(x) # divide 2
x
```

```
## [1] 1
```


## Uniquefy duplicated strings with `strUniquefy`
Fix duplicated values in a character vector, useful in column names and some 
ID structures that requires unique identifiers. If any duplicated string is 
found in the vector, a numeric index will be added after the these strings.


```r
strUniquefy(c(1,1,1,2,3)) # default
```

```
## [1] "1_1" "1_2" "1_3" "2"   "3"
```

```r
strUniquefy(c(1,1,1,2,3), mark_first = FALSE) # don't mark the first one
```

```
## [1] "1"   "1_1" "1_2" "2"   "3"
```

```r
strUniquefy(c(1,1,1,2,3), sep_b = "(", sep_a = ")") # custom before, after symbols
```

```
## [1] "1(1)" "1(2)" "1(3)" "2"    "3"
```

```r
strUniquefy(c("a","b","c","a","d","b")) # works with letters too
```

```
## [1] "a_1" "b_1" "c"   "a_2" "d"   "b_2"
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

<PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[WARNING] 2021-12-15 01:57:35 Bad url https://
## randomwebsite123.com</span>
</CODE></PRE><PRE class="fansi fansi-warning"><CODE>## Warning: <span style='color: #BBBB00; font-weight: bold;'>[WARNING] 2021-12-15 01:57:35 Timeout was reached:
## [randomwebsite123.com] Connection timed out after 1001 milliseconds</span>
</CODE></PRE>

```
## [1] FALSE
```



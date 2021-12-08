---
title: "How to run a Workflow" 
author: "Author: Daniela Cassol (danielac@ucr.edu) and Thomas Girke (thomas.girke@ucr.edu)"
date: "Last update: 07 December, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeR
vignette: |
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{systemPipeR: Workflow design and reporting generation environment}
  %\VignetteEngine{knitr::rmarkdown}
fontsize: 14pt
bibliography: bibtex.bib
editor_options: 
  chunk_output_type: console
type: docs
weight: 3
---

<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<link href="/rmarkdown-libs/vizjs/plotwf.css" rel="stylesheet" />
<script src="/rmarkdown-libs/vizjs/viz.js"></script>
<script src="/rmarkdown-libs/vizjs/full.render.js"></script>
<script src="/rmarkdown-libs/dom_to_image/dom_to_image.js"></script>
<link id="plotwf_legend-1-attachment" rel="attachment" href="spr_run_files/plotwf_legend/plotwf_legend.svg"/>
<script src="/rmarkdown-libs/plotwf-binding/plotwf.js"></script>
<!--
- Compile from command-line
Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::html_document'), clean=F); knitr::knit('systemPipeR.Rmd', tangle=TRUE)"; Rscript ../md2jekyll.R systemPipeR.knit.md 2; Rscript -e "rmarkdown::render('systemPipeR.Rmd', c('BiocStyle::pdf_document'))"
-->
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("h1").className = "title";
});
</script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  var links = document.links;  
  for (var i = 0, linksLength = links.length; i < linksLength; i++)
    if (links[i].hostname != window.location.hostname)
      links[i].target = '_blank';
});
</script>

# Project initialization

To create a Workflow within *`systemPipeR`*, we can start by defining an empty
container and checking the directory structure:

``` r
sal <- SPRproject(projPath = tempdir())
```

    ## Creating directory: /tmp/RtmpGojchK/data 
    ## Creating directory: /tmp/RtmpGojchK/param 
    ## Creating directory: /tmp/RtmpGojchK/results 
    ## Creating directory '/tmp/RtmpGojchK/.SPRproject'
    ## Creating file '/tmp/RtmpGojchK/.SPRproject/SYSargsList.yml'

    ## Your current working directory is different from the directory chosen for the Project Workflow.
    ## For accurate location of the files and running the Workflow, please set the working directory to 
    ## 'setwd('/tmp/RtmpGojchK')'

Internally, `SPRproject` function will create a hidden folder called `.SPRproject`,
by default, to store all the log files.
A `YAML` file, here called `SYSargsList.yml`, has been created, which initially
contains the basic location of the project structure; however, every time the
workflow object `sal` is updated in R, the new information will also be store in this
flat-file database for easy recovery.
If you desire different names for the logs folder and the `YAML` file, these can
be modified as follows:

``` r
sal <- SPRproject(logs.dir = ".SPRproject", sys.file = ".SPRproject/SYSargsList.yml")
```

Also, this function will check and/or create the basic folder structure if missing,
which means `data`, `param`, and `results` folder, as described [here](#dir).
If the user wants to use a different names for these directories, can be specified
as follows:

``` r
sal <- SPRproject(data = "data", param = "param", results = "results")
```

It is possible to separate all the R objects created within the workflow analysis
from the current environment. `SPRproject` function provides the option to create
a new environment, and in this way, it is not overwriting any object you may want
to have at your current section.

``` r
sal <- SPRproject(envir = new.env())
```

In this stage, the object `sal` is a empty container, except for the project information. The project information can be accessed by the `projectInfo` method:

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##  No workflow steps added

``` r
projectInfo(sal)
```

    ## $project
    ## [1] "/tmp/RtmpGojchK"
    ## 
    ## $data
    ## [1] "data"
    ## 
    ## $param
    ## [1] "param"
    ## 
    ## $results
    ## [1] "results"
    ## 
    ## $logsDir
    ## [1] ".SPRproject"
    ## 
    ## $sysargslist
    ## [1] ".SPRproject/SYSargsList.yml"

Also, the `length` function will return how many steps this workflow contains and
in this case it is empty, as follow:

``` r
length(sal)
```

    ## [1] 0

# Workflow Design

*`systemPipeR`* workflows can be designed and built from start to finish with a
single command, importing from an R Markdown file or stepwise in interactive
mode from the R console.
In the [next section](#appendstep), we will demonstrate how to build the workflow in an
interactive mode, and in the [following section](#importWF), we will show how to build from a
file.

New workflows are constructed, or existing ones modified, by connecting each
step via `appendStep` method. Each `SYSargsList` instance contains instructions
needed for processing a set of input files with a specific command-line or R
software, as well as the paths to the corresponding outfiles generated by a
particular tool/step.

To build R code based step, the constructor function `Linewise` is used.
For more details about this S4 class container, see [here](#linewise).

## Build workflow interactive

This tutorial shows a very simple example for describing and explaining all main
features available within systemPipeR to design, build, manage, run, and
visualize the workflow. In summary, we are exporting a dataset to multiple
files, compressing and decompressing each one of the files, and importing to R,
and finally performing a statistical analysis.

In the previous section, we initialize the project by building the `sal` object.
Until this moment, the container has no steps:

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##  No workflow steps added

Next, we need to populate the object created with the first step in the
workflow.

### Adding the first step

The first step is R code based, and we are splitting the `iris` dataset by `Species`
and for each `Species` will be saved on file. Please note that this code will
not be executed now; it is just store in the container for further execution.

This constructor function requires the `step_name` and the R-based code under
the `code` argument.
The R code should be enclosed by braces (`{}`) and separated by a new line.

``` r
appendStep(sal) <- LineWise(code = {
    mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results",
        paste0(names(split(iris, factor(iris$Species))), ".csv")))
}, step_name = "export_iris")
```

For a brief overview of the workflow, we can check the object as follows:

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ## 

Also, for printing and double-check the R code in the step, we can use the
`codeLine` method:

``` r
codeLine(sal)
```

    ## export_iris
    ##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))

### Adding more steps

Next, an example of how to compress the exported files using
[`gzip`](https://www.gnu.org/software/gzip/) command-line.

The constructor function creates an `SYSargsList` S4 class object using data from
three input files:

    - CWL command-line specification file (`wf_file` argument);
    - Input variables (`input_file` argument);
    - Targets file (`targets` argument).

In CWL, files with the extension `.cwl` define the parameters of a chosen
command-line step or workflow, while files with the extension `.yml` define the
input variables of command-line steps.

The `targets` file is optional for workflow steps lacking `input` files. The connection
between `input` variables and the `targets` file is defined under the `inputvars`
argument. It is required a `named vector`, where each element name needs to match
with column names in the `targets` file, and the value must match the names of
the `input` variables defined in the `*.yml` files (see Figure <a href="#fig:sprCWL"><strong>??</strong></a>).

A detailed description of the dynamic between `input` variables and `targets`
files can be found [here](#cwl_targets).
In addition, the CWL syntax overview can be found [here](#cwl).

Besides all the data form `targets`, `wf_file`, `input_file` and `dir_path` arguments,
`SYSargsList` constructor function options include:

-   `step_name`: a unique *name* for the step. This is not mandatory; however,
    it is highly recommended. If no name is provided, a default `step_x`, where
    `x` reflects the step index, will be added.
-   `dir`: this option allows creating an exclusive subdirectory for the step
    in the workflow. All the outfiles and log files for this particular step will
    be generated in the respective folders.
-   `dependency`: after the first step, all the additional steps appended to
    the workflow require the information of the dependency tree.

The `appendStep<-` method is used to append a new step in the workflow.

``` r
targetspath <- system.file("extdata/cwl/gunzip", "targets_gunzip.txt", package = "systemPipeR")
appendStep(sal) <- SYSargsList(step_name = "gzip", targets = targetspath, dir = TRUE,
    wf_file = "gunzip/workflow_gzip.cwl", input_file = "gunzip/gzip.yml", dir_path = system.file("extdata/cwl",
        package = "systemPipeR"), inputvars = c(FileName = "_FILE_PATH_", SampleName = "_SampleName_"),
    dependency = "export_iris")
```

Note: This will not work if the `gzip` is not available on your system
(installed and exported to PATH) and may only work on Windows systems using PowerShell.

For a overview of the workflow, we can check the object as follows:

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ##        2. gzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          2.1. gzip
    ##              cmdlist: 3 | Pending: 3
    ## 

Note that we have two steps, and it is expected three files from the second step.
Also, the workflow status is *Pending*, which means the workflow object is
rendered in R; however, we did not execute the workflow yet.
In addition to this summary, it can be observed this step has three command lines.

For more details about the command-line rendered for each target file, it can be
checked as follows:

``` r
cmdlist(sal, step = "gzip")
```

    ## $gzip
    ## $gzip$SE
    ## $gzip$SE$gzip
    ## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"
    ## 
    ## 
    ## $gzip$VE
    ## $gzip$VE$gzip
    ## [1] "gzip -c  results/versicolor.csv > results/VE.csv.gz"
    ## 
    ## 
    ## $gzip$VI
    ## $gzip$VI$gzip
    ## [1] "gzip -c  results/virginica.csv > results/VI.csv.gz"

#### Using the `outfiles` for the next step

For building this step, all the previous procedures are being used to append the
next step. However, here, we can observe power features that build the
connectivity between steps in the workflow.

In this example, we would like to use the outfiles from *gzip* Step, as
input from the next step, which is the *gunzip*. In this case, let’s look at the
outfiles from the first step:

``` r
outfiles(sal)
```

    ## $export_iris
    ## DataFrame with 0 rows and 0 columns
    ## 
    ## $gzip
    ## DataFrame with 3 rows and 1 column
    ##           gzip_file
    ##         <character>
    ## 1 results/SE.csv.gz
    ## 2 results/VE.csv.gz
    ## 3 results/VI.csv.gz

The column we want to use is “gzip_file.” For the argument `targets` in the
`SYSargsList` function, it should provide the name of the correspondent step in
the Workflow and which `outfiles` you would like to be incorporated in the next
step.
The argument `inputvars` allows the connectivity between `outfiles` and the
new `targets` file. Here, the name of the previous `outfiles` should be provided
it. Please note that all `outfiles` column names must be unique.

It is possible to keep all the original columns from the `targets` files or remove
some columns for a clean `targets` file.
The argument `rm_targets_col` provides this flexibility, where it is possible to
specify the names of the columns that should be removed. If no names are passing
here, the new columns will be appended.

``` r
appendStep(sal) <- SYSargsList(step_name = "gunzip", targets = "gzip", dir = TRUE,
    wf_file = "gunzip/workflow_gunzip.cwl", input_file = "gunzip/gunzip.yml", dir_path = system.file("extdata/cwl",
        package = "systemPipeR"), inputvars = c(gzip_file = "_FILE_PATH_", SampleName = "_SampleName_"),
    rm_targets_col = "FileName", dependency = "gzip")
```

We can check the targets automatically create for this step,
based on the previous `outfiles`:

``` r
targetsWF(sal[3])
```

    ## $gunzip
    ## DataFrame with 3 rows and 2 columns
    ##            gzip_file  SampleName
    ##          <character> <character>
    ## SE results/SE.csv.gz          SE
    ## VE results/VE.csv.gz          VE
    ## VI results/VI.csv.gz          VI

We can also check all the expected `outfiles` for this particular step, as follows:

``` r
outfiles(sal[3])
```

    ## $gunzip
    ## DataFrame with 3 rows and 1 column
    ##      gunzip_file
    ##      <character>
    ## 1 results/SE.csv
    ## 2 results/VE.csv
    ## 3 results/VI.csv

Now, we can observe that the third step has been added and contains one substep.

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ##        2. gzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          2.1. gzip
    ##              cmdlist: 3 | Pending: 3
    ##        3. gunzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          3.1. gunzip
    ##              cmdlist: 3 | Pending: 3
    ## 

In addition, we can access all the command lines for each one of the substeps.

``` r
cmdlist(sal["gzip"], targets = 1)
```

    ## $gzip
    ## $gzip$SE
    ## $gzip$SE$gzip
    ## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"

#### Getting data from a workflow instance

The final step in this simple workflow is an R code step. For that, we are using
the `LineWise` constructor function as demonstrated above.

One interesting feature showed here is the `getColumn` method that allows
extracting the information for a workflow instance. Those files can be used in
an R code, as demonstrated below.

``` r
getColumn(sal, step = "gunzip", "outfiles")
```

    ##               SE               VE               VI 
    ## "results/SE.csv" "results/VE.csv" "results/VI.csv"

``` r
appendStep(sal) <- LineWise(code = {
    df <- lapply(getColumn(sal, step = "gunzip", "outfiles"), function(x) read.delim(x,
        sep = ",")[-1])
    df <- do.call(rbind, df)
    stats <- data.frame(cbind(mean = apply(df[, 1:4], 2, mean), sd = apply(df[, 1:4],
        2, sd)))
    stats$species <- rownames(stats)

    plot <- ggplot2::ggplot(stats, ggplot2::aes(x = species, y = mean, fill = species)) +
        ggplot2::geom_bar(stat = "identity", color = "black", position = ggplot2::position_dodge()) +
        ggplot2::geom_errorbar(ggplot2::aes(ymin = mean - sd, ymax = mean + sd),
            width = 0.2, position = ggplot2::position_dodge(0.9))
}, step_name = "iris_stats", dependency = "gzip")
```

## Build workflow from a {R Markdown}

The precisely same workflow can be created by importing the steps from an
R Markdown file.
As demonstrated above, it is required to initialize the project with `SPRproject` function.

`importWF` function will scan and import all the R chunk from the R Markdown file
and build all the workflow instances. Then, each R chuck in the file will be
converted in a workflow step.

``` r
sal_rmd <- SPRproject(logs.dir = ".SPRproject_rmd")
```

    ## Creating directory: /home/dcassol/danielac@ucr.edu/projects/SP/SPR_org/newdeploy/systemPipeR.github.io/content/en/sp/spr/data 
    ## Creating directory: /home/dcassol/danielac@ucr.edu/projects/SP/SPR_org/newdeploy/systemPipeR.github.io/content/en/sp/spr/param 
    ## Creating directory: /home/dcassol/danielac@ucr.edu/projects/SP/SPR_org/newdeploy/systemPipeR.github.io/content/en/sp/spr/results 
    ## Creating directory '/home/dcassol/danielac@ucr.edu/projects/SP/SPR_org/newdeploy/systemPipeR.github.io/content/en/sp/spr/.SPRproject_rmd'
    ## Creating file '/home/dcassol/danielac@ucr.edu/projects/SP/SPR_org/newdeploy/systemPipeR.github.io/content/en/sp/spr/.SPRproject_rmd/SYSargsList.yml'

``` r
sal_rmd <- importWF(sal_rmd, file_path = system.file("extdata", "spr_simple_wf.Rmd",
    package = "systemPipeR"))
```

    ## Reading Rmd file

    ## 
    ##  ---- Actions ----

    ## Checking chunk SPR option

    ## Ignore non-SPR chunks: 17

    ## Checking chunk spr.req option

    ## Checking chunk spr.ses option

    ## Checking chunk eval values

    ## Resolve step names

    ## Check duplicated step names

    ## Checking chunk dependencies

    ## Use the previous step as dependency for steps without 'spr.dep' options: 25, 37

    ## Parse chunk code

    ## ---- Succes! Create output ----

    ## Now importing step 'load_library' 
    ## Now importing step 'export_iris' 
    ## Now importing step 'gzip' 
    ## Now importing step 'gunzip' 
    ## Now importing step 'stats'

Let’s explore the workflow to check the steps:

``` r
stepsWF(sal_rmd)
```

    ## $load_library
    ## Instance of 'LineWise'
    ##     Code Chunk length: 1
    ## 
    ## $export_iris
    ## Instance of 'LineWise'
    ##     Code Chunk length: 1
    ## 
    ## $gzip
    ## Instance of 'SYSargs2':
    ##    Slot names/accessors: 
    ##       targets: 3 (SE...VI), targetsheader: 1 (lines)
    ##       modules: 0
    ##       wf: 1, clt: 1, yamlinput: 4 (inputs)
    ##       input: 3, output: 3
    ##       cmdlist: 3
    ##    Sub Steps:
    ##       1. gzip (rendered: TRUE)
    ## 
    ## 
    ## 
    ## $gunzip
    ## Instance of 'SYSargs2':
    ##    Slot names/accessors: 
    ##       targets: 3 (SE...VI), targetsheader: 1 (lines)
    ##       modules: 0
    ##       wf: 1, clt: 1, yamlinput: 4 (inputs)
    ##       input: 3, output: 3
    ##       cmdlist: 3
    ##    Sub Steps:
    ##       1. gunzip (rendered: TRUE)
    ## 
    ## 
    ## 
    ## $stats
    ## Instance of 'LineWise'
    ##     Code Chunk length: 5

``` r
dependency(sal_rmd)
```

    ## $load_library
    ## [1] NA
    ## 
    ## $export_iris
    ## [1] NA
    ## 
    ## $gzip
    ## [1] "export_iris"
    ## 
    ## $gunzip
    ## [1] "gzip"
    ## 
    ## $stats
    ## [1] "gunzip"

``` r
codeLine(sal_rmd)
```

    ## gzip AND gunzip step have been dropped because it is not a LineWise object.

    ## load_library
    ##     library(systemPipeR)
    ## export_iris
    ##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))
    ## stats
    ##     df <- lapply(getColumn(sal, step = "gunzip", "outfiles"), function(x) read.delim(x, sep = ",")[-1])
    ##     df <- do.call(rbind, df)
    ##     stats <- data.frame(cbind(mean = apply(df[, 1:4], 2, mean), sd = apply(df[, 1:4], 2, sd)))
    ##     stats$species <- rownames(stats)
    ##     plot <- ggplot2::ggplot(stats, ggplot2::aes(x = species, y = mean, fill = species)) + ggplot2::geom_bar(stat = "identity", color = "black", position = ggplot2::position_dodge()) + ggplot2::geom_errorbar(ggplot2::aes(ymin = mean - sd, ymax = mean + sd), width = 0.2, position = ggplot2::position_dodge(0.9))

``` r
targetsWF(sal_rmd)
```

    ## $load_library
    ## DataFrame with 0 rows and 0 columns
    ## 
    ## $export_iris
    ## DataFrame with 0 rows and 0 columns
    ## 
    ## $gzip
    ## DataFrame with 3 rows and 2 columns
    ##                  FileName  SampleName
    ##               <character> <character>
    ## SE     results/setosa.csv          SE
    ## VE results/versicolor.csv          VE
    ## VI  results/virginica.csv          VI
    ## 
    ## $gunzip
    ## DataFrame with 3 rows and 2 columns
    ##            gzip_file  SampleName
    ##          <character> <character>
    ## SE results/SE.csv.gz          SE
    ## VE results/VE.csv.gz          VE
    ## VI results/VI.csv.gz          VI
    ## 
    ## $stats
    ## DataFrame with 0 rows and 0 columns

### Rules to create the R Markdown to import as workflow

To include a particular code chunk from the R Markdown file in the workflow
analysis, please use the following code chunk options:

    -   `spr='r'`: for code chunks with R code lines;
    -   `spr='sysargs'`: for code chunks with an `SYSargsList` object;
    -   `spr.dep=<StepName>`: for specify the previous dependency.

For example:

> *\`\`\`{r step_1, eval=TRUE, spr=‘r,’ spr.dep=‘step_0’}*

> *\`\`\`{r step_2, eval=TRUE, spr=‘sysargs,’ spr.dep=‘step_1’}*

For `spr = 'sysargs'`, the last object assigned must to be the `SYSargsList`, for example:

``` r
targetspath <- system.file("extdata/cwl/example/targets_example.txt", package = "systemPipeR")
HW_mul <- SYSargsList(step_name = "Example", targets = targetspath, wf_file = "example/example.cwl",
    input_file = "example/example.yml", dir_path = system.file("extdata/cwl", package = "systemPipeR"),
    inputvars = c(Message = "_STRING_", SampleName = "_SAMPLE_"))
```

Also, note that all the required files or objects to generate one particular
command-line step must be defined in a R code chunk imported.
The motivation for this is that when R Markdown files are imported, the
`spr = 'sysargs'` R chunk will be evaluated and stored in the workflow control
class as the `SYSargsList` object, while the R code based (`spr = 'r'`) is not
evaluated, and until the workflow is executed it will be store as an expression.

# Running the workflow

For running the workflow, `runWF` function will execute all the command lines
store in the workflow container.

``` r
sal <- runWF(sal)
```

This essential function allows the user to choose one or multiple steps to be
executed using the `steps` argument. However, it is necessary to follow the
workflow dependency graph. If a selected step depends on a previous step(s) that
was not executed, the execution will fail.

``` r
sal <- runWF(sal, steps = c(1, 3))
```

Also, it allows forcing the execution of the steps, even if the status of the
step is `'Success'` and all the expected `outfiles` exists.
Another feature of the `runWF` function is ignoring all the warnings
and errors and running the workflow by the arguments `warning.stop` and
`error.stop`, respectively.

``` r
sal <- runWF(sal, force = TRUE, warning.stop = FALSE, error.stop = TRUE)
```

When the project was initialized by `SPRproject` function, it was created an
environment for all objects created during the workflow execution. This
environment can be accessed as follows:

``` r
viewEnvir(sal)
```

The workflow execution allows to save this environment for future recovery:

``` r
sal <- runWF(sal, saveEnv = TRUE)
```

## Workflow status

To check the summary of the workflow, we can use:

``` r
sal
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ##        2. gzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          2.1. gzip
    ##              cmdlist: 3 | Pending: 3
    ##        3. gunzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          3.1. gunzip
    ##              cmdlist: 3 | Pending: 3
    ##        4. iris_stats --> Status: Pending
    ## 

To access more details about the workflow instances, we can use the `statusWF` method:

``` r
statusWF(sal)
```

    ## $export_iris
    ## DataFrame with 1 row and 2 columns
    ##          Step status.summary
    ##   <character>    <character>
    ## 1 export_iris        Pending
    ## 
    ## $gzip
    ## DataFrame with 3 rows and 5 columns
    ##        Targets Total_Files Existing_Files Missing_Files     gzip
    ##    <character>   <numeric>      <numeric>     <numeric> <matrix>
    ## SE          SE           1              0             1  Pending
    ## VE          VE           1              0             1  Pending
    ## VI          VI           1              0             1  Pending
    ## 
    ## $gunzip
    ## DataFrame with 3 rows and 5 columns
    ##        Targets Total_Files Existing_Files Missing_Files   gunzip
    ##    <character>   <numeric>      <numeric>     <numeric> <matrix>
    ## SE          SE           1              0             1  Pending
    ## VE          VE           1              0             1  Pending
    ## VI          VI           1              0             1  Pending
    ## 
    ## $iris_stats
    ## DataFrame with 1 row and 2 columns
    ##          Step status.summary
    ##   <character>    <character>
    ## 1  iris_stats        Pending

## Parallelization on clusters

This section of the tutorial provides an introduction to the usage of the
*`systemPipeR`* features on a cluster.

The computation can be greatly accelerated by processing many files
in parallel using several compute nodes of a cluster, where a scheduling/queuing
system is used for load balancing. For this the `clusterRun` function submits
the computing requests to the scheduler using the run specifications
defined by `runWF`.

A named list provides the computational resources. By default, it can be defined
the upper time limit in minutes for jobs before they get killed by the scheduler,
memory limit in Mb, number of `CPUs`, and number of tasks.

The number of independent parallel cluster processes is defined under the
`Njobs` argument. The following example will run one process in parallel using
for each 4 CPU cores. If the resources available on a cluster allow running all
the processes simultaneously, then the shown sample submission will utilize in
total four CPU cores (`NJobs * ncpus`). Note, `clusterRun` can be used
with most queueing systems as it is based on utilities from the *`batchtools`*
package which supports the use of template files (*`*.tmpl`*) for defining the
run parameters of different schedulers. To run the following code, one needs to
have both a `conf file` (see *`.batchtools.conf.R`* samples [here](https://mllg.github.io/batchtools/))
and a template file (see *`*.tmpl`* samples [here](https://github.com/mllg/batchtools/tree/master/inst/templates))
for the queueing available on a system. The following example uses the sample
`conf` and `template` files for the `Slurm` scheduler provided by this package.

``` r
library(batchtools)
resources <- list(walltime = 120, ntasks = 1, ncpus = 4, memory = 1024)
sal <- clusterRun(sal, FUN = runWF, more.args = list(), conffile = ".batchtools.conf.R",
    template = "batchtools.slurm.tmpl", Njobs = 1, runid = "01", resourceList = resources)
```

Note: The example is submitting the jog to `short` partition. If you desire to
use a different partition, please adjust accordingly (`batchtools.slurm.tmpl`).

# Visualize workflow

*`systemPipeR`* workflows instances can be visualized with the `plotWF` function.

This function will make a plot of selected workflow instance and the following
information is displayed on the plot:

    - Workflow structure (dependency graphs between different steps); 
    - Workflow step status, *e.g.* `Success`, `Error`, `Pending`, `Warnings`; 
    - Sample status and statistics; 
    - Workflow timing: running duration time. 

If no argument is provided, the basic plot will automatically detect width,
height, layout, plot method, branches, *etc*.

``` r
plotWF(sal, width = "80%")
```

<div id="htmlwidget-1" style="width:80%;height:480px;" class="plotwf html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"dot":"digraph {\n    node[fontsize=20];\n    subgraph {\n        export_iris -> gzip -> iris_stats\n   }\n    gzip -> gunzip\n    \n    export_iris[fillcolor=\"#d3d6eb\" style=\"filled, \"label=<<b><font color=\"black\">export_iris<\/font><br><\/br><font color=\"#5cb85c\">0<\/font>/<font color=\"#f0ad4e\">0<\/font>/<font color=\"#d9534f\">0<\/font>/<font color=\"blue\">1<\/font><\/b>; <font color=\"black\">0s<\/font>>  tooltip=\"step export_iris: 0 samples passed; 0 samples have warnings; 0 samples have errors; 1 samples in total; Start time: 2021-12-06 16:23:56; End time: 2021-12-06 16:23:56; Duration: 00:00:00\"]\n    gzip[fillcolor=\"#d3d6eb\" style=\"filled, rounded\" label=<<b><font color=\"black\">gzip<\/font><br><\/br><font color=\"#5cb85c\">0<\/font>/<font color=\"#f0ad4e\">0<\/font>/<font color=\"#d9534f\">0<\/font>/<font color=\"blue\">3<\/font><\/b>; <font color=\"black\">0s<\/font>> , shape=\"box\"  tooltip=\"step gzip: 0 samples passed; 0 samples have warnings; 0 samples have errors; 3 samples in total; Start time: 2021-12-06 16:23:56; End time: 2021-12-06 16:23:56; Duration: 00:00:00\"]\n    gunzip[fillcolor=\"#d3d6eb\" style=\"filled, rounded\" label=<<b><font color=\"black\">gunzip<\/font><br><\/br><font color=\"#5cb85c\">0<\/font>/<font color=\"#f0ad4e\">0<\/font>/<font color=\"#d9534f\">0<\/font>/<font color=\"blue\">3<\/font><\/b>; <font color=\"black\">0s<\/font>> , shape=\"box\"  tooltip=\"step gunzip: 0 samples passed; 0 samples have warnings; 0 samples have errors; 3 samples in total; Start time: 2021-12-06 16:23:56; End time: 2021-12-06 16:23:56; Duration: 00:00:00\"]\n    iris_stats[fillcolor=\"#d3d6eb\" style=\"filled, \"label=<<b><font color=\"black\">iris_stats<\/font><br><\/br><font color=\"#5cb85c\">0<\/font>/<font color=\"#f0ad4e\">0<\/font>/<font color=\"#d9534f\">0<\/font>/<font color=\"blue\">1<\/font><\/b>; <font color=\"black\">0s<\/font>>  tooltip=\"step iris_stats: 0 samples passed; 0 samples have warnings; 0 samples have errors; 1 samples in total; Start time: 2021-12-06 16:23:56; End time: 2021-12-06 16:23:56; Duration: 00:00:00\"]\n        subgraph cluster_legend {\n        rankdir=TB;\n        color=\"#eeeeee\";\n        style=filled;\n        ranksep =1;\n        label=\"Legends\";\n        fontsize = 30;\n        node [style=filled, fontsize=10];\n        legend_img-> step_state[color=\"#eeeeee\"];\n\n        legend_img[shape=none, image=\"plotwf_legend-src.png\", label = \" \", height=1, width=3, style=\"\"];\n\n        step_state[style=\"filled\", shape=\"box\" color=white, label =<\n            <table>\n            <tr><td><b>Step Colors<\/b><\/td><\/tr>\n            <tr><td><font color=\"black\">Pending steps<\/font>; <font color=\"#5cb85c\">Successful steps<\/font>; <font color=\"#d9534f\">Failed steps<\/font><\/td><\/tr>\n            <tr><td><b>Targets Files / Code Chunk <\/b><\/td><\/tr><tr><td><font color=\"#5cb85c\">0 (pass) <\/font> | <font color=\"#f0ad4e\">0 (warning) <\/font> | <font color=\"#d9534f\">0 (error) <\/font> | <font color=\"blue\">0 (total)<\/font>; Duration<\/td><\/tr><\/table>\n            >];\n\n    }\n\n}\n","plotid":"sprwf-52417368","responsive":true,"width":"80%","height":null,"plot_method":"renderSVGElement","rmd":true,"msg":"","plot_ctr":true,"pan_zoom":false,"legend_uri":"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCEtLSBEbyBub3QgZWRpdCB0aGlzIGZpbGUgd2l0aCBlZGl0b3JzIG90aGVyIHRoYW4gZGlhZ3JhbXMubmV0IC0tPgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHZlcnNpb249IjEuMSIgd2lkdGg9IjQ5NnB4IiBoZWlnaHQ9IjI3OHB4IiB2aWV3Qm94PSItMC41IC0wLjUgNDk2IDI3OCIgY29udGVudD0iJmx0O214ZmlsZSBob3N0PSZxdW90O2FwcC5kaWFncmFtcy5uZXQmcXVvdDsgbW9kaWZpZWQ9JnF1b3Q7MjAyMS0xMS0yNFQyMDozOTo0NC45MjNaJnF1b3Q7IGFnZW50PSZxdW90OzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85Ni4wLjQ2NjQuNDUgU2FmYXJpLzUzNy4zNiZxdW90OyB2ZXJzaW9uPSZxdW90OzE1LjguMyZxdW90OyBldGFnPSZxdW90O1RfZEV4bkw3U0xYMmJ1WDhQYVgzJnF1b3Q7IHR5cGU9JnF1b3Q7Z29vZ2xlJnF1b3Q7Jmd0OyZsdDtkaWFncmFtIGlkPSZxdW90O1Z3OVZWaUdzeC1zTF9OaktlN0pQJnF1b3Q7Jmd0OzdWcmJjdUk0RVAwYUhwT3lKZDk0REFSbVhtWjNLMnpWUGl0WUdGVmt5V1BMZ2N6WHIyVEwrQ0lEM3NHUVRSVWtsZGd0cVMyZDAycDF0NW5BZWJ6L2xxSmsrNE9IbUU2QUZlNG44SGtDZ0EwQW1LaGZLL3pRRXN2eFMwbVVrbERMYXNHSy9NSlZSeTNOU1lpelZrZkJPUlVrYVF2WG5ERzhGaTBaU2xPK2EzZmJjTnArYW9JaWJBaFdhMFJONlQ4a0ZOdFNPcldzV3Y0ZGsyaGJQZG1yV21KVWRkYUNiSXRDdm11STRHSUM1eW5ub3J5SzkzTk1GWG9WTHVXNDVaSFd3OFJTek1TUUFacUpkMFJ6dlRZOUwvRlJMVFpLZVo1TTRFeitZeUZXNHl4NWQ1aTR1dEZLY0Nyd3ZvOEE5Rm9wczh3SjJvZGxTNFBCUE1ZaS9aQmRLa1dCSHFKdEJVQjl2NnVCQjQ1YnlyWk4wS0duQ2Rka1J3ZmROUjd5UWtQU0R3ODhEMDhibHQyV0NMeEswRnExN3FUNVM5bFd4Rkwvc3kwdk40VFNPYWM4TGNiQzBNVkI2Q2cwUmNyZmNOWENPSlBEWnhGRldkWUhkL2FHeFhwN0R2c214cUFmWTQycEE0ZEI2b3lBcUhOZFJKZkxSZkM4T0lib1ZWRU1wZ05SOUM5SDBiMHVpb3ZsRWl6bnQwWHhMR3p3Y3RpOHNXSGpUT2pUS1RCUjNManFSOG9SSlJHVE1vbzM0aGlvU2xWamJQbVJjaTRmVG9ReXNXQkVoSDNyU2c3VE54RE9PSldOWFpqbDlFVWJ5d3FrdFZ3R2xpak0xQ0tKUEhPZmRFTk13bEFObjZVNEk3LzBrYUl3U1RoaG9waXpPNXU0ejBwWExuaFc4bUlmQmJ4QlZvT0RKcDN5ZG9saVFoWDZmNU5ZUmh6QStnUHY1TjhYSGlNMmxJN1RCeHp3L1VlM2ZjUUIwNVBBSHNLcXcvUVN2Z0tEcnhCbFczd243RGhoMEhVTndnS0RNT2RLaEUwTnduNGdKdVBOV00zK3E1Rm0yN2ZiWm03dzZIZG9jODFRc3M4eGprRmJsYmswZUp2ek9Na0Z2cE4yWXFzNXhsYnI0Y3k3Rm1kMlQ3amcwZUlJVCtRU202eDVQM09Wc2hXNFBKVDRQc2tPUWJLdjIrUlZwUDdMcDhoRUZWZTY1RFJLZFdXcllROVY5LzhVeElWNGczSXFicmU5dktETGxPOFpUTG4yWTA5a0IwWUlpRzB6a1gyNTc2d1RmQVYyaHk5bzlXU0IxOXBaWmw0dHZhRmNYUGhBQ2J1N3hGTXVFWFpkSXJSc2c3amdXc1NaNlh1cTZqc3NvaVpyZFNwbFgrSzhQaUhBQTBOOEdlajFaZTRJSUEvSTdqRUxuMVFoc3piSEJwYWRTbDFoejFXZEVoNHd3cUZSNUR5TFVIUDlQU1pXeVZKTWtTRHZiZlY5a09nbi9LWDJaUE13bVQ2Q0RnUGRxa25HODNTTjlVRFFLSEIyZEVGZ0czRmZWNWRBYVlTRm9hdmc2YkQ0WWRRTnFEQmNSSjNPenNyTy8zY2VaYWJVQWQ1N0RLeHAvWEYvajFQSE1sTG1NNXBIWk5pc2NNZ0VMRVNDNjAxK1A3ZU9CSWhkcHdvZDA2bGVMWlEzNnh4L0pvSndodWlkdEZNbm9UV0F0RDRQTWdwcFpxMWpsUHhMd1RzMCticm83UTRNUGZ4NnF1QjdpK3BpKy9VWkJHYVU3L2k5a2N3SURBS3o2akVLZzR6TGxsdlJ1Q3crbjB1akdaTGVtRWl6RlBLU00wWllORkhxU3hKZTB5R0UycFprdEtDeVErb0taNW4weUYvSUgrczVkdDRFMmRiTnpNSU9nbllZQkwzS0FzNzRaemlHVVpnMWw4b1VRdkora1MyYzlSS3ZhUDBXRmJ2NllWMHlvL1NKRkxHc2dtK21mTVRBNXgyTStZZzdPWWlMaGVreCtHZE8wcTlXZVA5OG0vWGJOZ3VCR1ZIMFZlRkhzVml6N3JRU09CblBoODJMcjJ6Y3JXRzROVXhoMjRNRlpqR3I3MVhhYjFpRHZLMi9WMVZtZnZYWDArRGlYdz09Jmx0Oy9kaWFncmFtJmd0OyZsdDsvbXhmaWxlJmd0OyI+PGRlZnMvPjxnPjxyZWN0IHg9IjQiIHk9IjkwIiB3aWR0aD0iNDkwIiBoZWlnaHQ9IjkyIiBmaWxsPSIjZDVlOGQ0IiBzdHJva2U9Im5vbmUiIHBvaW50ZXItZXZlbnRzPSJub25lIi8+PHJlY3QgeD0iNCIgeT0iMTgyIiB3aWR0aD0iNDkwIiBoZWlnaHQ9Ijk0IiBmaWxsPSIjZmZlOGRlIiBzdHJva2U9Im5vbmUiIHBvaW50ZXItZXZlbnRzPSJub25lIi8+PHJlY3QgeD0iNCIgeT0iNCIgd2lkdGg9IjQ5MCIgaGVpZ2h0PSI4NiIgZmlsbD0iI2VmZjJmYyIgc3Ryb2tlPSJub25lIiBwb2ludGVyLWV2ZW50cz0ibm9uZSIvPjxyZWN0IHg9IjQiIHk9IjQiIHdpZHRoPSIxNDAiIGhlaWdodD0iMjcyIiBmaWxsLW9wYWNpdHk9IjAuOCIgZmlsbD0iI2Y1ZjVmNSIgc3Ryb2tlPSJub25lIiBwb2ludGVyLWV2ZW50cz0ibm9uZSIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAxMXB4OyBtYXJnaW4tbGVmdDogMTE1cHg7Ij48ZGl2IGRhdGEtZHJhd2lvLWNvbG9ycz0iY29sb3I6IHJnYmEoMCwgMCwgMCwgMSk7ICIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMHB4OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogOHB4OyBmb250LWZhbWlseTogJnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7OyBjb2xvcjogcmdiKDAsIDAsIDApOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogbm9uZTsgd2hpdGUtc3BhY2U6IG5vd3JhcDsiPnNvbGlkPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0Pjx0ZXh0IHg9IjExNSIgeT0iMTMiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIGZvbnQtZmFtaWx5PSJUaW1lcyBOZXcgUm9tYW4iIGZvbnQtc2l6ZT0iOHB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5zb2xpZDwvdGV4dD48L3N3aXRjaD48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KXNjYWxlKDIpIj48c3dpdGNoPjxmb3JlaWduT2JqZWN0IHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiByZXF1aXJlZEZlYXR1cmVzPSJodHRwOi8vd3d3LnczLm9yZy9UUi9TVkcxMS9mZWF0dXJlI0V4dGVuc2liaWxpdHkiIHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMXB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDEwcHg7IG1hcmdpbi1sZWZ0OiAxOThweDsiPjxkaXYgZGF0YS1kcmF3aW8tY29sb3JzPSJjb2xvcjogcmdiYSgwLCAwLCAwLCAxKTsgIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwcHg7IHRleHQtYWxpZ246IGNlbnRlcjsiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiA4cHg7IGZvbnQtZmFtaWx5OiAmcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDs7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBub25lOyB3aGl0ZS1zcGFjZTogbm93cmFwOyI+ZGFzaGVkPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0Pjx0ZXh0IHg9IjE5OCIgeT0iMTIiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIGZvbnQtZmFtaWx5PSJUaW1lcyBOZXcgUm9tYW4iIGZvbnQtc2l6ZT0iOHB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5kYXNoZWQ8L3RleHQ+PC9zd2l0Y2g+PC9nPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAzMnB4OyBtYXJnaW4tbGVmdDogMTE2cHg7Ij48ZGl2IGRhdGEtZHJhd2lvLWNvbG9ycz0iY29sb3I6IHJnYmEoMCwgMCwgMCwgMSk7ICIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMHB4OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTFweDsgZm9udC1mYW1pbHk6ICZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OzsgY29sb3I6IHJnYigwLCAwLCAwKTsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IG5vbmU7IHdoaXRlLXNwYWNlOiBub3dyYXA7Ij5NYW5hZ2VtZW50PC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0Pjx0ZXh0IHg9IjExNiIgeT0iMzUiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIGZvbnQtZmFtaWx5PSJUaW1lcyBOZXcgUm9tYW4iIGZvbnQtc2l6ZT0iMTFweCIgdGV4dC1hbmNob3I9Im1pZGRsZSI+TWFuYWdlbWVudDwvdGV4dD48L3N3aXRjaD48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KXNjYWxlKDIpIj48c3dpdGNoPjxmb3JlaWduT2JqZWN0IHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiByZXF1aXJlZEZlYXR1cmVzPSJodHRwOi8vd3d3LnczLm9yZy9UUi9TVkcxMS9mZWF0dXJlI0V4dGVuc2liaWxpdHkiIHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMXB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDMycHg7IG1hcmdpbi1sZWZ0OiAxOThweDsiPjxkaXYgZGF0YS1kcmF3aW8tY29sb3JzPSJjb2xvcjogcmdiYSgwLCAwLCAwLCAxKTsgIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwcHg7IHRleHQtYWxpZ246IGNlbnRlcjsiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMXB4OyBmb250LWZhbWlseTogJnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7OyBjb2xvcjogcmdiKDAsIDAsIDApOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogbm9uZTsgd2hpdGUtc3BhY2U6IG5vd3JhcDsiPkNvbXB1dGU8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PHRleHQgeD0iMTk4IiB5PSIzNSIgZmlsbD0icmdiYSgwLCAwLCAwLCAxKSIgZm9udC1mYW1pbHk9IlRpbWVzIE5ldyBSb21hbiIgZm9udC1zaXplPSIxMXB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5Db21wdXRlPC90ZXh0Pjwvc3dpdGNoPjwvZz48ZWxsaXBzZSBjeD0iMjMyLjUiIGN5PSIxMjMiIHJ4PSI1MS41IiByeT0iMjciIGZpbGw9InJnYmEoMjU1LCAyNTUsIDI1NSwgMSkiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIgc3Ryb2tlLXdpZHRoPSIyIiBwb2ludGVyLWV2ZW50cz0ibm9uZSIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDUwcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNjJweDsgbWFyZ2luLWxlZnQ6IDkycHg7Ij48ZGl2IGRhdGEtZHJhd2lvLWNvbG9ycz0iY29sb3I6IHJnYmEoMCwgMCwgMCwgMSk7ICIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMHB4OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1mYW1pbHk6ICZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OzsgY29sb3I6IHJnYigwLCAwLCAwKTsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IG92ZXJmbG93LXdyYXA6IG5vcm1hbDsiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDhweCI+ZWxsaXBzZTwvc3Bhbj48L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PHRleHQgeD0iMTE2IiB5PSI2NSIgZmlsbD0icmdiYSgwLCAwLCAwLCAxKSIgZm9udC1mYW1pbHk9IlRpbWVzIE5ldyBSb21hbiIgZm9udC1zaXplPSIxMnB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5lbGxpcHNlPC90ZXh0Pjwvc3dpdGNoPjwvZz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpc2NhbGUoMikiPjxzd2l0Y2g+PGZvcmVpZ25PYmplY3QgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHJlcXVpcmVkRmVhdHVyZXM9Imh0dHA6Ly93d3cudzMub3JnL1RSL1NWRzExL2ZlYXR1cmUjRXh0ZW5zaWJpbGl0eSIgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogODVweDsgbWFyZ2luLWxlZnQ6IDExNHB4OyI+PGRpdiBkYXRhLWRyYXdpby1jb2xvcnM9ImNvbG9yOiByZ2JhKDAsIDAsIDAsIDEpOyAiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDBweDsgdGV4dC1hbGlnbjogY2VudGVyOyI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDExcHg7IGZvbnQtZmFtaWx5OiAmcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDs7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBub25lOyB3aGl0ZS1zcGFjZTogbm93cmFwOyI+UjwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48dGV4dCB4PSIxMTQiIHk9Ijg4IiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDEpIiBmb250LWZhbWlseT0iVGltZXMgTmV3IFJvbWFuIiBmb250LXNpemU9IjExcHgiIHRleHQtYW5jaG9yPSJtaWRkbGUiPlI8L3RleHQ+PC9zd2l0Y2g+PC9nPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiA4M3B4OyBtYXJnaW4tbGVmdDogMTk4cHg7Ij48ZGl2IGRhdGEtZHJhd2lvLWNvbG9ycz0iY29sb3I6IHJnYmEoMCwgMCwgMCwgMSk7ICIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMHB4OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTFweDsgZm9udC1mYW1pbHk6ICZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OzsgY29sb3I6IHJnYigwLCAwLCAwKTsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IG5vbmU7IHdoaXRlLXNwYWNlOiBub3dyYXA7Ij5Db21tYW5kLWxpbmU8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PHRleHQgeD0iMTk4IiB5PSI4NiIgZmlsbD0icmdiYSgwLCAwLCAwLCAxKSIgZm9udC1mYW1pbHk9IlRpbWVzIE5ldyBSb21hbiIgZm9udC1zaXplPSIxMXB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5Db21tYW5kLWxpbmU8L3RleHQ+PC9zd2l0Y2g+PC9nPjxyZWN0IHg9IjM0OSIgeT0iOTYiIHdpZHRoPSIxMDUiIGhlaWdodD0iNTAiIHJ4PSI3LjUiIHJ5PSI3LjUiIGZpbGw9InJnYmEoMjU1LCAyNTUsIDI1NSwgMSkiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIgc3Ryb2tlLXdpZHRoPSIyIiBwb2ludGVyLWV2ZW50cz0ibm9uZSIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDUxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNjFweDsgbWFyZ2luLWxlZnQ6IDE3NnB4OyI+PGRpdiBkYXRhLWRyYXdpby1jb2xvcnM9ImNvbG9yOiByZ2JhKDAsIDAsIDAsIDEpOyAiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDBweDsgdGV4dC1hbGlnbjogY2VudGVyOyI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDhweDsgZm9udC1mYW1pbHk6ICZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OzsgY29sb3I6IHJnYigwLCAwLCAwKTsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IG92ZXJmbG93LXdyYXA6IG5vcm1hbDsiPnJlY3RhbmdsZTwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48dGV4dCB4PSIyMDEiIHk9IjYzIiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDEpIiBmb250LWZhbWlseT0iVGltZXMgTmV3IFJvbWFuIiBmb250LXNpemU9IjhweCIgdGV4dC1hbmNob3I9Im1pZGRsZSI+cmVjdGFuZ2xlPC90ZXh0Pjwvc3dpdGNoPjwvZz48cGF0aCBkPSJNIDE4Mi41IDM4IEwgMjg3LjUgMzgiIGZpbGw9Im5vbmUiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIgc3Ryb2tlLXdpZHRoPSI2IiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJub25lIi8+PHBhdGggZD0iTSAzNTQgMzcuNjIgTCA0NTkgMzcuNjIiIGZpbGw9Im5vbmUiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIgc3Ryb2tlLXdpZHRoPSI2IiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHN0cm9rZS1kYXNoYXJyYXk9IjE4IDE4IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAxMjhweDsgbWFyZ2luLWxlZnQ6IDExNXB4OyI+PGRpdiBkYXRhLWRyYXdpby1jb2xvcnM9ImNvbG9yOiByZ2JhKDAsIDAsIDAsIDEpOyAiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDBweDsgdGV4dC1hbGlnbjogY2VudGVyOyI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDExcHg7IGZvbnQtZmFtaWx5OiAmcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDs7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBub25lOyB3aGl0ZS1zcGFjZTogbm93cmFwOyI+TWFuZGF0b3J5PC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0Pjx0ZXh0IHg9IjExNSIgeT0iMTMxIiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDEpIiBmb250LWZhbWlseT0iVGltZXMgTmV3IFJvbWFuIiBmb250LXNpemU9IjExcHgiIHRleHQtYW5jaG9yPSJtaWRkbGUiPk1hbmRhdG9yeTwvdGV4dD48L3N3aXRjaD48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KXNjYWxlKDIpIj48c3dpdGNoPjxmb3JlaWduT2JqZWN0IHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiByZXF1aXJlZEZlYXR1cmVzPSJodHRwOi8vd3d3LnczLm9yZy9UUi9TVkcxMS9mZWF0dXJlI0V4dGVuc2liaWxpdHkiIHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMXB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDEyOHB4OyBtYXJnaW4tbGVmdDogMTk4cHg7Ij48ZGl2IGRhdGEtZHJhd2lvLWNvbG9ycz0iY29sb3I6IHJnYmEoMCwgMCwgMCwgMSk7ICIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMHB4OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTFweDsgZm9udC1mYW1pbHk6ICZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OzsgY29sb3I6IHJnYigwLCAwLCAwKTsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IG5vbmU7IHdoaXRlLXNwYWNlOiBub3dyYXA7Ij5PcHRpb25hbDwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48dGV4dCB4PSIxOTgiIHk9IjEzMSIgZmlsbD0icmdiYSgwLCAwLCAwLCAxKSIgZm9udC1mYW1pbHk9IlRpbWVzIE5ldyBSb21hbiIgZm9udC1zaXplPSIxMXB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5PcHRpb25hbDwvdGV4dD48L3N3aXRjaD48L2c+PHJlY3QgeD0iMTg0IiB5PSIxOTAiIHdpZHRoPSI5NSIgaGVpZ2h0PSI0MCIgZmlsbD0iI2QzZDZlYiIgc3Ryb2tlPSJub25lIiBwb2ludGVyLWV2ZW50cz0ibm9uZSIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDQ2cHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMTA1cHg7IG1hcmdpbi1sZWZ0OiA5M3B4OyI+PGRpdiBkYXRhLWRyYXdpby1jb2xvcnM9ImNvbG9yOiByZ2JhKDAsIDAsIDAsIDEpOyAiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDBweDsgdGV4dC1hbGlnbjogY2VudGVyOyI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiAmcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDs7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyBvdmVyZmxvdy13cmFwOiBub3JtYWw7Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOiA4cHgiPmZpbGw8L3NwYW4+PC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0Pjx0ZXh0IHg9IjExNiIgeT0iMTA5IiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDEpIiBmb250LWZhbWlseT0iVGltZXMgTmV3IFJvbWFuIiBmb250LXNpemU9IjEycHgiIHRleHQtYW5jaG9yPSJtaWRkbGUiPmZpbGw8L3RleHQ+PC9zd2l0Y2g+PC9nPjxyZWN0IHg9IjM0OSIgeT0iMTkwIiB3aWR0aD0iOTUiIGhlaWdodD0iNDAiIGZpbGw9IiNmZmZmZmYiIHN0cm9rZT0ibm9uZSIgcG9pbnRlci1ldmVudHM9Im5vbmUiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpc2NhbGUoMikiPjxzd2l0Y2g+PGZvcmVpZ25PYmplY3QgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHJlcXVpcmVkRmVhdHVyZXM9Imh0dHA6Ly93d3cudzMub3JnL1RSL1NWRzExL2ZlYXR1cmUjRXh0ZW5zaWJpbGl0eSIgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiA0NnB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDEwNXB4OyBtYXJnaW4tbGVmdDogMTc2cHg7Ij48ZGl2IGRhdGEtZHJhd2lvLWNvbG9ycz0iY29sb3I6IHJnYmEoMCwgMCwgMCwgMSk7ICIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMHB4OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1mYW1pbHk6ICZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OzsgY29sb3I6IHJnYigwLCAwLCAwKTsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IG92ZXJmbG93LXdyYXA6IG5vcm1hbDsiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDhweCI+bm8gZmlsbDwvc3Bhbj48L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PHRleHQgeD0iMTk4IiB5PSIxMDkiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIGZvbnQtZmFtaWx5PSJUaW1lcyBOZXcgUm9tYW4iIGZvbnQtc2l6ZT0iMTJweCIgdGV4dC1hbmNob3I9Im1pZGRsZSI+bm8gZmlsbDwvdGV4dD48L3N3aXRjaD48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KXNjYWxlKDIpIj48c3dpdGNoPjxmb3JlaWduT2JqZWN0IHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiByZXF1aXJlZEZlYXR1cmVzPSJodHRwOi8vd3d3LnczLm9yZy9UUi9TVkcxMS9mZWF0dXJlI0V4dGVuc2liaWxpdHkiIHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMXB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDI0cHg7IG1hcmdpbi1sZWZ0OiAzNXB4OyI+PGRpdiBkYXRhLWRyYXdpby1jb2xvcnM9ImNvbG9yOiByZ2JhKDAsIDAsIDAsIDEpOyAiIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDBweDsgdGV4dC1hbGlnbjogY2VudGVyOyI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEwcHg7IGZvbnQtZmFtaWx5OiAmcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDs7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBub25lOyBmb250LXdlaWdodDogYm9sZDsgd2hpdGUtc3BhY2U6IG5vd3JhcDsiPlJ1bm5pbmcgPGJyIHN0eWxlPSJmb250LXNpemU6IDEwcHgiIC8+U2Vzc2lvbjwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48dGV4dCB4PSIzNSIgeT0iMjciIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIGZvbnQtZmFtaWx5PSJUaW1lcyBOZXcgUm9tYW4iIGZvbnQtc2l6ZT0iMTBweCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZm9udC13ZWlnaHQ9ImJvbGQiPlJ1bm5pbmcuLi48L3RleHQ+PC9zd2l0Y2g+PC9nPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAxMTNweDsgbWFyZ2luLWxlZnQ6IDM1cHg7Ij48ZGl2IGRhdGEtZHJhd2lvLWNvbG9ycz0iY29sb3I6IHJnYmEoMCwgMCwgMCwgMSk7ICIgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMHB4OyB0ZXh0LWFsaWduOiBjZW50ZXI7Ij48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTBweDsgZm9udC1mYW1pbHk6ICZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OzsgY29sb3I6IHJnYigwLCAwLCAwKTsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IG5vbmU7IGZvbnQtd2VpZ2h0OiBib2xkOyB3aGl0ZS1zcGFjZTogbm93cmFwOyI+PGRpdiBzdHlsZT0iZm9udC1zaXplOiAxMHB4Ij48c3BhbiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogdHJhbnNwYXJlbnQgOyBmb250LXNpemU6IDEwcHgiPlJ1bm5pbmc8L3NwYW4+PC9kaXY+UmVxdWlyZW1lbnQ8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PHRleHQgeD0iMzUiIHk9IjExNiIgZmlsbD0icmdiYSgwLCAwLCAwLCAxKSIgZm9udC1mYW1pbHk9IlRpbWVzIE5ldyBSb21hbiIgZm9udC1zaXplPSIxMHB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LXdlaWdodD0iYm9sZCI+UnVubmluZ1JlcXVpcmUuLi48L3RleHQ+PC9zd2l0Y2g+PC9nPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSlzY2FsZSgyKSI+PHN3aXRjaD48Zm9yZWlnbk9iamVjdCBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5IiBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7Ij48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiA2OHB4OyBtYXJnaW4tbGVmdDogMzVweDsiPjxkaXYgZGF0YS1kcmF3aW8tY29sb3JzPSJjb2xvcjogcmdiYSgwLCAwLCAwLCAxKTsgIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwcHg7IHRleHQtYWxpZ246IGNlbnRlcjsiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMHB4OyBmb250LWZhbWlseTogJnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7OyBjb2xvcjogcmdiKDAsIDAsIDApOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogbm9uZTsgZm9udC13ZWlnaHQ6IGJvbGQ7IHdoaXRlLXNwYWNlOiBub3dyYXA7Ij5TdGVwIDxiciBzdHlsZT0iZm9udC1zaXplOiAxMHB4IiAvPkNsYXNzPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0Pjx0ZXh0IHg9IjM1IiB5PSI3MSIgZmlsbD0icmdiYSgwLCAwLCAwLCAxKSIgZm9udC1mYW1pbHk9IlRpbWVzIE5ldyBSb21hbiIgZm9udC1zaXplPSIxMHB4IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmb250LXdlaWdodD0iYm9sZCI+U3RlcC4uLjwvdGV4dD48L3N3aXRjaD48L2c+PC9nPjxzd2l0Y2g+PGcgcmVxdWlyZWRGZWF0dXJlcz0iaHR0cDovL3d3dy53My5vcmcvVFIvU1ZHMTEvZmVhdHVyZSNFeHRlbnNpYmlsaXR5Ii8+PGEgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCwtNSkiIHhsaW5rOmhyZWY9Imh0dHBzOi8vd3d3LmRpYWdyYW1zLm5ldC9kb2MvZmFxL3N2Zy1leHBvcnQtdGV4dC1wcm9ibGVtcyIgdGFyZ2V0PSJfYmxhbmsiPjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIGZvbnQtc2l6ZT0iMTBweCIgeD0iNTAlIiB5PSIxMDAlIj5WaWV3ZXIgZG9lcyBub3Qgc3VwcG9ydCBmdWxsIFNWRyAxLjE8L3RleHQ+PC9hPjwvc3dpdGNoPjwvc3ZnPg=="},"evals":[],"jsHooks":[]}</script>

For more details about the `plotWF` function, please see [here](#plotWF).

# Technical report

*`systemPipeR`* compiles all the workflow execution logs in one central location,
making it easier to check any standard output (`stdout`) or standard error
(`stderr`) for any command-line tools used on the workflow or the R code `stdout`.
Also, the workflow plot is appended at the beginning of the report, making it
easier to click on the respective step.

``` r
sal <- renderLogs(sal)
```

# Exported the workflow

*`systemPipeR`* workflow management system allows to translate and export the
workflow build interactively to R Markdown format or an executable bash script.
This feature advances the reusability of the workflow, as well as the flexibility
for workflow execution.

## R Markdown file

`sal2rmd` function takes an `SYSargsList` workflow container and translates it to
SPR workflow template R markdown format. This file can be imported with the
`importWF` function, as demonstrated above.

``` r
sal2rmd(sal)
```

## Bash script

`sal2bash` function takes an `SYSargsList` workflow container and translates
it to an executable bash script, so one can run the workflow without loading
`SPR` or using an R console.

``` r
sal2bash(sal)
```

It will be generated on the project root an executable bash script, called by
default the `spr_wf.sh`. Also, a directory `./spr_wf` will be created and store
all the R scripts based on the workflow steps. Please note that this function will
“collapse” adjacent R steps into one file as much as possible.

# Project Resume and Restart

If you desire to resume or restart a project that has been initialized in the past,
`SPRproject` function allows this operation.

With the resume option, it is possible to load the `SYSargsList` object in R and
resume the analysis. Please, make sure to provide the `logs.dir` location, and the
corresponded `YAML` file name.
The current working directory needs to be in the project root directory.

``` r
sal <- SPRproject(resume = TRUE, logs.dir = ".SPRproject", sys.file = ".SPRproject/SYSargsList.yml")
```

If you choose to save the environment in the last analysis, you can recover all
the files created in that particular section. `SPRproject` function allows this
with `load.envir` argument. Please note that the environment was saved only with
you run the workflow in the last section (`runWF()`).

``` r
sal <- SPRproject(resume = TRUE, load.envir = TRUE)
```

After loading the workflow at your current section, you can check the objects
created in the old environment and decide if it is necessary to copy them to the
current environment.

``` r
viewEnvir(sal)
copyEnvir(sal, list = "plot", new.env = globalenv())
```

This option will keep all previous logs in the folder; however, if you desire to
clean the execution history and restart the workflow, the `restart=TRUE` option
can be used.

``` r
sal <- SPRproject(restart = TRUE, overwrite = TRUE, load.envir = FALSE)
```

The last and more drastic option from `SYSproject` function is to overwrite the
logs and the workflow. This option will delete the hidden folder and the
information on the `SYSargsList.yml` files. This will not delete any parameter
file nor any results it was created in previous runs. Please use with caution.

``` r
sal <- SPRproject(overwrite = TRUE)
```

# Exploring workflow instances

*`systemPipeR`* provide several accessor methods and useful functions to explore
`SYSargsList` workflow object.

## Accessor Methods

Several accessor methods are available that are named after the slot names of
the `SYSargsList` workflow object.

``` r
names(sal)
```

    ## [1] "stepsWF"            "statusWF"           "targetsWF"         
    ## [4] "outfiles"           "SE"                 "dependency"        
    ## [7] "targets_connection" "projectInfo"        "runInfo"

-   Check the length of the workflow:

``` r
length(sal)
```

    ## [1] 4

-   Check the steps of the workflow:

``` r
stepsWF(sal)
```

    ## $export_iris
    ## Instance of 'LineWise'
    ##     Code Chunk length: 1
    ## 
    ## $gzip
    ## Instance of 'SYSargs2':
    ##    Slot names/accessors: 
    ##       targets: 3 (SE...VI), targetsheader: 1 (lines)
    ##       modules: 0
    ##       wf: 1, clt: 1, yamlinput: 4 (inputs)
    ##       input: 3, output: 3
    ##       cmdlist: 3
    ##    Sub Steps:
    ##       1. gzip (rendered: TRUE)
    ## 
    ## 
    ## 
    ## $gunzip
    ## Instance of 'SYSargs2':
    ##    Slot names/accessors: 
    ##       targets: 3 (SE...VI), targetsheader: 1 (lines)
    ##       modules: 0
    ##       wf: 1, clt: 1, yamlinput: 4 (inputs)
    ##       input: 3, output: 3
    ##       cmdlist: 3
    ##    Sub Steps:
    ##       1. gunzip (rendered: TRUE)
    ## 
    ## 
    ## 
    ## $iris_stats
    ## Instance of 'LineWise'
    ##     Code Chunk length: 5

-   Checking the command-line for each target sample:

`cmdlist()` method printing the system commands for running command-line
software as specified by a given `*.cwl` file combined with the paths to the
input samples (*e.g.* FASTQ files) provided by a `targets` file. The example below
shows the `cmdlist()` output for running `gzip` and `gunzip` on the first sample.
Evaluating the output of `cmdlist()` can be very helpful for designing
and debugging `*.cwl` files of new command-line software or changing the
parameter settings of existing ones.

``` r
cmdlist(sal, step = c(2, 3), targets = 1)
```

    ## $gzip
    ## $gzip$SE
    ## $gzip$SE$gzip
    ## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"
    ## 
    ## 
    ## 
    ## $gunzip
    ## $gunzip$SE
    ## $gunzip$SE$gunzip
    ## [1] "gunzip -c  results/SE.csv.gz > results/SE.csv"

-   Check the workflow status:

``` r
statusWF(sal)
```

    ## $export_iris
    ## DataFrame with 1 row and 2 columns
    ##          Step status.summary
    ##   <character>    <character>
    ## 1 export_iris        Pending
    ## 
    ## $gzip
    ## DataFrame with 3 rows and 5 columns
    ##        Targets Total_Files Existing_Files Missing_Files     gzip
    ##    <character>   <numeric>      <numeric>     <numeric> <matrix>
    ## SE          SE           1              0             1  Pending
    ## VE          VE           1              0             1  Pending
    ## VI          VI           1              0             1  Pending
    ## 
    ## $gunzip
    ## DataFrame with 3 rows and 5 columns
    ##        Targets Total_Files Existing_Files Missing_Files   gunzip
    ##    <character>   <numeric>      <numeric>     <numeric> <matrix>
    ## SE          SE           1              0             1  Pending
    ## VE          VE           1              0             1  Pending
    ## VI          VI           1              0             1  Pending
    ## 
    ## $iris_stats
    ## DataFrame with 1 row and 2 columns
    ##          Step status.summary
    ##   <character>    <character>
    ## 1  iris_stats        Pending

-   Check the workflow targets files:

``` r
targetsWF(sal[2])
```

    ## $gzip
    ## DataFrame with 3 rows and 2 columns
    ##                  FileName  SampleName
    ##               <character> <character>
    ## SE     results/setosa.csv          SE
    ## VE results/versicolor.csv          VE
    ## VI  results/virginica.csv          VI

-   Checking the expected outfiles files:

The `outfiles` components of `SYSargsList` define the expected outfiles files
for each step in the workflow, some of which are the input for the next workflow step.

``` r
outfiles(sal[2])
```

    ## $gzip
    ## DataFrame with 3 rows and 1 column
    ##           gzip_file
    ##         <character>
    ## 1 results/SE.csv.gz
    ## 2 results/VE.csv.gz
    ## 3 results/VI.csv.gz

-   Check the workflow dependencies:

``` r
dependency(sal)
```

    ## $export_iris
    ## [1] NA
    ## 
    ## $gzip
    ## [1] "export_iris"
    ## 
    ## $gunzip
    ## [1] "gzip"
    ## 
    ## $iris_stats
    ## [1] "gzip"

-   Check the sample comparisons:

Sample comparisons are defined in the header lines of the `targets` file
starting with ‘`# <CMP>`.’ This information can be accessed as follows:

``` r
targetsheader(sal, step = "Quality")
```

-   Get the workflow steps names:

``` r
stepName(sal)
```

    ## [1] "export_iris" "gzip"        "gunzip"      "iris_stats"

-   Get the Sample Id for on particular step:

``` r
SampleName(sal, step = "gzip")
```

    ## [1] "SE" "VE" "VI"

``` r
SampleName(sal, step = "iris_stats")
```

    ## This step doesn't contain multiple samples.

-   Get the `outfiles` or `targets` column files:

``` r
getColumn(sal, "outfiles", step = "gzip", column = "gzip_file")
```

    ##                  SE                  VE                  VI 
    ## "results/SE.csv.gz" "results/VE.csv.gz" "results/VI.csv.gz"

``` r
getColumn(sal, "targetsWF", step = "gzip", column = "FileName")
```

    ##                       SE                       VE                       VI 
    ##     "results/setosa.csv" "results/versicolor.csv"  "results/virginica.csv"

-   Get the R code for a `LineWise` step:

``` r
codeLine(sal, step = "export_iris")
```

    ## export_iris
    ##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))

-   View all the objects in the running environment:

``` r
viewEnvir(sal)
```

    ## <environment: 0x5606b7c97228>
    ## character(0)

-   Copy one or multiple objects from the running environment to a new environment:

``` r
copyEnvir(sal, list = c("plot"), new.env = globalenv(), silent = FALSE)
```

    ## <environment: 0x5606b7c97228>
    ## Copying to 'new.env': 
    ## plot

-   Accessing the `*.yml` data

``` r
yamlinput(sal, step = "gzip")
```

    ## $file
    ## $file$class
    ## [1] "File"
    ## 
    ## $file$path
    ## [1] "_FILE_PATH_"
    ## 
    ## 
    ## $SampleName
    ## [1] "_SampleName_"
    ## 
    ## $ext
    ## [1] "csv.gz"
    ## 
    ## $results_path
    ## $results_path$class
    ## [1] "Directory"
    ## 
    ## $results_path$path
    ## [1] "./results"

## Subsetting the workflow details

-   The `SYSargsList` class and its subsetting operator `[`:

``` r
sal[1]
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ## 

``` r
sal[1:3]
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ##        2. gzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          2.1. gzip
    ##              cmdlist: 3 | Pending: 3
    ##        3. gunzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          3.1. gunzip
    ##              cmdlist: 3 | Pending: 3
    ## 

``` r
sal[c(1, 3)]
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ##        2. gunzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          2.1. gunzip
    ##              cmdlist: 3 | Pending: 3
    ## 

-   The `SYSargsList` class and its subsetting by steps and input samples:

``` r
sal_sub <- subset(sal, subset_steps = c(2, 3), input_targets = ("SE"), keep_steps = TRUE)
stepsWF(sal_sub)
```

    ## $export_iris
    ## Instance of 'LineWise'
    ##     Code Chunk length: 1
    ## 
    ## $gzip
    ## Instance of 'SYSargs2':
    ##    Slot names/accessors: 
    ##       targets: 1 (SE...SE), targetsheader: 1 (lines)
    ##       modules: 0
    ##       wf: 1, clt: 1, yamlinput: 4 (inputs)
    ##       input: 1, output: 1
    ##       cmdlist: 1
    ##    Sub Steps:
    ##       1. gzip (rendered: TRUE)
    ## 
    ## 
    ## 
    ## $gunzip
    ## Instance of 'SYSargs2':
    ##    Slot names/accessors: 
    ##       targets: 1 (SE...SE), targetsheader: 1 (lines)
    ##       modules: 0
    ##       wf: 1, clt: 1, yamlinput: 4 (inputs)
    ##       input: 1, output: 1
    ##       cmdlist: 1
    ##    Sub Steps:
    ##       1. gunzip (rendered: TRUE)
    ## 
    ## 
    ## 
    ## $iris_stats
    ## Instance of 'LineWise'
    ##     Code Chunk length: 5

``` r
targetsWF(sal_sub)
```

    ## $export_iris
    ## DataFrame with 0 rows and 0 columns
    ## 
    ## $gzip
    ## DataFrame with 1 row and 2 columns
    ##              FileName  SampleName
    ##           <character> <character>
    ## SE results/setosa.csv          SE
    ## 
    ## $gunzip
    ## DataFrame with 1 row and 2 columns
    ##            gzip_file  SampleName
    ##          <character> <character>
    ## SE results/SE.csv.gz          SE
    ## 
    ## $iris_stats
    ## DataFrame with 0 rows and 0 columns

``` r
outfiles(sal_sub)
```

    ## $export_iris
    ## DataFrame with 0 rows and 0 columns
    ## 
    ## $gzip
    ## DataFrame with 1 row and 1 column
    ##           gzip_file
    ##         <character>
    ## 1 results/SE.csv.gz
    ## 
    ## $gunzip
    ## DataFrame with 1 row and 1 column
    ##      gunzip_file
    ##      <character>
    ## 1 results/SE.csv
    ## 
    ## $iris_stats
    ## DataFrame with 0 rows and 0 columns

-   The `SYSargsList` class and its operator `+`

``` r
sal[1] + sal[2] + sal[3]
```

## Replacement Methods

-   Update a `input` parameter in the workflow

``` r
sal_c <- sal
## check values
yamlinput(sal_c, step = "gzip")
```

    ## $file
    ## $file$class
    ## [1] "File"
    ## 
    ## $file$path
    ## [1] "_FILE_PATH_"
    ## 
    ## 
    ## $SampleName
    ## [1] "_SampleName_"
    ## 
    ## $ext
    ## [1] "csv.gz"
    ## 
    ## $results_path
    ## $results_path$class
    ## [1] "Directory"
    ## 
    ## $results_path$path
    ## [1] "./results"

``` r
## check on command-line
cmdlist(sal_c, step = "gzip", targets = 1)
```

    ## $gzip
    ## $gzip$SE
    ## $gzip$SE$gzip
    ## [1] "gzip -c  results/setosa.csv > results/SE.csv.gz"

``` r
## Replace
yamlinput(sal_c, step = "gzip", paramName = "ext") <- "txt.gz"

## check NEW values
yamlinput(sal_c, step = "gzip")
```

    ## $file
    ## $file$class
    ## [1] "File"
    ## 
    ## $file$path
    ## [1] "_FILE_PATH_"
    ## 
    ## 
    ## $SampleName
    ## [1] "_SampleName_"
    ## 
    ## $ext
    ## [1] "txt.gz"
    ## 
    ## $results_path
    ## $results_path$class
    ## [1] "Directory"
    ## 
    ## $results_path$path
    ## [1] "./results"

``` r
## Check on command-line
cmdlist(sal_c, step = "gzip", targets = 1)
```

    ## $gzip
    ## $gzip$SE
    ## $gzip$SE$gzip
    ## [1] "gzip -c  results/setosa.csv > results/SE.txt.gz"

-   Append and Replacement methods for R Code Steps

``` r
appendCodeLine(sal_c, step = "export_iris", after = 1) <- "log_cal_100 <- log(100)"
```

    ## Warning in .getPath(sys.file, full_path = FALSE): No such file or directory.
    ## Check the file PATH.

``` r
codeLine(sal_c, step = "export_iris")
```

    ## export_iris
    ##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))
    ##     log_cal_100 <- log(100)

``` r
replaceCodeLine(sal_c, step = "export_iris", line = 2) <- LineWise(code = {
    log_cal_100 <- log(50)
})
codeLine(sal_c, step = 1)
```

    ## export_iris
    ##     mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))
    ##     log_cal_100 <- log(50)

For more details about the `LineWise` class, please see [below](#linewise).

-   Rename a Step

``` r
renameStep(sal_c, step = 1) <- "newStep"
renameStep(sal_c, c(1, 2)) <- c("newStep2", "newIndex")
sal_c
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. newStep2 --> Status: Pending
    ##        2. newIndex --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          2.1. gzip
    ##              cmdlist: 3 | Pending: 3
    ##        3. gunzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          3.1. gunzip
    ##              cmdlist: 3 | Pending: 3
    ##        4. iris_stats --> Status: Pending
    ## 

``` r
names(outfiles(sal_c))
```

    ## [1] "newStep2"   "newIndex"   "gunzip"     "iris_stats"

``` r
names(targetsWF(sal_c))
```

    ## [1] "newStep2"   "newIndex"   "gunzip"     "iris_stats"

``` r
dependency(sal_c)
```

    ## $newStep2
    ## [1] NA
    ## 
    ## $newIndex
    ## [1] "newStep2"
    ## 
    ## $gunzip
    ## [1] "newIndex"
    ## 
    ## $iris_stats
    ## [1] "newIndex"

-   Replace a Step

``` r
sal_test <- sal[c(1, 2)]
replaceStep(sal_test, step = 1, step_name = "gunzip") <- sal[3]
sal_test
```

Note: Please use this method with attention, because it can disrupt all
the dependency graphs.

-   Removing a Step

``` r
sal_test <- sal[-2]
sal_test
```

    ## Instance of 'SYSargsList': 
    ##     WF Steps:
    ##        1. export_iris --> Status: Pending
    ##        2. gunzip --> Status: Pending 
    ##            Total Files: 3 | Existing: 0 | Missing: 3 
    ##          2.1. gunzip
    ##              cmdlist: 3 | Pending: 3
    ##        3. iris_stats --> Status: Pending
    ## 

# References

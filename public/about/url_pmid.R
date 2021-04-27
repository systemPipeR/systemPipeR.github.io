######################################
## Utility to add URL link to PMID ##
######################################
## Author: Daniela Cassol
## Last update: 26-Apr-2021
#' Utility to add URL link to PMID
#' @description This function can be used to add the URL link automatically from
#' the citation copied from Paperpile, select the National Library of Medicine
#' (grant proposals with PMCID/PMID) style, and select "Always include DOIs and
#' URLs." After that, select all the required publications and `Cite` and
#' `Citation`. Once all the citations are on the Rmd, the unction can be applied.
#'
#' @param file path to original file.
#' @param outfile path to output file.
#'
#' @return file.
#'
#' @examples
#' url_pmid("publication.Rmd", "publication.Rmd")
url_pmid <- function(file, outfile) {
    if (!file.exists(file)) stop("file doesn't exist, please check path.")
    bib <- readLines(file)
    ids <- sub(".*[PMCID: PMC]", "", bib)
    ids <- suppressWarnings(as.numeric(ids))
    ids <- na.omit(ids)
    ids <- unique(ids[nchar(ids) > 6])
    url <- paste0("http://www.ncbi.nlm.nih.gov/pmc/articles/pmc", ids, "/")
    names(url) <- ids
    # url <- unique(url)
    for (i in seq_along(url)) {
        id <- paste0("PMC", names(url)[i])
        replace <- paste0("[", id, "{blk}](", url[i], ")")
        bib <- gsub(id, replace, bib)
    }
    writeLines(bib, outfile)
}
## Usage:
file <- "content/en/about/publications.Rmd"
outfile <- "content/en/about/publications.Rmd"
url_pmid(file, outfile)

###############################################
## Utility to add Bullet point automatically ##
################################################
## Author: Daniela Cassol
## Last update: 26-Apr-2021
addbullet <- function(file, pattern, outfile) {
    if (!file.exists(file)) stop("file doesn't exist, please check path.")
    bib <- readLines(file)
    line <- which(stringr::str_detect(bib, pattern)) + 1
    new_bib <- bib[line:length(bib)]
    for (i in seq_along(new_bib)) {
        if (all(nchar(new_bib[i]) > 0 && !stringr::str_detect(new_bib[i], "#"))) {
            new_bib[i] <- paste0("- ", new_bib[i])
        } else if (nchar(new_bib[i]) < 0) {
            do <- "donothing"
        }
    }
    writeLines(c(bib[1:line], new_bib), outfile)
}

#pattern <- "## Publications related to this project"
pattern <- "### Journal publications"
file <- "content/en/about/publications.Rmd"
outfile <- "content/en/about/publications.Rmd"
addbullet(file, pattern, outfile)

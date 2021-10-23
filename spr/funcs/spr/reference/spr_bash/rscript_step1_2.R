#!/usr/bin/Rscript


load("./spr_bash/spr_wf.RData")
lapply(.loaded_pkgs, require, character.only = TRUE)

#step1
library(systemPipeR)


#step2
mapply(function(x, y) write.csv(x, y), split(iris, factor(iris$Species)), file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv")))


.loaded_pkgs <- .packages()
save.image("./spr_bash/spr_wf.RData")


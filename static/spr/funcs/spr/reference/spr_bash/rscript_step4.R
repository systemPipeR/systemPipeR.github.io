#!/usr/bin/Rscript


load("./spr_bash/spr_wf.RData")
lapply(.loaded_pkgs, require, character.only = TRUE)

#step4
df <- lapply(getColumn(sal, step = "gunzip", "outfiles"), function(x) read.delim(x, sep = ",")[-1])
df <- do.call(rbind, df)
stats <- data.frame(cbind(mean = apply(df[, 1:4], 2, mean), sd = apply(df[, 1:4], 2, sd)))
stats$species <- rownames(stats)
plot <- ggplot2::ggplot(stats, ggplot2::aes(x = species, y = mean, fill = species)) + ggplot2::geom_bar(stat = "identity", color = "black", position = ggplot2::position_dodge()) + ggplot2::geom_errorbar(ggplot2::aes(ymin = mean - sd, ymax = mean + sd), width = 0.2, position = ggplot2::position_dodge(0.9))


.loaded_pkgs <- .packages()
save.image("./spr_bash/spr_wf.RData")


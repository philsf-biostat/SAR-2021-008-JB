# setup -------------------------------------------------------------------
height <- 8
width <- 8
units <- "cm"

# publication ready tables ------------------------------------------------

# Don't need to version these files on git
# tab_inf %>%
#   as_gt() %>%
#   as_rtf() %>%
#   writeLines(con = "report/SAR-yyyy-NNN-XX-v01-T1.rtf")

# save plots --------------------------------------------------------------

# ggsave(filename = "figures/km-overall.png", plot = gg.overall$plot, height = height, width = width, units = units)
# ggsave(filename = "figures/km-sexo.png", plot = gg.sex, height = height, width = width, units = units)
ggsave(filename = "figures/sobrevida.png", plot = gg.surv, height = height, width = width, units = units)
ggsave(filename = "figures/tempo.png", plot = gg.tempos, height = height, width = width, units = units)

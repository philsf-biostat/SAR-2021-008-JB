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

ggsave(filename = "figures/sex.png", plot = gg.sex, height = height, width = width, units = units)

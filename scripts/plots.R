# setup -------------------------------------------------------------------
# library(ggplot2)
library(survminer)

ff.col <- "steelblue" # good for single groups scale fill/color brewer
ff.pal <- "Paired"    # good for binary groups scale fill/color brewer

# Theme setting (less is more)
theme_set(
  theme_classic()
)
theme_update(
  legend.position = "top"
)

# plots -------------------------------------------------------------------

# gg <- ggplot(analytical, aes(outcome, fill = group)) +
#   geom_density( alpha = .8) +
#   # scale_color_brewer(palette = ff.pal) +
#   scale_fill_brewer(palette = ff.pal) +
#   labs()

gg.overall <- sf.1 %>%
  ggsurvplot(
    palette = ff.pal,
    risk.table = TRUE,
    # cumevents = TRUE,
    # pval = TRUE,
    surv.median.line = "hv",
    # conf.int = TRUE,
  )

gg.sex <- sf.sexo %>%
  ggsurvplot(
    palette = ff.pal,
    risk.table = TRUE,
    # cumevents = TRUE,
    pval = TRUE,
    # surv.median.line = "hv",
    # conf.int = TRUE,
  )
gg.sex <- gg.sex$plot +
  theme_classic() +
  theme(legend.position = "top")

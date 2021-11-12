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

gg <- analytical %>%
  ggplot() +
  scale_color_brewer(palette = ff.pal) +
  scale_fill_brewer(palette = ff.pal)

# plots -------------------------------------------------------------------

# gg.overall <- sf.1 %>%
#   ggsurvplot(
#     palette = ff.pal,
#     risk.table = TRUE,
#     # cumevents = TRUE,
#     # pval = TRUE,
#     surv.median.line = "hv",
#     # conf.int = TRUE,
#   )
# 
# gg.sex <- sf.sexo %>%
#   ggsurvplot(
#     palette = ff.pal,
#     risk.table = TRUE,
#     # cumevents = TRUE,
#     pval = TRUE,
#     # surv.median.line = "hv",
#     # conf.int = TRUE,
#   )
# gg.sex <- gg.sex$plot +
#   theme_classic() +
#   theme(legend.position = "top")

gg.tempos <- gg +
  geom_boxplot(aes(sexo, tempo, fill = sexo)) +
  xlab(attr(analytical$sexo, "label")) +
  ylab(attr(analytical$tempo, "label")) +
  theme(legend.position = "none")

# EDA - não usada
# gg + geom_histogram(aes(tempo, fill = sexo), binwidth = 100) +
#   facet_wrap(~sexo) +
#   theme(legend.position = "none")

gg.surv <- surv_df %>%
  ggsurvplot_df(
    # config básica do plot
    surv.geom = geom_line,
    color = "sexo",
    linetype = "paricoes",
    # config extras (opcionais)
    # surv.median.line = "hv",
    # risk.table = TRUE,
    # conf.int = TRUE,
    # identificações
    xlab = "Tempo (dias)",
    ylab = "Sobrevida",
    surv.scale = "percent",
    # tema visual
    palette = ff.pal,
    ggtheme = theme_classic(),
  ) +
  theme(
    legend.text = element_text(size = 8),
    legend.title = element_text(size = 8),
    axis.text = element_text(size = 8),
    axis.title = element_text(size = 8),
  )

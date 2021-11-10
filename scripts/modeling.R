# setup -------------------------------------------------------------------
library(survival)
# library(moderndive)
# library(broom)
# library(broom.mixed)

# non-parametric ----------------------------------------------------------

sf.1 <- survfit(Surv(tempo, obito) ~ 1, analytical)
sf.sexo <- survfit(Surv(tempo, obito) ~ sexo, analytical)
# sf.f.birth <- survfit(Surv(tempo, obito) ~ paricoes, analytical %>% filter(sexo == "F"))

# parametric --------------------------------------------------------------

m.sexo <- survreg(Surv(tempo, obito) ~ sexo, analytical, dist = "weibull")
m.sexo.par <- survreg(Surv(tempo, obito)~ sexo + sexo:paricoes, analytical, dist = "weibull")

# cox ---------------------------------------------------------------------

# m.overall <- coxph(Surv(tempo, obito) ~ sexo, analytical)
# m.f.birth <- coxph(Surv(tempo, obito)~ sexo + sexo:paricoes, analytical)

# table -------------------------------------------------------------------

tab_sexo <- m.sexo %>%
  tbl_regression()
tab_sexo.par <- m.sexo.par %>%
  tbl_regression()

tab_mod <- tbl_merge(
  tbls = list(
    tab_sexo,
    tab_sexo.par
    ),
  tab_spanner = c("Ajustado por sexoo", "Ajustado por sexoo e número de parições")
  )

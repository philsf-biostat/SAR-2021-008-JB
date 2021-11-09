# setup -------------------------------------------------------------------
library(survival)
# library(moderndive)
# library(broom)
# library(broom.mixed)

# non-parametric ----------------------------------------------------------

sf.1 <- survfit(Surv(time, event) ~ 1, analytical)
sf.sex <- survfit(Surv(time, event) ~ sex, analytical)
# sf.f.birth <- survfit(Surv(time, event) ~ paricoes, analytical %>% filter(sex == "F"))

# parametric --------------------------------------------------------------

m.sex <- survreg(Surv(time, event) ~ sex, analytical, dist = "weibull")
m.sex.par <- survreg(Surv(time, event)~ sex + sex:paricoes, analytical, dist = "weibull")

# cox ---------------------------------------------------------------------

# m.overall <- coxph(Surv(time, event) ~ sex, analytical)
# m.f.birth <- coxph(Surv(time, event)~ sex + sex:paricoes, analytical)

# table -------------------------------------------------------------------

tab_sex <- m.sex %>%
  tbl_regression()
tab_sex.par <- m.sex.par %>%
  tbl_regression()

tab_mod <- tbl_merge(
  tbls = list(
    tab_sex,
    tab_sex.par
    ),
  tab_spanner = c("Ajustado por sexo", "Ajustado por sexo e número de parições")
  )

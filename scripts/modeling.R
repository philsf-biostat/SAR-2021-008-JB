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

m.overall <- survreg(Surv(time, event) ~ sex, analytical, dist = "weibull")
m.f.birth <- survreg(Surv(time, event) ~ paricoes, analytical %>% filter(sex == "F"), dist = "weibull")

# cox ---------------------------------------------------------------------

# m.overall <- coxph(Surv(time, event) ~ sex, analytical)
# m.f.birth <- coxph(Surv(time, event) ~ paricoes, analytical %>% filter(sex == "F"))

# table -------------------------------------------------------------------

tab_inf <- tbl_survfit(
  list(sf.1, sf.sex),
  probs = .5,
  label_header = "**Tempo de sobrevida (dias)**",
)

tab.overall <- m.overall %>%
  tbl_regression()
tab.f.birth <- m.f.birth %>%
  tbl_regression()

tab_mod <- tbl_stack(
  tbls = list(
    tab.overall,
    tab.f.birth
    ),
  group_header = c("Total", "Fêmeas"),
  )

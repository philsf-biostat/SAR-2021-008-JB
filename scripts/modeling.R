# setup -------------------------------------------------------------------
library(survival)
# library(moderndive)
# library(broom)
# library(broom.mixed)

# non-parametric ----------------------------------------------------------

# sf.1 <- survfit(Surv(tempo, obito) ~ 1, analytical)
# sf.sexo <- survfit(Surv(tempo, obito) ~ sexo, analytical)
# sf.f.birth <- survfit(Surv(tempo, obito) ~ paricoes, analytical %>% filter(sexo == "F"))

# parametric --------------------------------------------------------------

# m.sexo <- survreg(Surv(tempo, obito) ~ sexo, analytical, dist = "weibull")
# m.sexo.par <- survreg(Surv(tempo, obito)~ sexo + sexo:paricoes, analytical, dist = "weibull")

# cox ---------------------------------------------------------------------

m.sexo <- coxph(Surv(tempo, obito) ~ sexo, analytical)
m.sexo.par <- coxph(Surv(tempo, obito)~ sexo*paricoes, analytical)

newdat <- expand.grid(
  sexo = levels(analytical$sexo),
  paricoes = as.character(0:1)
  )
newdat <- newdat[-3, ]
rownames(newdat) <- c("M", "F:0", "F:1")

cxsf <- survfit(m.sexo.par, newdata = newdat, conf.type = "plain")
s <- summary(cxsf)$table[, 7:9]

# table -------------------------------------------------------------------

tab_sexo <- m.sexo %>%
  tbl_regression(exp = TRUE)
tab_sexo.par <- m.sexo.par %>%
  tbl_regression(exp = TRUE, include = c(sexo, paricoes))

tab_mod <- tbl_merge(
  tbls = list(
    tab_sexo,
    tab_sexo.par
    ),
  tab_spanner = c("**Ajustado por sexo**", "**Ajustado por sexo e número de parições**")
  )

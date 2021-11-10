# setup -------------------------------------------------------------------
library(survminer)

# tables ------------------------------------------------------------------

# tab_inf <- tbl_survfit(
#   list(sf.1, sf.sexo),
#   probs = .5,
#   label_header = "**Tempo de sobrevida (dias)**",
# )

# newdat <- expand.grid(sexo = levels(analytical$sexo), paricoes = as.character(0:1))[-3, ]
# cxsf <- survfit(m.sexo.par, data = analytical, conf.type = "plain", newdata = newdat)

surv_cxsf <- surv_summary(cxsf, data = analytical) %>% tibble()

m_newdat <- newdat[as.character(surv_cxsf$strata), ]
surv_df <- cbind(surv_cxsf, m_newdat)

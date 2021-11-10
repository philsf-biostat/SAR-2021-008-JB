# setup -------------------------------------------------------------------
# library(tableone)
# library(gt)
# library(gtsummary)
# library(infer)

# tables ------------------------------------------------------------------

tab_inf <- tbl_survfit(
  list(sf.1, sf.sexo),
  probs = .5,
  label_header = "**Tempo de sobrevida (dias)**",
)

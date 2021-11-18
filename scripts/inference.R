# setup -------------------------------------------------------------------
library(survminer)

# tables ------------------------------------------------------------------

tab_inf <- tbl_survfit(
    list(cxsf),
    probs = .5,
    label_header = "**Tempo de meia-vida (dias)**",
  ) %>%
  bold_labels() %>%
  suppressWarnings()

# tab_inf$meta_data$table_body[[1]] <- tab_inf$meta_data$table_body[[1]] %>%
#   unnest(stat_1) %>%
#   mutate(variable = "sexo", label = rownames(newdat))

## Corrigir os levels
tab_inf$table_body <- tab_inf$table_body %>%
  as_tibble() %>%
  unnest(stat_1) %>%
  mutate(
    variable = "sexo",
    var_label = "Sexo",
    row_type = "level",
    label = rownames(newdat),
    )

## incluir o label
tab_inf$table_body <- bind_rows(
  tibble(variable = "sexo", var_label = "Sexo", row_type = "label", label = "Sexo:Número de parições", stat_1 = NA),
  tab_inf$table_body
  )

tab_inf

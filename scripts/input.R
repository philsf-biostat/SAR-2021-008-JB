# setup -------------------------------------------------------------------
# library(data.table)
library(tidyverse)
library(readxl)
library(lubridate)
library(labelled)

# data loading ------------------------------------------------------------
set.seed(42)
# data.raw <- tibble(id=gl(2, 10), group = gl(2, 10), outcome = rnorm(20))
data.raw <- read_excel("dataset/Planilha bahiensis.xlsx") %>%
  janitor::clean_names()

# data cleaning -----------------------------------------------------------

data.raw <- data.raw %>%
  rownames_to_column("id") %>%
  rename(entrada_d = entrada, obito_d = obito) %>%
  filter() %>%
  select(
    -especime,
  )

# data wrangling ----------------------------------------------------------

data.raw <- data.raw %>%
  mutate(
    obito = 1,
    tempo = as.duration(interval(entrada_d, obito_d))/ddays(),
    sexo = factor(sexo, labels = c("F", "M")),
    sexo = relevel(sexo, "M"),
  )

# labels ------------------------------------------------------------------

data.raw <- data.raw %>%
  set_variable_labels(
    tempo = "Tempo até o óbito (dias)",
    sexo = "Sexo",
    paricoes = "Número de parições",
  )

# analytical dataset ------------------------------------------------------

analytical <- data.raw %>%
  # select analytic variables
  select(
    id,
    obito,
    tempo,
    sexo,
    paricoes,
  )

# mockup of analytical dataset for SAP and public SAR
analytical_mockup <- tibble( id = c( "1", "2", "3", "...", as.character(nrow(analytical)) ) ) %>%
  left_join(analytical %>% head(0), by = "id") %>%
  mutate_all(as.character) %>%
  replace(is.na(.), "")

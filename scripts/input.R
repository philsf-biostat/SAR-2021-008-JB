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
  rename(sex = sexo) %>%
  filter() %>%
  select(
    -especime,
  )

# data wrangling ----------------------------------------------------------

data.raw <- data.raw %>%
  mutate(
    event = 1,
    time = as.duration(interval(entrada, obito))/ddays(),
    sex = factor(sex, labels = c("F", "M")),
    sex = relevel(sex, "M"),
  )

# labels ------------------------------------------------------------------

data.raw <- data.raw %>%
  set_variable_labels(
    time = "Time to death (days)",
    sex = "Sex",
    paricoes = "Number of births",
  )

# analytical dataset ------------------------------------------------------

analytical <- data.raw %>%
  # select analytic variables
  select(
    id,
    event,
    time,
    sex,
    paricoes,
  )

# mockup of analytical dataset for SAP and public SAR
analytical_mockup <- tibble( id = c( "1", "2", "3", "...", as.character(nrow(analytical)) ) ) %>%
  left_join(analytical %>% head(0), by = "id") %>%
  mutate_all(as.character) %>%
  replace(is.na(.), "")

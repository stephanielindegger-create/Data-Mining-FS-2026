library(tidyverse)
library(dplyr)

eval_keywords <- readRDS("data_raw/dat_keywords_long.rds")

#show each keyword in alphabetical order
all_keywords <- eval_keywords %>%
                distinct(additionalIndexing) %>%
                arrange(additionalIndexing)

keywords_democracy <- c(
  "Staatspolitik",
  "Volksrecht",
  "Volksinitiative",
  "politische Rechte",
  "politische Mitbestimmung",
  "politische Kultur",
  "Abstimmungstermin",
  "Stimm- und Wahlrecht",
  "Bundesratswahl",
  "Ständeratswahl",
  "passives Wahlrecht",
  "erleichterte Stimmabgabe",
  "fakultatives Referendum",
  "Quorum bei Volksinitiative",
  "Gültigkeit einer Volksinitiative",
  "Titel von Volksinitiative",
  "Kandidatenaufstellung",
  "Parlamentsreform",
  "Wahllokal",
  "Parlament",
  "Mitwirkung des Parlaments",
  "parlamentarische Kontrolle",
  "parlamentarische Untersuchung"
)

eval_keywords_democracy <- eval_keywords |>
  filter(str_detect(additionalIndexing, paste(keywords_democracy, collapse = "|"))) |>
  select(id, shortId, title, additionalIndexing)

saveRDS(eval_keywords_democracy, "data_preprocessed/eval_keywords_democracy.rds")

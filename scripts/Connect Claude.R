library(httr)
library(jsonlite)

democracy_affairs <- readRDS("data_preprocessed/eval_keywords_democracy.rds")

# API Key setzen
api_key <- Sys.getenv("ANTHROPIC_API_KEY")

# Funktion um Claude zu fragen
ask_claude <- function(prompt) {
  response <- POST(
    url = "https://api.anthropic.com/v1/messages",
    add_headers(
      "x-api-key" = api_key,
      "anthropic-version" = "2023-06-01",
      "content-type" = "application/json"
    ),
    body = toJSON(list(
      model = "claude-haiku-4-5-20251001",
      max_tokens = 50,
      messages = list(
        list(role = "user", content = prompt)
      )
    ), auto_unbox = TRUE)
  )

  content(response)$content[[1]]$text
}

library(tidyverse)
#setting up instructions for Claude
classify_affair <- function(title, additionalIndexing) {
    prompt <- paste0(
    "Classification of parliamentary affairs.\n",
    "Title: ", title, "\n",
    "additionalIndexing: ", additionalIndexing, "\n\n",
    "Is this affair addressing any security issues? ",
    "Answer ONLY with: 'No' OR 'Yes: [security issue]'\n",
    "No explanations, no markdown, no additional text."
    )
    result <- tryCatch({
      ask_claude(prompt)
    }, error = function(e) {
      cat("Error at title:", title, "\n")
      NA_character_  # gibt NA zurück statt abzubrechen
    })

    # Falls leere Antwort
    if (length(result) == 0) return(NA_character_)

    result
}


#for affairs
classification_results <- map2_chr(
  democracy_affairs$title,
  democracy_affairs$additionalIndexing,
  classify_affair
)

democracy_security_affairs <- tibble(
  title                 = democracy_affairs$title,
  additionalIndexierung = democracy_affairs$additionalIndexing,
  id                    = democracy_affairs$id,
  classification        = classification_results
  ) %>%
  mutate(
    answer         = if_else(str_starts(classification, "Yes"), "Yes", "No"),
    security_issue = if_else(str_starts(classification, "Yes"),
                             str_remove(classification, "Yes: "),
                             NA_character_)
  )

saveRDS(democracy_security_affairs, "data_preprocessed/democracy_security_affairs.rds")


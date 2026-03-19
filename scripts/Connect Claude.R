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
      max_tokens = 1024,
      messages = list(
        list(role = "user", content = prompt)
      )
    ), auto_unbox = TRUE)
  )

  content(response)$content[[1]]$text
}

#setting up instructions for Claude
classify_affair <- function(title, additionalIndexing) {
    prompt <- paste0(
    "Classification of parliamentary affairs.\n",
    "Title: ", title, "\n",
    "additionalIndexing: ", additionalIndexing, "\n\n",
    "Is this affair addressing any security issues? ",
    "Answer with: Yes or No, if yes, identify the corresponding security issue"
    )
  ask_claude(prompt)
}

#test for 1 affair
classify_affair(democracy_affairs$title[1], democracy_affairs$additionalIndexing[1])


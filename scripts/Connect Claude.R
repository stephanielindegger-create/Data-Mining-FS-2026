library(httr)
library(jsonlite)

# API Key setzen
api_key <- Sys.getenv("ANTHROPIC_API_KEY")

nchar(api_key) > 0

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


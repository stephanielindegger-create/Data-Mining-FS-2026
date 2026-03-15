library(httr)
library(tidyverse)
library(xml2)

#load data if necessary
exists("eval_keywords_democracy")
dat_all <- readRDS("data_preprocessed/eval_keywords_democracy.rds")
nrow(dat_all)
head(dat_all)

#list to store text accessed through keywords
all_access_texts <- list()

#for loop to access text from affairs about democracy:
for (i in 1:1) {
  id <- eval_keywords_democracy$id[i]
  url <- paste0("https://ws-old.parlament.ch/affairsummaries", id, "?format=xml")

  tryCatch({
    response <- GET(url) #if an error occurs, the obtained data is kept and a restart not necessary
    doc_keywords <- content(response, as = "parsed", encoding = "UTF-8") #read content
    cat(as.character(doc_keywords)) #to see what content looks like

    #build tibble
    dat_detail_text <- tibble(
      id                 = xml_text(xml_find_first(doc_keywords, "//id")),
      shortId            = xml_text(xml_find_first(doc_keywords, "//shortId")),
      title              = xml_text(xml_find_first(doc_keywords, "//title")),
      Description        = xml_text(xml_find_first(doc_keywords, "//sescription"))
      InitialSituation   = xml_text(xml_find_first(doc_keywords, "//initialsituation"))
    )

    all_access_texts[[i]] <- dat_detail_text

  }, error = function(e) {
    cat("Error at i =", i, "ID:", id, "-", conditionMessage(e), "\n")
  }) #identification of which affair caused an issue to assess later

  Sys.sleep(0.1)
  cat("Fetched", i, "of", nrow(dat_all), "\n")
} #putting the server to sleep to avoid being cut off

# add all iterations
dat_text <- bind_rows(all_access_texts)


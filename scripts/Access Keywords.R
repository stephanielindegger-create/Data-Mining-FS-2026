library(httr)
library(tidyverse)
library(xml2)

#load data if necessary
exists("dat_all")
dat_all <- readRDS("data_raw/all_affairs.rds")
nrow(dat_all)
head(dat_all)

#list to store keywords accessed through ids
all_access_keywords <- list()

#for loop to access keyword from all affair:
for (i in seq_len(nrow(dat_all)) {
  id <- dat_all$id[i]
  url <- paste0("https://ws-old.parlament.ch/affairs/", id, "?format=xml")
  response <- GET(url)

doc_keywords <- content(response, as = "parsed", encoding = "UTF-8") #read content
cat(as.character(doc_keywords)) #to see what content looks like

#build tibble
dat_detail <- tibble(
  id                 = xml_text(xml_find_first(doc_keywords, "//id")),
  shortId            = xml_text(xml_find_first(doc_keywords, "//shortId")),
  title              = xml_text(xml_find_first(doc_keywords, "//title")),
  additionalIndexing = xml_text(xml_find_first(doc_keywords, "//additionalIndexing"))
)

all_access_keywords[[i]] <- dat_detail
}

# add all iterations
dat_keywords <- bind_rows(all_access_keywords)

# change to long format to be able to access each single keyword
dat_keywords_long <- dat_keywords |>
  mutate(additionalIndexing = str_remove(additionalIndexing, "freie Schlagwörter: ")) |>
  separate_rows(additionalIndexing, sep = ", ")

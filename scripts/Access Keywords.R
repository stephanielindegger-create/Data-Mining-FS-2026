library(httr)

#load data if necessary
exists("dat_all")
dat_all <- readRDS("data_raw/all_affairs.rds")
nrow(dat_all)
head(dat_all)

#list to store keywords accessed through ids
all_access_keywords <- list()

#for loop to access keyword from 1 affair:
for (i in 1:1) {
  id <- dat_all$id[i]
  url <- paste0("https://ws-old.parlament.ch/affairs/", id, "?format=xml")
  response <- GET(url) }

doc_keywords <- content(response, as = "parsed", encoding = "UTF-8") #read content
cat(as.character(doc_keywords)) #to see what content looks like

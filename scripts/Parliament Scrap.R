library(tidyverse)
library(httr)
library(rvest)
library(xml2)

# Parameters for pagination
pageSize <- 1000     # number of records per page
nPages <- 1315   # total number of pages
all_affairs <- list() # to store each page

# Loop over all pages, put all pages together
for (i in 1:nPages) {
  url <- paste0(
    "https://ws-old.parlament.ch/affairs?format=xml",
    "&pageNumber=", i,
    "&pageSize=", pageSize
  )

#Get Data about ID of parliamentary affairs
response <- GET(url)


#read content
doc <- content(response, as = "parsed", encoding = "UTF-8")
  affairs <- xml_find_all(doc, "//affair")
  length(affairs) #to double check entries 1315 with each approximately 50 entries


#build tibble (create dataframe to directly access id)
  dat <- tibble(
    id = map_chr(affairs, ~ xml_text(xml_find_first(.x, "./id"))),
    shortId = map_chr(affairs, ~ xml_text(xml_find_first(.x, "./shortId"))),
    title = map_chr(affairs, ~ xml_text(xml_find_first(.x, "./title"))),
    updated = map_chr(affairs, ~ xml_text(xml_find_first(.x, "./updated")))
  )

# Store page in list
  all_affairs[[i]] <- dat

# Progress message
  cat("Page", i, "fetched with", nrow(dat), "records\n")
}

# Combine all pages into a single tibble, to access ID
dat_all <- bind_rows(all_affairs)


# save file
saveRDS(dat_all, "all_affairs.rds")


library(httr)
library(tidyverse)
library(xml2)

#load data if necessary
exists("eval_keywords_democracy")
dat_all <- readRDS("data_preprocessed/eval_keywords_democracy.rds")
nrow(dat_all)
head(dat_all)

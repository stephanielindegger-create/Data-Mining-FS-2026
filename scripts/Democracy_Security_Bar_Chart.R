


chart_data <- readRDS("data_preprocessed/democracy_security_affairs.rds")

#prep input: Yes, No, NA (because may affairs rendered NA)
bar_chart_input <- chart_data$classification %>%
  mutate(answer = replace_na(answer, "NA")) %>%
  count(answer)

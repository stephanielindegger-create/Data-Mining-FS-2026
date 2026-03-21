library(ggplot2)

chart_data_2 <- readRDS("data_preprocessed/democracy_security_affairs.rds")

#prep input: Yes, No, NA (because may affairs rendered NA)
horizontal_chart_input <- chart_data_2 %>%
  mutate(answer = replace_na(answer, "NA")) %>%
  mutate(answer = factor(answer, levels = c("No", "Yes", "NA"))) %>%
  count(answer)

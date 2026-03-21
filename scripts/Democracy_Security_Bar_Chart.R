library(ggplot2)

chart_data <- readRDS("data_preprocessed/democracy_security_affairs.rds")

#prep input: Yes, No, NA (because may affairs rendered NA)
bar_chart_input <- chart_data %>%
  mutate(answer = replace_na(answer, "NA")) %>%
  mutate(answer = factor(answer, levels = c("Yes", "No", "NA"))) %>%
  count(answer)

#bar chart set up
ggplot(bar_chart_input, aes(x = answer, y = n, fill = answer)) +
  geom_bar(stat = "identity")+
  scale_fill_manual(values = c(
    "Yes" = "red",
    "No"  = "steelblue",
    "NA"  = "grey"
  )) +
  labs(
  title = "Security Issues in Democratic Affairs of the Swiss Parliament",
  x     = "Classification",
  y     = "Number of Affairs"
)
  theme_minimal()

library(ggplot2)

chart_data_2 <- readRDS("data_preprocessed/democracy_security_affairs.rds")


#understanding results
unique(chart_data_2$security_issue)

#group affairs according to theme
democracy_security_category <- chart_data_2 %>%
  mutate(security_category = case_when(
    str_detect(security_issue, regex("migr|Zuwanderung|Ausländer|border|immigration", ignore_case = TRUE)) ~ "Migration",
    str_detect(security_issue, regex("innere Sicherheit|Staatsschutz|Telefon|Drogen|polizei|public order", ignore_case = TRUE)) ~ "Internal Security",
    str_detect(security_issue, regex("NATO|militar|international|nuclear|Waffen|Russia", ignore_case = TRUE)) ~ "International Security / Military",
    str_detect(security_issue, regex("corrupt|financial|banking|pension|procurement", ignore_case = TRUE)) ~ "Corruption / Finance",
    str_detect(security_issue, regex("parliament|investigation|accountability|referendum|control", ignore_case = TRUE)) ~ "Parliamentary Control",
    str_detect(security_issue, regex("Rassen|Antisem|social|gesellschaft", ignore_case = TRUE)) ~ "Social Security",
    answer == "No" ~ "No Security Issue",
    TRUE ~ NA_character_
  ))

#filter out No and NA
democracy_security_horizontal_bar_chart <- democracy_security_category %>%
  filter(answer == "Yes") %>%
  count(security_category, sort = TRUE)  %>%


#horizontal bar chart set up
ggplot(democracy_security_horizontal_bar_chart, aes(x = n, y = reorder(security_category, n), fill = security_category)) +
    geom_bar(stat = "identity") +
labs(
  title = "Security Issues in Democratic Affairs of the Swiss Parliament",
  x     = "Number of Affairs",
  y     = "Security Issue"
) +
theme_minimal() +
theme(legend.position = "none")

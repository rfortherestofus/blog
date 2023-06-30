library(tidyverse)
library(hrbrthemes)
library(ggtext)

iris %>% 
  group_by(Species) %>% 
  summarize(mean_petal_width = mean(Petal.Width)) %>% 
  ungroup() %>% 
  ggplot(aes(Species, mean_petal_width)) +
  geom_col() +
  theme_ipsum() +
  labs(x = NULL,
       y = NULL,
       title = "Average petal width of irises by species")

ggsave("ggtext/plot-bad-title.png")

iris %>% 
  group_by(Species) %>% 
  summarize(mean_petal_width = mean(Petal.Width)) %>% 
  ungroup() %>% 
  ggplot(aes(Species, mean_petal_width,
             fill = Species)) +
  geom_col(show.legend = FALSE) +
  theme_ipsum() +
  scale_fill_manual(values = c("setosa" = "lightgray",
                               "versicolor" = "lightgray",
                               "virginica" = "red")) +
  labs(x = NULL,
       y = NULL,
       title = "<span style = 'color: red;'>Virginica irises</span> have the largest average sepal width") +
  theme(plot.title = element_markdown())

ggsave("ggtext/plot-using-ggtext.png")

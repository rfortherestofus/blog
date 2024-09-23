library(tidyverse)
library(gapminder)
library(scales)



gdp_data <-
  gapminder |>
  filter(country %in% c("Japan", "Australia")) |>
  filter(year >= 1982) |>
  select(year, country, gdpPercap)


gdp_line_chart <-
  ggplot() +
  geom_line(
    data = gdp_data,
    aes(
      x = year,
      y = gdpPercap,
      color = country
    ),
    size = 1.2
  ) +
  labs(
    title = "GDP Per Capita Comparison: Australia vs Japan",
    subtitle = "Area between the lines is highlighted for the years 2002-2007",
    x = NULL,
    y = "GDP Per Capita",
    caption = "Source: Gapminder"
  ) +
  scale_y_continuous(labels = dollar_format(
    accuracy = 1,
    scale = 1 / 1000,
    suffix = "K"
  )) +
  scale_color_manual(
    values = c(
      "black",
      "grey70"
    )
  ) +
  theme_minimal() +
  theme(
    axis.title = element_blank()
  )

gdp_line_chart



highlight_data <-
  gdp_data |>
  filter(year > 2000 & year < 2010)

highlight_data_wide <-
  highlight_data |>
  pivot_wider(
    names_from = country,
    values_from = gdpPercap
  )


gdp_line_chart +
  geom_ribbon(
    data = highlight_data_wide,
    aes(
      x = year,
      ymin = Japan,
      ymax = Australia
    ),
    fill = "#af7d95",
    alpha = 0.8
  )



max_australia <- gdp_data |>
  filter(country == "Australia") |>
  slice_max(gdpPercap, n = 1) |>
  pull(gdpPercap)

max_japan <- gdp_data |>
  filter(country == "Japan") |>
  slice_max(gdpPercap, n = 1) |>
  pull(gdpPercap)

difference <- max_australia - max_japan

gap_label <- str_glue("{scales::dollar(difference, accuracy = 1)}\ngap")


plot_with_annotation <-
  gdp_line_chart +
  geom_ribbon(
    data = highlight_data_wide,
    aes(
      x = year,
      ymin = Japan,
      ymax = Australia
    ),
    fill = "#af7d95",
    alpha = 0.8
  ) +
  annotate(
    geom = "line",
    x = 2007.5,
    y = c(max_australia, max_japan)
  ) +
  annotate(
    geom = "text",
    x = 2008,
    y = max_japan + difference / 2,
    label = gap_label,
    lineheight = 1,
    label.size = 0,
    hjust = 0
  ) +
  scale_x_continuous(
    limits = c(1980, 2010)
  )

library(geomtextpath)


plot_with_annotation +
  geom_textpath(
    data = gdp_data,
    aes(
      x = year,
      y = gdpPercap,
      color = country,
      label = country
    ),
    vjust = -0.5
  ) +
  theme(legend.position = "none")

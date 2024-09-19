library(tidyverse)
library(gapminder)


gdp_data <-
  gapminder |>
  filter(year == 2007) |>
  select(
    country,
    gdpPercap
  ) |>
  mutate(country = fct_reorder(
    country,
    gdpPercap
  )) |>
  arrange(desc(gdpPercap)) |>
  slice(1:15)


ggplot(
  gdp_data,
  aes(
    x = gdpPercap,
    y = country
  )
) +
  geom_col()


ggplot(
  gdp_data,
  aes(
    x = gdpPercap,
    y = country
  )
) +
  geom_col() +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )


ggplot(
  gdp_data,
  aes(
    x = gdpPercap,
    y = country
  )
) +
  geom_col() +
  geom_vline(
    xintercept = seq(
      from = 10000,
      to = 50000,
      by = 10000
    ),
    color = "white"
  ) +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )


ggplot(
  gdp_data,
  aes(
    x = gdpPercap,
    y = country
  )
) +
  geom_col(fill = "#6cabdd") +
  geom_vline(
    xintercept = seq(
      10000,
      50000,
      by = 10000
    ),
    color = "white"
  ) +
  scale_x_continuous(
    expand = expansion(add = 500),
    labels = scales::dollar_format(scale = 1 / 1000, suffix = "k")
  ) +
  labs(
    x = NULL,
    y = NULL,
    title = "GDP Per Capita (2007)",
    caption = "Source: Gapminder"
  ) +
  theme_minimal(
    base_family = "Roboto",
    base_size = 14
  ) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    plot.caption = element_text(
      size = 10,
      color = "#7f8c8d",
      hjust = 0,
      margin = margin(t = 15)
    )
  )


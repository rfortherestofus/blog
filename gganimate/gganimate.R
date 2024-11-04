library(refugees)

population

library(tidyverse)

refugees_data <-
  read_rds("https://github.com/rfortherestofus/blog/raw/refs/heads/main/gganimate/refugees_data.rds")

refugees_data

library(scales)
library(hrbrthemes)
library(gganimate)

refugees_data |>
  filter(country_abbreviation == "SYR") |>
  ggplot(
    aes(
      x = year,
      y = refugees_as_pct
    )
  ) +
  geom_line() +
  scale_y_continuous(
    labels = percent_format()
  ) +
  labs(
    x = NULL,
    y = NULL,
    title = "The refugee population in Syria increased\ndramatically as a result of its civil war"
  ) +
  theme_ipsum_inter(base_size = 12) +
  theme(panel.grid.minor = element_blank())


syria_refugees_plot <- last_plot()

syria_refugees_plot +
  transition_reveal(year)

library(sf)



countries_data <-
  read_sf("https://github.com/rfortherestofus/blog/raw/refs/heads/main/gganimate/countries_data.geojson")



countries_data



middle_east_refugees_data <-
  countries_data |>
  left_join(
    refugees_data,
    join_by(country_abbreviation)
  ) |>
  filter(subregion == "Western Asia") |>
  select(year, country_abbreviation, refugees_as_pct)

middle_east_refugees_data

middle_east_refugees_data |>
  ggplot() +
  geom_sf(
    aes(fill = refugees_as_pct),
    linewidth = 0.1,
    color = "white"
  ) +
  scale_fill_viridis_c(
    labels = percent_format(),
    limits = c(0, .4),
    option = "C",
    guide = guide_colorsteps(show.limits = TRUE)
  ) +
  labs(
    title = "Refugees as a percentage of total population",
    fill = NULL
  ) +
  theme_ipsum_inter(
    grid = FALSE
  ) +
  theme(
    legend.position = "top",
    plot.title = element_text(
      face = "bold",
      hjust = 0.5
    ),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    legend.key.width = unit(2, "cm"),
    legend.text = element_text(
      size = 12
    )
  )



middle_east_refugees_map <- last_plot()


middle_east_refugees_map +
  facet_wrap(vars(year))

middle_east_refugees_map +
  transition_manual(year)


middle_east_refugees_map +
  labs(title = "Refugees as a percentage of total population in {current_frame}") +
  transition_manual(year)


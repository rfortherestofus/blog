
library(tidyverse)

housing_cost_burden <-
  read_rds("https://github.com/rfortherestofus/blog/raw/refs/heads/main/hide-small-values/housing_cost_burden.rds")

housing_cost_burden

housing_cost_burden |>
  filter(location %in% c(
    "Hartford",
    "Hartford County",
    "Connecticut"
  )) |>
  ggplot(
    aes(
      x = pct,
      y = location,
      fill = burden_level,
      label = pct_formatted
    )
  ) +
  geom_col() +
  geom_text(
    position = position_stack(vjust = 0.5),
    size = 10,
    fontface = "bold",
    color = "white"
  )


housing_cost_burden |>
  filter(location %in% c(
    "Hartford",
    "Hartford County",
    "Connecticut"
  )) |>
  ggplot(
    aes(
      x = pct,
      y = location,
      fill = burden_level,
      label = pct_formatted
    )
  ) +
  geom_col() +
  geom_text(
    position = position_stack(vjust = 0.5),
    size = 10,
    fontface = "bold",
    color = "white"
  ) +
  scale_fill_manual(
    name = "",
    values = c(
      "Severe burden" = "#266045",
      "Moderate burden" = "#73ae90",
      "Not burdened" = "#b5b5b5",
      "Not computed" = "#d6d6d6"
    ),
    guide = guide_legend(reverse = TRUE)
  ) +
  scale_x_continuous(expand = expansion(0, 0)) +
  labs(
    fill = NULL,
    title = "Housing cost burden for renters"
  ) +
  theme_void(base_size = 13) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(
      face = "bold"
    ),
    axis.text.y = element_text(
      hjust = 1,
      margin = margin(r = 10)
    )
  )


housing_cost_burden_plot <- function(df, town_to_plot, county_to_plot) {
  df |>
    filter(location %in% c(
      town_to_plot,
      county_to_plot,
      "Connecticut"
    )) |>
    ggplot(
      aes(
        x = pct,
        y = location,
        fill = burden_level,
        label = pct_formatted
      )
    ) +
    geom_col() +
    geom_text(
      position = position_stack(vjust = 0.5),
      size = 10,
      fontface = "bold",
      color = "white"
    ) +
    scale_fill_manual(
      name = "",
      values = c(
        "Severe burden" = "#266045",
        "Moderate burden" = "#73ae90",
        "Not burdened" = "#b5b5b5",
        "Not computed" = "#d6d6d6"
      ),
      guide = guide_legend(reverse = TRUE)
    ) +
    scale_x_continuous(expand = expansion(0, 0)) +
    labs(
      fill = NULL,
      title = "Housing cost burden for renters"
    ) +
    theme_void(base_size = 13) +
    theme(
      legend.position = "bottom",
      plot.title = element_text(
        face = "bold"
      ),
      axis.text.y = element_text(
        hjust = 1,
        margin = margin(r = 10)
      )
    )
}



housing_cost_burden_plot(
  df = housing_cost_burden,
  town_to_plot = "Hartford",
  county_to_plot = "Hartford County"
)



housing_cost_burden_2 <-
  housing_cost_burden |>
  mutate(pct_formatted = if_else(pct > 0.07, pct_formatted, NA))

housing_cost_burden_2


housing_cost_burden_plot(
  df = housing_cost_burden_2,
  town_to_plot = "Hartford",
  county_to_plot = "Hartford County"
)


housing_cost_burden_plot(
  df = housing_cost_burden_2,
  town_to_plot = "Stamford",
  county_to_plot = "Fairfield County"
)

housing_cost_burden_plot(
  df = housing_cost_burden_2,
  town_to_plot = "Woodstock",
  county_to_plot = "Windham County"
)

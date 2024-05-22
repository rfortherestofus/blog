
library(tidyverse)
library(scales)

median_income <-
  read_csv("https://raw.githubusercontent.com/rfortherestofus/blog/main/set-consistent-limits/median_income.csv")

median_income










median_income_plot <- function(county) {
  median_income |>
    filter(geography %in% c(county, "Oregon")) |>
    mutate(geography = fct(geography, levels = c("Oregon", county))) |>
    ggplot(
      aes(
        x = amount,
        y = geography,
        label = amount_formatted,
        fill = geography
      )
    ) +
    geom_col(show.legend = FALSE) +
    geom_text(
      color = "white",
      hjust = 1.2,
      size = 8
    ) +
    geom_text(
      aes(
        x = 2000,
        label = geography
      ),
      color = "white",
      hjust = 0,
      size = 8
    ) +
    scale_fill_manual(values = c(
      "gray",
      "darkgreen"
    )) +
    theme_void()
}

median_income_plot("Jackson")

median_income_plot("Harney")

median_income_plot("Washington")



max_median_income <-
  median_income |>
  slice_max(
    order_by = amount,
    n = 1
  ) |>
  pull(amount)

max_median_income

scale_x_continuous(
  limits = c(0, max_median_income)
)


median_income_plot_v2 <- function(county) {
  max_median_income <-
    median_income |>
    slice_max(
      order_by = amount,
      n = 1
    ) |>
    pull(amount)

  median_income |>
    filter(geography %in% c(county, "Oregon")) |>
    mutate(geography = fct(geography, levels = c("Oregon", county))) |>
    ggplot(
      aes(
        x = amount,
        y = geography,
        label = amount_formatted,
        fill = geography
      )
    ) +
    geom_col(show.legend = FALSE) +
    geom_text(
      color = "white",
      hjust = 1.2,
      size = 8
    ) +
    geom_text(
      aes(
        x = 2000,
        label = geography
      ),
      color = "white",
      hjust = 0,
      size = 8
    ) +
    scale_fill_manual(values = c(
      "gray",
      "darkgreen"
    )) +
    theme_void() +
    scale_x_continuous(
      limits = c(0, max_median_income)
    )
}



median_income_plot_v2("Jackson")

median_income_plot_v2("Harney")

median_income_plot_v2("Washington")


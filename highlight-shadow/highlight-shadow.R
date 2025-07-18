library(tidyverse)
library(sf)

rubella <-
  read_sf("https://github.com/rfortherestofus/blog/raw/refs/heads/main/highlight-shadow/rubella.geojson")

rubella

rubella_region_0 <-
  rubella |>
  filter(region == 0)

ggplot() +
  geom_sf(
    data = rubella_region_0,
    fill = "grey90",
    color = "grey70",
    linewidth = 0.2
  )

rubella |>
  st_drop_geometry() |>
  filter(region == 1) |>
  count(status)

rubella_region_1 <-
  rubella |>
  filter(region == 1) |>
  add_row(status = "Re-established") |>
  mutate(status = fct(
    status,
    levels = c(
      "Achieved",
      "Re-established",
      "Not achieved",
      "No data"
    )
  ))

rubella_region_1 |>
  st_drop_geometry() |>
  count(status)

ggplot() +
  geom_sf(
    data = rubella_region_1,
    aes(fill = status),
    linewidth = 0.2,
    color = "white",
    alpha = 1
  )


ggplot() +
  geom_sf(
    data = rubella_region_0,
    fill = "grey90",
    color = "grey70",
    linewidth = 0.2
  ) +
  geom_sf(
    data = rubella_region_1,
    aes(fill = status),
    linewidth = 0.2,
    color = "white"
  )

ggplot() +
  geom_sf(
    data = rubella_region_0,
    fill = "grey90",
    color = "grey70",
    linewidth = 0.2
  ) +
  geom_sf(
    data = rubella_region_1,
    aes(fill = status),
    linewidth = 0.2,
    color = "white"
  ) +
  scale_fill_manual(
    name = "",
    values = c(
      "Achieved" = "navy",
      "Re-established" = "gold1",
      "Not achieved" = "red2",
      "No data" = "grey80"
    )
  )

ggplot() +
  geom_sf(
    data = rubella_region_0,
    fill = "grey90",
    color = "grey70",
    linewidth = 0.2
  ) +
  geom_sf(
    data = rubella_region_1,
    aes(fill = status),
    linewidth = 0.2,
    color = "white"
  ) +
  scale_fill_manual(
    name = "",
    values = c(
      "Achieved" = "navy",
      "Re-established" = "gold1",
      "Not achieved" = "red2",
      "No data" = "grey80"
    )
  ) +
  theme_void(base_family = "Inter Tight") +
  theme(
    legend.text = element_text(
      size = 12,
      color = "grey40"
    ),
    plot.margin = margin(rep(20, 4)),
    legend.position = "bottom"
  )

region_map <- function() {
  ggplot() +
    geom_sf(
      data = rubella_region_0,
      fill = "grey90",
      color = "grey70",
      linewidth = 0.2
    ) +
    geom_sf(
      data = rubella_region_1,
      aes(fill = status),
      linewidth = 0.2,
      color = "white"
    ) +
    scale_fill_manual(
      name = "",
      values = c(
        "Achieved" = "navy",
        "Re-established" = "gold1",
        "Not achieved" = "red2",
        "No data" = "grey80"
      )
    ) +
    theme_void(base_family = "Inter Tight") +
    theme(
      legend.text = element_text(
        size = 12,
        color = "grey40"
      ),
      plot.margin = margin(rep(20, 4)),
      legend.position = "bottom"
    )
}

region_map()

library(ggfx)

region_map() +
  with_shadow(
    geom_sf(
      data = rubella |> 
        filter(country == "Afghanistan"),
      aes(fill = status),
    ),
    sigma = 0,
    x_offset = 4,
    y_offset = 4
  )

region_map() +
  with_shadow(
    geom_sf(
      data = rubella |> filter(country == "Afghanistan"),
      aes(fill = status),
      linewidth = 0.8,
      color = "white"
    ),
    sigma = 0,
    x_offset = 4,
    y_offset = 4
  )

region_map <- function(opacity_level = 1) {
  ggplot() +
    geom_sf(
      data = rubella_region_0,
      fill = "grey90",
      color = "grey70",
      linewidth = 0.2
    ) +
    geom_sf(
      data = rubella_region_1,
      aes(fill = status),
      linewidth = 0.2,
      color = "white",
      alpha = opacity_level
    ) +
    scale_fill_manual(
      name = "",
      values = c(
        "Achieved" = "navy",
        "Re-established" = "gold1",
        "Not achieved" = "red2",
        "No data" = "grey80"
      )
    ) +
    theme_void(base_family = "Inter Tight") +
    theme(
      legend.text = element_text(
        size = 12,
        color = "grey40"
      ),
      plot.margin = margin(rep(20, 4)),
      legend.position = "bottom"
    )
}

region_map(opacity_level = 0.25)

region_map(opacity_level = 0.75) +
  with_shadow(
    geom_sf(
      data = rubella |> filter(country == "Afghanistan"),
      aes(fill = status),
      linewidth = 0.8,
      color = "white"
    ),
    sigma = 0,
    x_offset = 4,
    y_offset = 4
  )


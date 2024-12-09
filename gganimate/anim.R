library(tidyverse)
library(gganimate)
library(ggplot2)
library(scales)
library(refugees)
library(sf)

geodata <- read_sf("refugees-animation/countries.geojson") %>%
  filter(ADMIN != "Antarctica")

world_pop <- read_csv("refugees-animation/population-and-demography.csv", show_col_types = FALSE)

all_countries_years <- expand.grid(
  year = unique(population$year),
  coa_iso = unique(geodata$ISO_A3)
)

refugee_data <- population %>%
  select(year, coa_name, coa_iso, refugees) %>%
  group_by(year, coa_name, coa_iso) %>%
  summarise(refugees = sum(refugees, na.rm = TRUE)) %>%
  ungroup() %>%
  right_join(all_countries_years, by = c("year", "coa_iso")) %>%
  mutate(refugees = ifelse(is.na(refugees), NA, refugees))

map_data <- geodata %>%
  left_join(refugee_data, by = c("ISO_A3" = "coa_iso"), relationship = "many-to-many") %>%
  select(geometry, year, coa_name, refugees, ISO_A3) %>%
  left_join(world_pop, by = c("year" = "Year", "ISO_A3" = "Code")) %>%
  mutate(refugee_per_cap = refugees / Population * 100)

p <- ggplot(map_data, aes(fill = refugee_per_cap)) +
  geom_sf(linewidth = 0.2, color = "black") +
  scale_fill_gradientn(
    colours = c("blue", "red"),
    na.value = "lightgrey",
    limits = range(map_data$refugee_per_cap, na.rm = TRUE),
    name = "Refugees per capita",
    labels = comma
  ) +
  theme_void() +
  labs(
    title = "Evolution of Refugees/capita Over Time",
    subtitle = "Year: {current_frame}",
    fill = "Refugees"
  ) +
  theme(
    legend.position = "bottom",
    legend.key.width = unit(2, "cm"),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10),
    plot.title = element_text(hjust = 0.5, size = 20),
    plot.subtitle = element_text(hjust = 0.5, size = 16)
  ) +
  coord_sf(crs = st_crs(3857))



animated_map <- p +
  transition_manual(year)

anim_save(
  "refugees-animation/animated_refugee_map.gif",
  animated_map,
  fps = 5,
  width = 1200, height = 800, res = 150, # Higher resolution
  renderer = gifski_renderer(loop = TRUE)
)

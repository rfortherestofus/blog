library(tidyverse)
library(openmeteo)
library(gganimate)

pdx_rainfall <- 
  weather_history(
  location = "Portland",
  start = "2024-09-11",
  end = "2024-09-11",
  hourly = "precipitation"
  ) |> 
  mutate(raindrops = hourly_precipitation * 100) |> 
  drop_na(hourly_precipitation)



random_number <- function() {
  sample(1:100, 10)
}

pdx_rainfall |> 
  mutate(raindrops = as.integer(raindrops)) |>
  uncount(raindrops) |>
  mutate(x_position = random_number()) |>
  mutate(start_timing = 1) |> 
  mutate(end_timing = 0) |> 
  pivot_longer(
    cols = c(start_timing, end_timing),
    values_to = "timing"
  ) |> 
  select(-name) 


|> 
  ggplot(
    aes(
      x = x_position,
      y = timing,
      group = datetime
    )
  ) +
  geom_point() +
  transition_time(datetime)

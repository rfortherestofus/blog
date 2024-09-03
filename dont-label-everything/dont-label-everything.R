## ----------------------------------------------------------------------------------------------------
library(tidyverse)


## ----------------------------------------------------------------------------------------------------
#| echo: true
population_projection <- 
  read_rds("population_projection.rds")


## ----------------------------------------------------------------------------------------------------
#| label: population-projection-data
#| echo: true
population_projection |>
  filter(location == "Hartford")


## ----------------------------------------------------------------------------------------------------
population_projection_plot <- function(town_to_plot, county_to_plot) {
  population_projection |>
    # Filter the data to only include town, county, and Connecticut
    filter(location %in% c(town_to_plot, county_to_plot, "Connecticut")) |>
    # Make location a factor to ensure the town line shows up on top of the others
    mutate(location = fct(
      location,
      levels = c("Connecticut", county_to_plot, town_to_plot)
    )) |>
    ggplot(aes(
      x = year,
      y = pct,
      color = location,
      group = location
    )) +
    # Add dot for each town/county/state in 2020 and 2040
    geom_point(size = 2) +
    # Add line connecting each town/county/state
    geom_line(show.legend = FALSE) +
    # Remote legend title
    labs(color = NULL) +
    # Make the chart faceted by age group
    facet_wrap(
      vars(age_group),
      nrow = 1
    ) +
    # Set the y limits to go from 0% to 40%
    # Use percent formatting from the {scales} package
    scale_y_continuous(
      limits = c(0, 0.4),
      labels = scales::percent_format(1)
    ) +
    # Set the colors for town, county, and state
    scale_color_manual(
      values = c(
        "#c4c4c4",
        "#fbbfb8",
        "#9f3515"
      )
    ) +
    # Reverse the legend order to put the town first
    guides(color = guide_legend(reverse = TRUE)) +
    # Use theme_minimal() and then make additional tweaks
    theme_minimal() +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      legend.position = "bottom",
      strip.text = element_text(
        face = "italic",
        size = 13,
        color = "grey40"
      ),
      legend.text = element_text(
        size = 13,
        color = "grey40"
      ),
      axis.title = element_blank(),
      axis.text = element_text(
        size = 13,
        color = "grey40"
      )
    )
}


## ----------------------------------------------------------------------------------------------------
#| label: plot-function
#| echo: true
#| output: false
population_projection_plot(
  town_to_plot = "Hartford",
  county_to_plot = "Hartford County"
)


## ----------------------------------------------------------------------------------------------------
#| ref-label: plot-function
#| echo: false


## ----------------------------------------------------------------------------------------------------
#| label: label-everything
#| echo: true
#| eval: false
## population_projection_plot(
##   town_to_plot = "Hartford",
##   county_to_plot = "Hartford County"
## ) +
##   geom_text(
##     aes(
##       label = pct_formatted
##     ),
##     show.legend = FALSE
##   )


## ----------------------------------------------------------------------------------------------------
#| ref-label: label-everything
#| echo: false


## ----------------------------------------------------------------------------------------------------
library(ggrepel)

population_projection_plot(
  town_to_plot = "Hartford",
  county_to_plot = "Hartford County"
) +
  geom_text_repel(
    aes(
      label = pct_formatted
    ),
    show.legend = FALSE
  ) 


## ----------------------------------------------------------------------------------------------------
#| label: plot-with-text
#| echo: true
#| output: false
population_projection_plot(
  town_to_plot = "Hartford",
  county_to_plot = "Hartford County"
) +
  geom_text(
    data = population_projection |> filter(location == "Hartford"),
    nudge_y = 0.03,
    aes(
      label = pct_formatted
    ),
    show.legend = FALSE
  )


## ----------------------------------------------------------------------------------------------------
#| ref-label: plot-with-text
#| echo: false


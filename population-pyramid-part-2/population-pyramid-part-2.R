
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(scales)
library(patchwork)


# Original Population Pyramid Plot ----------------------------------------

oregon_population_pyramid_data <-
  read_csv("https://raw.githubusercontent.com/rfortherestofus/blog/main/population-pyramid-part-1/oregon_population_pyramid_data.csv") |>
  mutate(percent = if_else(gender == "Men", percent, -percent)) |>
  mutate(age = fct_inorder(age))

age_labels <-
  tibble(
    age = c(
      "0-4",
      "5-9",
      "10-14",
      "15-19",
      "20-24",
      "25-29",
      "30-34",
      "35-39",
      "40-44",
      "45-49",
      "50-54",
      "55-59",
      "60-64",
      "65-69",
      "70-74",
      "75-79",
      "80-84",
      "85+"
    )
  ) |>
  mutate(
    age = fct_inorder(age)
  )

age_labels_plot <-
  age_labels |>
  ggplot(
    aes(
      x = 1,
      y = age,
      label = age
    )
  ) +
  geom_text() +
  theme_void()

max_percent <-
  oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  slice_max(
    order_by = percent,
    n = 1
  ) |>
  pull(percent)

population_pyramid_women <-
  oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  filter(gender == "Women") |>
  ggplot(aes(
    x = percent,
    y = age
  )) +
  geom_col(fill = "#A9C27F") +
  annotate(
    geom = "label",
    x = -0.05,
    y = 17,
    label = "Women",
    fill = "#A9C27F",
    color = "grey30",
    label.size = 0,
    label.padding = unit(0.3, "lines")
  ) +
  scale_x_continuous(
    labels = function(x) label_percent(accuracy = 1)(abs(x)),
    breaks = breaks_pretty(),
    limits = c(-max_percent, 0)
  ) +
  theme_void() +
  theme(
    axis.text.x = element_text(),
    panel.grid.major.x = element_line(color = "grey90")
  )

population_pyramid_men <-
  oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  filter(gender == "Men") |>
  ggplot(aes(
    x = percent,
    y = age
  )) +
  geom_col(fill = "#004f39") +
  annotate(
    geom = "label",
    x = 0.05,
    y = 17,
    label = "Men",
    fill = "#004f39",
    color = "white",
    label.size = 0,
    label.padding = unit(0.3, "lines")
  ) +
  scale_x_continuous(
    labels = function(x) label_percent(accuracy = 1)(abs(x)),
    breaks = breaks_pretty(),
    limits = c(0, max_percent)
  ) +
  theme_void() +
  theme(
    axis.text.x = element_text(),
    panel.grid.major.x = element_line(color = "grey90")
  )

population_pyramid_women +
  age_labels_plot +
  population_pyramid_men +
  plot_layout(
    widths = c(7.5, 1, 7.5)
  )



# Create a population pyramid function ------------------------------------

population_pyramid_single_gender_plot <-
  function(
  county_to_filter,
  gender_to_filter
  ) {
    oregon_population_pyramid_data |>
      filter(county == county_to_filter) |>
      filter(gender == gender_to_filter) |>
      ggplot(aes(
        x = percent,
        y = age
      )) +
      geom_col(fill = "#004f39") +
      annotate(
        geom = "label",
        x = 0.05,
        y = 17,
        label = "Men",
        fill = "#004f39",
        color = "white",
        label.size = 0,
        label.padding = unit(0.3, "lines")
      ) +
      scale_x_continuous(
        labels = function(x) label_percent(accuracy = 1)(abs(x)),
        breaks = breaks_pretty(),
        limits = c(0, max_percent)
      ) +
      theme_void() +
      theme(
        axis.text.x = element_text(),
        panel.grid.major.x = element_line(color = "grey90")
      )
  }

population_pyramid_single_gender_plot(
  county_to_filter = "Benton",
  gender_to_filter = "Men"
)

population_pyramid_single_gender_plot(
  county_to_filter = "Benton",
  gender_to_filter = "Women"
)

population_pyramid_single_gender_plot(
  county_to_filter = "Multnomah",
  gender_to_filter = "Men"
)


# Make our x axis limits dynamic ------------------------------------------

population_pyramid_single_gender_plot <-
  function(
  county_to_filter,
  gender_to_filter
  ) {
    max_percent <-
      oregon_population_pyramid_data |>
      filter(county == county_to_filter) |>
      slice_max(
        order_by = percent,
        n = 1
      ) |>
      pull(percent)

    if (gender_to_filter == "Men") {
      x_limits <- c(0, max_percent * 1.1)
    }

    if (gender_to_filter == "Women") {
      x_limits <- c(-max_percent * 1.1, 0)
    }

    oregon_population_pyramid_data |>
      filter(county == county_to_filter) |>
      filter(gender == gender_to_filter) |>
      ggplot(aes(
        x = percent,
        y = age
      )) +
      geom_col(fill = "#004f39") +
      annotate(
        geom = "label",
        x = 0.05,
        y = 17,
        label = "Men",
        fill = "#004f39",
        color = "white",
        label.size = 0,
        label.padding = unit(0.3, "lines")
      ) +
      scale_x_continuous(
        labels = function(x) label_percent(accuracy = 1)(abs(x)),
        breaks = breaks_pretty(),
        limits = x_limits
      ) +
      theme_void() +
      theme(
        axis.text.x = element_text(),
        panel.grid.major.x = element_line(color = "grey90")
      )
  }

population_pyramid_single_gender_plot(
  county_to_filter = "Benton",
  gender_to_filter = "Men"
)

population_pyramid_single_gender_plot(
  county_to_filter = "Multnomah",
  gender_to_filter = "Men"
)

population_pyramid_single_gender_plot(
  county_to_filter = "Benton",
  gender_to_filter = "Women"
)





# Adjust gender label position and text -----------------------------------

population_pyramid_single_gender_plot <-
  function(
  county_to_filter,
  gender_to_filter
  ) {
    max_percent <-
      oregon_population_pyramid_data |>
      filter(county == county_to_filter) |>
      slice_max(
        order_by = percent,
        n = 1
      ) |>
      pull(percent)

    if (gender_to_filter == "Men") {
      x_limits <- c(0, max_percent * 1.1)
      gender_label_x_position <- 0.05
    }

    if (gender_to_filter == "Women") {
      x_limits <- c(-max_percent * 1.1, 0)
      gender_label_x_position <- -0.05
    }

    oregon_population_pyramid_data |>
      filter(county == county_to_filter) |>
      filter(gender == gender_to_filter) |>
      ggplot(aes(
        x = percent,
        y = age
      )) +
      geom_col(fill = "#004f39") +
      annotate(
        geom = "label",
        x = gender_label_x_position,
        y = 17,
        label = gender_to_filter,
        fill = "#004f39",
        color = "white",
        label.size = 0,
        label.padding = unit(0.3, "lines")
      ) +
      scale_x_continuous(
        labels = function(x) label_percent(accuracy = 1)(abs(x)),
        breaks = breaks_pretty(),
        limits = x_limits
      ) +
      theme_void() +
      theme(
        axis.text.x = element_text(),
        panel.grid.major.x = element_line(color = "grey90")
      )
  }

population_pyramid_single_gender_plot(
  county_to_filter = "Benton",
  gender_to_filter = "Men"
)

population_pyramid_single_gender_plot(
  county_to_filter = "Benton",
  gender_to_filter = "Women"
)


# Use different colors for men and women ----------------------------------

population_pyramid_single_gender_plot <-
  function(
  county_to_filter,
  gender_to_filter
  ) {
    max_percent <-
      oregon_population_pyramid_data |>
      filter(county == county_to_filter) |>
      slice_max(
        order_by = percent,
        n = 1
      ) |>
      pull(percent)

    if (gender_to_filter == "Men") {
      x_limits <- c(0, max_percent * 1.1)
      gender_label_x_position <- 0.05
      fill_color <- "#004f39"
      gender_text_color <- "white"
    }

    if (gender_to_filter == "Women") {
      x_limits <- c(-max_percent * 1.1, 0)
      gender_label_x_position <- -0.05
      fill_color <- "#A9C27F"
      gender_text_color <- "grey30"
    }

    oregon_population_pyramid_data |>
      filter(county == county_to_filter) |>
      filter(gender == gender_to_filter) |>
      ggplot(aes(
        x = percent,
        y = age
      )) +
      geom_col(fill = fill_color) +
      annotate(
        geom = "label",
        x = gender_label_x_position,
        y = 17,
        label = gender_to_filter,
        fill = fill_color,
        color = gender_text_color,
        label.size = 0,
        label.padding = unit(0.3, "lines")
      ) +
      scale_x_continuous(
        labels = function(x) label_percent(accuracy = 1)(abs(x)),
        breaks = breaks_pretty(),
        limits = x_limits
      ) +
      coord_cartesian(clip = "off") +
      theme_void() +
      theme(
        axis.text.x = element_text(),
        panel.grid.major.x = element_line(color = "grey90")
      )
  }

population_pyramid_single_gender_plot(
  county_to_filter = "Benton",
  gender_to_filter = "Women"
)


women_plot <-
  population_pyramid_single_gender_plot(
    county_to_filter = "Multnomah",
    gender_to_filter = "Women"
  )

men_plot <-
  population_pyramid_single_gender_plot(
    county_to_filter = "Multnomah",
    gender_to_filter = "Men"
  )

women_plot +
  age_labels_plot +
  men_plot +
  plot_layout(
    widths = c(7.5, 1, 7.5)
  )



# Combine everything into a population pyramid function -------------------

population_pyramid_combined_plot <- function(county_to_filter) {
  women_plot <-
    population_pyramid_single_gender_plot(
      county_to_filter = county_to_filter,
      gender_to_filter = "Women"
    )

  men_plot <-
    population_pyramid_single_gender_plot(
      county_to_filter = county_to_filter,
      gender_to_filter = "Men"
    )

  women_plot +
    age_labels_plot +
    men_plot +
    plot_layout(
      widths = c(7.5, 1, 7.5)
    )
}


population_pyramid_combined_plot(county_to_filter = "Gilliam")

population_pyramid_combined_plot(county_to_filter = "Wallowa")


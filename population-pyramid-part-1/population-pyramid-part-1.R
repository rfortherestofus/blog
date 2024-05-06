library(tidyverse)

oregon_population_pyramid_data <-
  read_csv("https://raw.githubusercontent.com/rfortherestofus/blog/main/population-pyramid-part-1/oregon_population_pyramid_data.csv")

oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  arrange(age, gender) |>
  print(n = 36)

oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  ggplot(aes(
    x = percent,
    y = age,
    fill = gender
  )) +
  geom_col()






oregon_population_pyramid_data <-
  oregon_population_pyramid_data |>
  mutate(percent = if_else(gender == "Men", percent, -percent))

oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  ggplot(aes(
    x = percent,
    y = age,
    fill = gender
  )) +
  geom_col()

oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  ggplot(
    aes(
      x = percent,
      y = age,
      fill = gender
    )
  ) +
  geom_col() +
  geom_label(
    aes(
      x = 0,
      label = age
    ),
    fill = "white",
    label.size = 0
  )






oregon_population_pyramid_data <-
  oregon_population_pyramid_data |>
  mutate(age = fct_inorder(age))

oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  ggplot(
    aes(
      x = percent,
      y = age,
      fill = gender
    )
  ) +
  geom_col() +
  geom_label(
    aes(
      x = 0,
      label = age
    ),
    fill = "white",
    label.size = 0
  )




population_pyramid_women <-
  oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  filter(gender == "Women") |>
  ggplot(aes(
    x = percent,
    y = age
  )) +
  geom_col() +
  theme_void()

population_pyramid_men <-
  oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  filter(gender == "Men") |>
  ggplot(aes(
    x = percent,
    y = age
  )) +
  geom_col() +
  theme_void()

population_pyramid_men


library(patchwork)

population_pyramid_women +
  population_pyramid_men




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

population_pyramid_women +
  age_labels_plot +
  population_pyramid_men




population_pyramid_women +
  age_labels_plot +
  population_pyramid_men +
  plot_layout(
    widths = c(7.5, 1, 7.5)
  )


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
  theme_void()

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
  theme_void()

population_pyramid_women +
  age_labels_plot +
  population_pyramid_men +
  plot_layout(
    widths = c(7.5, 1, 7.5)
  )

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




library(scales)

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
    labels = label_percent(accuracy = 1)
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
    labels = label_percent(accuracy = 1)
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
    labels = function(x) label_percent(accuracy = 1)(abs(x))
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
    labels = function(x) label_percent(accuracy = 1)(abs(x))
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
    breaks = breaks_pretty()
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
    breaks = breaks_pretty()
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




max_percent <-
  oregon_population_pyramid_data |>
  filter(county == "Benton") |>
  slice_max(
    order_by = percent,
    n = 1
  ) |>
  pull(percent)

max_percent

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

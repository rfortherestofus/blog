library(ggplot2)

# Create an example plot
default_plot <- ggplot(
  economics,
  aes(date, unemploy)
) +
  geom_line() +
  labs(
    title = "Unemployed persons in the United States",
    subtitle = "Monthly aggregation from 1967 - 2015",
    caption = "Data source: {ggplot2} R package",
    x = NULL,
    y = NULL
  ) +
  # Unemployment level is number of unemployed 
  # in thousands. This declutters the figure by 
  # presenting the number of unemployed in millions.
  scale_y_continuous(
    labels = scales::label_number(
      scale = 0.001,
      suffix = " M"
    ),
    limits = c(0, max(economics$unemploy))
  )

default_plot

# Pick a built-in theme as a base
nyt_plot <- default_plot +
  theme_minimal(
    base_family = "Libre Franklin"
  )

nyt_plot

# Customize text elements
nyt_plot <- nyt_plot +
  theme(
    plot.title = element_text(
      size = 18,
      face = "bold",
      color = "#333333", # dark gray
      margin = margin(b = 10)
    ),
    plot.subtitle = element_text(
      size = 14,
      color = "#999999", # medium gray
      margin = margin(b = 10)
    ),
    plot.caption = element_text(
      size = 13,
      color = "#777777", # light gray
      margin = margin(t = 15),
      hjust = 0
    ),
    axis.text = element_text(
      size = 11,
      color = "#333333" # dark gray
    )
  )

nyt_plot

# Align title, subtitle, and caption to plot
nyt_plot <- nyt_plot +
  theme(
    plot.title.position = "plot",
    plot.caption.position = "plot"
  )

nyt_plot

# Customize line elements
nyt_plot <- nyt_plot +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(
      linetype = "dashed",
      linewidth = 0.15,
      color = "#999999"
    ),
    panel.grid.major.x = element_blank(),
    axis.ticks.x = element_line(
      linetype = "solid",
      linewidth = 0.25,
      color = "#999999"
    ),
    axis.ticks.length.x = unit(4, units = "pt")
  )

nyt_plot

# Wrap it in a function
theme_nyt <- function() {
  # Set base theme and font family ==================
  theme_minimal(
    base_family = "Libre Franklin"
  ) +
    # Overwrite base theme defaults =================
    theme(
      # Text elements ===============================
      plot.title = element_text(
        size = 18,
        face = "bold",
        color = "#333333",
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        size = 14,
        color = "#999999",
        margin = margin(b = 10)
      ),
      plot.caption = element_text(
        size = 13,
        color = "#777777",
        margin = margin(t = 15),
        hjust = 0
      ),
      axis.text = element_text(
        size = 11,
        color = "#333333"
      ),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      # Line elements ============================
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(
        linetype = "dashed",
        linewidth = 0.15,
        color = "#999999"
      ),
      panel.grid.major.x = element_blank(),
      axis.ticks.x = element_line(
        linetype = "solid",
        linewidth = 0.25,
        color = "#999999"
      ),
      axis.ticks.length.x = unit(4, units = "pt")
    )
}

# Test our function
default_plot +
  theme_nyt()

# Add arguments to custom theme function
theme_nyt <- function(
  gridline_x = TRUE,
  gridline_y = TRUE
) {
  gridline <- element_line(
    linetype = "dashed",
    linewidth = 0.15,
    color = "#999999"
  )

  gridline_x <- if (isTRUE(gridline_x)) {
    gridline
  } else {
    element_blank()
  }

  gridline_y <- if (isTRUE(gridline_y)) {
    gridline
  } else {
    element_blank()
  }

  # Set base theme and font family ================
  theme_minimal(
    base_family = "Libre Franklin"
  ) +
    # Overwrite base theme defaults ===============
    theme(
      # Text elements =============================
      plot.title = element_text(
        size = 18,
        face = "bold",
        color = "#333333",
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        size = 14,
        color = "#999999",
        margin = margin(b = 10)
      ),
      plot.caption = element_text(
        size = 13,
        color = "#777777",
        margin = margin(t = 15),
        hjust = 0
      ),
      axis.text = element_text(
        size = 11,
        color = "#333333"
      ),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      # Line elements =============================
      panel.grid.minor = element_blank(),
      panel.grid.major.x = gridline_x,
      panel.grid.major.y = gridline_y,
      axis.ticks.x = element_line(
        linetype = "solid",
        linewidth = 0.25,
        color = "#999999"
      ),
      axis.ticks.length.x = unit(4, units = "pt")
    )
}

# Test our function with grid line arguments
default_plot +
  theme_nyt(
    gridline_x = FALSE,
    gridline_y = TRUE
  )

# Create a new test plot
mtcars_plot <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  labs(
    title = "Fuel economy declines as weight increases",
    subtitle = "Fuel economy and weight for 32 automobiles (1973–74 models)",
    caption = "Data source: {ggplot2} R package",
    x = "Weight (1000 lbs)",
    y = "Miles per US gallon"
  )

mtcars_plot

# Test our function on the new plot
mtcars_plot <- mtcars_plot +
  theme_nyt(
    gridline_x = TRUE,
    gridline_y = TRUE
  )

mtcars_plot

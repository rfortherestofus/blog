# Combine line chart and area chart
David Keyes
2024-09-16

I found this really nice graph in [the
NYT](https://www.nytimes.com/2024/04/15/upshot/mortgage-rates-homes-stuck.html)
and I thought it was really effective, particularly the fact that it
shows two lines and only shows the spread over a specific period. So how
can we replicate this in R, particularly the shading of the spread?

![](preview-chart.png)

In this guide, I’ll walk you through the steps of creating a line chart
with two lines, where the area between the lines is filled only for a
specific portion of the chart. Here’s what we’re going to do:

## Load the Necessary Libraries

First, we need to load the `tidyverse` package, which includes `ggplot2`
for plotting and `dplyr` for data manipulation. We’ll also be using the
`gapminder` dataset that comes preloaded with the `gapminder` package.
It contains data about life expectancy, GDP per capita, and population
for different countries over time.

``` r
library(tidyverse)
library(gapminder)
```

## Filter the Data

We’ll focus on two specific countries (e.g., “Australia” and “Japan”)
and plot their GDP per capita over time. To do this, we’ll filter the
dataset accordingly.

``` r
gdp_data <- gapminder |>
   filter(country %in% c("Japan", "Australia")) |>
   filter(year >= 1982) |>
   select(year, country, gdpPercap)
```

Now that we’ve filtered the data to include only Australia and Japan
after 1982, let’s take a look at it:

``` r
gdp_data
#> # A tibble: 12 × 3
#>     year country   gdpPercap
#>    <int> <fct>         <dbl>
#>  1  1982 Australia    19477.
#>  2  1987 Australia    21889.
#>  3  1992 Australia    23425.
#>  4  1997 Australia    26998.
#>  5  2002 Australia    30688.
#>  6  2007 Australia    34435.
#>  7  1982 Japan        19384.
#>  8  1987 Japan        22376.
#>  9  1992 Japan        26825.
#> 10  1997 Japan        28817.
#> 11  2002 Japan        28605.
#> 12  2007 Japan        31656.
```

## Create a Basic Line Plot

To begin, we’ll create a basic line chart that shows the GDP per capita
for both Australia and Japan over time, using the `geom_line()`
function.

``` r
ggplot(gdp_data, aes(x = year, y = gdpPercap, color = country)) +
   geom_line(size = 1.2) +
   labs(
      title = "GDP Per Capita Comparison: Australia vs Japan",
      subtitle = "Area between the lines is highlighted for the years 2002-2007",
      x = NULL,
      y = "GDP Per Capita",
      caption = "Source: Gapminder"
   ) +
   theme_minimal()
```

![](area-and-line-chart_files/figure-commonmark/unnamed-chunk-4-1.svg)

## Highlight the Area Between the Two Lines for a Specific Time Period

### Filter Data for the Highlighted Area

We’ll focus on a specific time period to fill the area between the two
lines. Let’s say we want to highlight the period **between 2000 and
2010**. We’ll first filter the data to include only that range of years:

``` r
highlight_data <- gdp_data |>
   filter(year > 2000 & year < 2010)

highlight_data
#> # A tibble: 4 × 3
#>    year country   gdpPercap
#>   <int> <fct>         <dbl>
#> 1  2002 Australia    30688.
#> 2  2007 Australia    34435.
#> 3  2002 Japan        28605.
#> 4  2007 Japan        31656.
```

We’ll need to reshape the data so that the GDP per capita for both
countries appears in separate columns.

``` r
highlight_data_wide <- highlight_data |>
   pivot_wider(names_from = country, values_from = gdpPercap)

highlight_data_wide
#> # A tibble: 2 × 3
#>    year Australia  Japan
#>   <int>     <dbl>  <dbl>
#> 1  2002    30688. 28605.
#> 2  2007    34435. 31656.
```

### Create a Filled Area Between the Lines

To fill the area between the lines, we can use `geom_ribbon()`. This
function **shades the space between two curves** on a graph, making it
clear and easy to see the range between them.

In this case, we apply `geom_ribbon()` to our filtered data
(`highlight_data_wide`) as shown above.

``` r
ggplot() +
   geom_line(
      data = gdp_data,
      aes(
         x = year,
         y = gdpPercap,
         color = country
      ),
      size = 1.2
   ) +
   geom_ribbon(
      data = highlight_data_wide,
      aes(x = year, ymin = Japan, ymax = Australia),
      fill = "#ADD8E6",
      alpha = 0.7
   ) +
   labs(
      title = "GDP Per Capita Comparison: Australia vs Japan",
      subtitle = "Area between the lines is highlighted for the years 2002-2007",
      x = NULL,
      y = "GDP Per Capita",
      caption = "Source: Gapminder"
   ) +
   theme_minimal()
```

![](area-and-line-chart_files/figure-commonmark/unnamed-chunk-7-1.svg)

## Annotation for the highlighted area

First, to make our code easier, let’s create variables with the
information about the region we want to highlight. For this we need:

- the **maximum value** of both Australia and Japan
- the **difference** between them
- the **label** we want to appear next to the filled zone

``` r
max_australia <- gdp_data |>
   filter(country == "Australia") |>
   slice_max(gdpPercap, n = 1) |>
   pull(gdpPercap)

max_japan <- gdp_data |>
   filter(country == "Japan") |>
   slice_max(gdpPercap, n = 1) |>
   pull(gdpPercap)

difference <- max_australia - max_japan

dollar <- scales::label_dollar(accuracy = 1)
gap_label <- str_glue("{dollar(difference)} gap")
```

Then, we use the same code as before but with 2 new geoms:

- `geom_segment()`: draw a straight line segment between two points. In
  our case, we will use it to draw 2 segments around the GDP per capita
  gap annotation.
- `geom_text()`: add text annotations to the plot. We’ll use it to label
  the gap between the two lines, which represents the difference in GDP
  per capita between the two countries.

``` r
ggplot() +
   geom_ribbon(
      data = highlight_data_wide,
      aes(x = year, ymin = Japan, ymax = Australia),
      fill = "#ADD8E6",
      alpha = 0.7
   ) +
   geom_line(data = gdp_data, aes(x = year, y = gdpPercap, color = country), size = 1.2) +
   labs(
      title = "GDP Per Capita Comparison: Australia vs Japan",
      subtitle = "Area between the lines is highlighted for the years 2002-2007",
      x = "Year",
      y = "GDP Per Capita",
      caption = "Source: Gapminder"
   ) +
   theme_minimal() +
   geom_segment(
      aes(
         x = 2008,
         xend = 2008,
         y = max_australia - 1000,
         yend = max_australia + 100
      )
   ) +
   geom_segment(
      aes(
         x = 2008,
         xend = 2008,
         y = max_japan - 100,
         yend = max_japan + 900
      )
   ) +
   geom_text(
      aes(x = 2007.5, y = 33000),
      label = gap_label,
      hjust = 0,
      vjust = 0.5,
      size = 3
   ) +
   coord_cartesian(clip = "off", xlim = c(1982, 2012))
```

![](area-and-line-chart_files/figure-commonmark/unnamed-chunk-9-1.svg)

You now have a polished line chart comparing GDP per capita between
Australia and Japan. The area between the two lines is filled for the
years 2002-2007, making it easy to visually compare their economic
performance during that period.

This technique is a great way to highlight differences between two
variables over a specific range of time, helping the viewer focus on key
periods of interest in the data.
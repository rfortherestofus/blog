# Refugees animation
David Keyes
2024-01-17

## Data

## Intro

The {gganimate} package is the easiest way to make animated plots in R. If you know how to make plots in ggplot, you can animate them with {gganimate}.

To show how {gganimate} works, let’s use data from the United Nations High Commissioner for Refugees (UNHCR). [Their package](https://www.unhcr.org/refugee-statistics/insights/explainers/refugees-r-package.html), called {refugees}, has data on a number of different datasets related to refugee populations. I’ll use one of these datasets, called `population`, which has “data on forcibly displaced and stateless persons by year, including refugees, asylum-seekers, internally displaced people (IDPs) and stateless people.” I begin by loading the {refugees} package:

``` r
library(refugees)
```

And then showing the `population` data:

``` r
population
#> # A tibble: 126,402 × 16
#>     year coo_name coo   coo_iso coa_name   coa   coa_iso refugees asylum_seekers
#>    <dbl> <chr>    <chr> <chr>   <chr>      <chr> <chr>      <dbl>          <dbl>
#>  1  1951 Unknown  UKN   UNK     Australia  AUL   AUS       180000              0
#>  2  1951 Unknown  UKN   UNK     Austria    AUS   AUT       282000              0
#>  3  1951 Unknown  UKN   UNK     Belgium    BEL   BEL        55000              0
#>  4  1951 Unknown  UKN   UNK     Canada     CAN   CAN       168511              0
#>  5  1951 Unknown  UKN   UNK     Denmark    DEN   DNK         2000              0
#>  6  1951 Unknown  UKN   UNK     France     FRA   FRA       290000              0
#>  7  1951 Unknown  UKN   UNK     United Ki… GBR   GBR       208000              0
#>  8  1951 Unknown  UKN   UNK     Germany    GFR   DEU       265000              0
#>  9  1951 Unknown  UKN   UNK     Greece     GRE   GRC        18000              0
#> 10  1951 Unknown  UKN   UNK     China, Ho… HKG   HKG        30000              0
#> # ℹ 126,392 more rows
#> # ℹ 7 more variables: returned_refugees <dbl>, idps <dbl>, returned_idps <dbl>,
#> #   stateless <dbl>, ooc <dbl>, oip <dbl>, hst <dbl>
```

``` r

library(tidyverse)
library(sf)
library(scales)
library(hrbrthemes)
library(gganimate)
```

## Data

``` r
refugees_data <-
  read_rds("https://github.com/rfortherestofus/blog/raw/refs/heads/main/gganimate/refugees_data.rds")
```

``` r
refugees_data_geospatial <-
  read_sf("https://github.com/rfortherestofus/blog/raw/refs/heads/main/gganimate/refugees_data_geospatial.geojson")
```

## Plot

``` r
refugees_data |>
  filter(country_abbreviation == "SYR") |>
  ggplot(
    aes(
      x = year,
      y = refugees_as_pct
    )
  ) +
  scale_y_continuous(
    labels = percent_format()
  ) +
  geom_line() +
  labs(
    x = NULL,
    y = NULL
  ) +
  theme_ipsum_inter() +
  theme(panel.grid.minor = element_blank()) +
  transition_reveal(year)
```

<img src="gganimate_files/figure-commonmark/unnamed-chunk-7-1.gif" style="width:100.0%" />

## Map

``` r
refugees_data_geospatial |>
  left_join(
    refugees_data,
    join_by(country_abbreviation)
  ) |>
  filter(continent == "Asia") |>
  filter(subregion == "Western Asia") |>
  ggplot() +
  geom_sf(
    aes(fill = refugees_as_pct),
    linewidth = 0.1,
    color = "white"
  ) +
  theme_ipsum_inter(
    grid = FALSE
  ) +
  labs(
    title = "Refugees as a percentage of total population in {current_frame}",
    # caption = "{current_frame}",
    fill = NULL
  ) +
  scale_fill_viridis_c(
    labels = scales::percent_format(),
    limits = c(0, .4),
    option = "C",
    guide = guide_colorsteps(show.limits = TRUE)
  ) +
  theme(
    legend.position = "top",
    plot.title = element_text(
      face = "bold",
      hjust = 0.5
    ),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    legend.key.width = unit(2, "cm"),
    legend.text = element_text(
      size = 12
    )
  ) +
  transition_manual(year)
```

<img src="gganimate_files/figure-commonmark/unnamed-chunk-8-1.gif" style="width:100.0%" />

# Refugees animation
David Keyes
2024-01-17

## Data

## Intro

The {gganimate} package is the easiest way to make animated plots in R. If you know how to make plots in ggplot, you can animate them with {gganimate}. Animated plots are a great way to capture attention, especially online where the next shiny object is just a scroll away. If you want to get attention on your data, using animation with a package like {gganimate} is a great option.

In this blog post, I’ll show how to use the {gganimate} package by animating data on refugees. As part of our [one percent for people, one percent for the planet giving program](https://rfortherestofus.com/1percent), we regularly support the work of the United Nations High Commissioner for Refugees (UNHCR). If you want to learn more about how the UNHCR uses R, please see our interviews with UNHCR statistician Ahmadou Dicko and information management officer Cédric Vidonne. TODO: Add links

## Import Data

To show how {gganimate} works, let’s use data from UNHCR. [Their {refugees} package](https://www.unhcr.org/refugee-statistics/insights/explainers/refugees-r-package.html) has data on a number of different datasets related to refugee populations. I’ll use one of these datasets, called `population`, which has “data on forcibly displaced and stateless persons by year, including refugees, asylum-seekers, internally displaced people (IDPs) and stateless people.”

I begin by loading the {refugees} package:

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

This dataset has more variables than we need. I’ve done some work to calculate the refugee population from each country as a percentage of its total population in all years since 2000 (you can see the code for that [here](https://github.com/rfortherestofus/blog/blob/main/gganimate/gganimate.qmd)). To see the data that I end up with, I’ll load the {tidyverse}:

``` r
library(tidyverse)
```

Next, I’ll import the data I’ve created and saved as an RDS file:

``` r
refugees_data <-
  read_rds("https://github.com/rfortherestofus/blog/raw/refs/heads/main/gganimate/refugees_data.rds")
```

We can take a look at the `refugees_data` tibble we now have to work with:

``` r
refugees_data
#> # A tibble: 5,136 × 5
#>     year country_abbreviation total_population number_of_refugees
#>    <dbl> <chr>                           <dbl>              <dbl>
#>  1  2018 SYR                          19333463            6654374
#>  2  2017 SYR                          18983373            6310498
#>  3  2019 SYR                          20098251            6615249
#>  4  2020 SYR                          20772595            6702910
#>  5  2021 SYR                          21324367            6848865
#>  6  2022 SYR                          22125249            6559736
#>  7  2016 SYR                          18964252            5524511
#>  8  2023 SYR                          23227014            6355788
#>  9  2015 SYR                          19205178            4873236
#> 10  2017 SSD                          10658226            2439888
#> # ℹ 5,126 more rows
#> # ℹ 1 more variable: refugees_as_pct <dbl>
```

I’ve sorted the data to show the single year and country with the highest percentage of refugees as a proportion of the total population. As you can see, Syria (with the country abbreviation SYR) has the top 9 observations, a result of its [decade-plus civil war](https://www.cfr.org/article/syrias-civil-war).

## Plot

We’re now ready to

``` r
library(scales)
library(hrbrthemes)
library(gganimate)
```

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

<img src="gganimate_files/figure-commonmark/unnamed-chunk-8-1.gif" style="width:100.0%" />

## Map

``` r
library(sf)
```

``` r
refugees_data_geospatial <-
  read_sf("https://github.com/rfortherestofus/blog/raw/refs/heads/main/gganimate/refugees_data_geospatial.geojson")
```

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

<img src="gganimate_files/figure-commonmark/unnamed-chunk-11-1.gif" style="width:100.0%" />

# Use tidyselect helpers to grab the right data
Albert Rapp
Invalid Date

<!-- Not sure how to connect this to R4ROU work -->

Tidyselect helpers are neat little helper function that help you, well, select the right data. This can make your life easier when you want to either grab many different columns or even transform many columns using `across()`. For example, have you ever found yourself typing out repetitive calculations like this:

``` r
library(tidyverse)

penguins <- palmerpenguins::penguins
penguins |>
  mutate(
    bill_length_cm = bill_length_mm / 10,
    bill_depth_cm = bill_depth_mm / 10,
    flipper_length_cm = flipper_length_mm / 10
  ) |>
  select(
    -c(
      bill_length_mm, 
      bill_depth_mm,
      flipper_length_mm
    )
  )
#> # A tibble: 344 × 8
#>    species island    body_mass_g sex     year bill_length_cm bill_depth_cm
#>    <fct>   <fct>           <int> <fct>  <int>          <dbl>         <dbl>
#>  1 Adelie  Torgersen        3750 male    2007           3.91          1.87
#>  2 Adelie  Torgersen        3800 female  2007           3.95          1.74
#>  3 Adelie  Torgersen        3250 female  2007           4.03          1.8 
#>  4 Adelie  Torgersen          NA <NA>    2007          NA            NA   
#>  5 Adelie  Torgersen        3450 female  2007           3.67          1.93
#>  6 Adelie  Torgersen        3650 male    2007           3.93          2.06
#>  7 Adelie  Torgersen        3625 female  2007           3.89          1.78
#>  8 Adelie  Torgersen        4675 male    2007           3.92          1.96
#>  9 Adelie  Torgersen        3475 <NA>    2007           3.41          1.81
#> 10 Adelie  Torgersen        4250 <NA>    2007           4.2           2.02
#> # ℹ 334 more rows
#> # ℹ 1 more variable: flipper_length_cm <dbl>
```

Here, we converted all the measurements that are given in millimeters (mm) to centimeters (cm). To do so, we had to

- divide the mm numbers by 10 (yay, metric system 🥳) and
- select all but the old columns (with units in mm)

Writing out all the new variable names is pretty repetitive and slightly annoying. At the least, it would be great if the last `select()` call could be simplified. And it turns out there is a way to do that, namely using tidyselect helpers. Let’s go through them all. And then, I’ll show you how you can use these tidyselect helpers to even avoid repetitive calculations in the first `mutate()` call.

## Select consecutive columns

For now, though let’s just take our `penguins` data set as is and try to find ways to grab the right columns. Let’s take a look at the data to remind ourselves how it looks.

``` r
penguins
#> # A tibble: 344 × 8
#>    species island    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g
#>    <fct>   <fct>              <dbl>         <dbl>             <int>       <int>
#>  1 Adelie  Torgersen           39.1          18.7               181        3750
#>  2 Adelie  Torgersen           39.5          17.4               186        3800
#>  3 Adelie  Torgersen           40.3          18                 195        3250
#>  4 Adelie  Torgersen           NA            NA                  NA          NA
#>  5 Adelie  Torgersen           36.7          19.3               193        3450
#>  6 Adelie  Torgersen           39.3          20.6               190        3650
#>  7 Adelie  Torgersen           38.9          17.8               181        3625
#>  8 Adelie  Torgersen           39.2          19.6               195        4675
#>  9 Adelie  Torgersen           34.1          18.1               193        3475
#> 10 Adelie  Torgersen           42            20.2               190        4250
#> # ℹ 334 more rows
#> # ℹ 2 more variables: sex <fct>, year <int>
```

Now, let’s grab consecutive columns with `:`. For example, we could grab the second to fourth column like this.

``` r
penguins |> select(2:4)
#> # A tibble: 344 × 3
#>    island    bill_length_mm bill_depth_mm
#>    <fct>              <dbl>         <dbl>
#>  1 Torgersen           39.1          18.7
#>  2 Torgersen           39.5          17.4
#>  3 Torgersen           40.3          18  
#>  4 Torgersen           NA            NA  
#>  5 Torgersen           36.7          19.3
#>  6 Torgersen           39.3          20.6
#>  7 Torgersen           38.9          17.8
#>  8 Torgersen           39.2          19.6
#>  9 Torgersen           34.1          18.1
#> 10 Torgersen           42            20.2
#> # ℹ 334 more rows
```

That was pretty easy, right? This works exactly the same when you want to use column names instead of column numbers.

``` r
penguins |> select(island:bill_depth_mm)
#> # A tibble: 344 × 3
#>    island    bill_length_mm bill_depth_mm
#>    <fct>              <dbl>         <dbl>
#>  1 Torgersen           39.1          18.7
#>  2 Torgersen           39.5          17.4
#>  3 Torgersen           40.3          18  
#>  4 Torgersen           NA            NA  
#>  5 Torgersen           36.7          19.3
#>  6 Torgersen           39.3          20.6
#>  7 Torgersen           38.9          17.8
#>  8 Torgersen           39.2          19.6
#>  9 Torgersen           34.1          18.1
#> 10 Torgersen           42            20.2
#> # ℹ 334 more rows
```

And the cool thing is you can still grab columns individually too. For example, let’s additionally grab the `sex` column. No problem. Just add this to `select()`.

``` r
penguins |> select(island:bill_depth_mm, sex)
#> # A tibble: 344 × 4
#>    island    bill_length_mm bill_depth_mm sex   
#>    <fct>              <dbl>         <dbl> <fct> 
#>  1 Torgersen           39.1          18.7 male  
#>  2 Torgersen           39.5          17.4 female
#>  3 Torgersen           40.3          18   female
#>  4 Torgersen           NA            NA   <NA>  
#>  5 Torgersen           36.7          19.3 female
#>  6 Torgersen           39.3          20.6 male  
#>  7 Torgersen           38.9          17.8 female
#>  8 Torgersen           39.2          19.6 male  
#>  9 Torgersen           34.1          18.1 <NA>  
#> 10 Torgersen           42            20.2 <NA>  
#> # ℹ 334 more rows
```

That’s the beauty of all these selection helpers. You can combine them as much as you want.

## Grab columns based on data type

The `:` operator assumes that we want columns that come in a consecutive order. But sometimes we have so many columns that we are only interested in particular columns based on their data types. Maybe we want to calculate means with these columns. That would be hard to do with columns that don’t have numbers in them.

Thankfully, we have a tidyselect helper that grabs columns based on data types. But it requires another partner function that evaluates the data type. Check it out.

``` r
penguins |>
  select(
    where(is.numeric)
  )
#> # A tibble: 344 × 5
#>    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g  year
#>             <dbl>         <dbl>             <int>       <int> <int>
#>  1           39.1          18.7               181        3750  2007
#>  2           39.5          17.4               186        3800  2007
#>  3           40.3          18                 195        3250  2007
#>  4           NA            NA                  NA          NA  2007
#>  5           36.7          19.3               193        3450  2007
#>  6           39.3          20.6               190        3650  2007
#>  7           38.9          17.8               181        3625  2007
#>  8           39.2          19.6               195        4675  2007
#>  9           34.1          18.1               193        3475  2007
#> 10           42            20.2               190        4250  2007
#> # ℹ 334 more rows
```

Here, we have partnered up the tidyselect helper `where()` with the `is.numeric` function. The latter function checks whether a column is numeric and returns TRUE or FALSE for each column accordingly. Then, `where()` grabs those responses from `is.numeric` and grabs only those columns **where** `is.numeric` returned TRUE.

Notice that you don’t actually call `is.numeric` in your code. You only do `where(is.numeric)` and not `where(is.numeric())`. That’s because you partner up the function `is.numeric` with the `where` function. This way, the `where` function just knows the name of its partner (in this case `is.numeric`) and can let its partner do the checking whenever `where` feels like it.

## Grab columns based on name

Of course, sometimes you don’t even have to think this complicated. Sometimes, you actually know which numeric columns you want to grab. For example, in our first example we wanted to transform the millimeter columns. So, we could just grab the columns that have a `mm` in their column name. That works via `contains()`.

``` r
penguins |>
  select(
    contains("mm")
  )
#> # A tibble: 344 × 3
#>    bill_length_mm bill_depth_mm flipper_length_mm
#>             <dbl>         <dbl>             <int>
#>  1           39.1          18.7               181
#>  2           39.5          17.4               186
#>  3           40.3          18                 195
#>  4           NA            NA                  NA
#>  5           36.7          19.3               193
#>  6           39.3          20.6               190
#>  7           38.9          17.8               181
#>  8           39.2          19.6               195
#>  9           34.1          18.1               193
#> 10           42            20.2               190
#> # ℹ 334 more rows
```

In this particular case, we could even use the `ends_with()` helper. Using this alternative can sometimes be helpful to avoid accidentally picking a column that for some other reason has `mm` in it.

``` r
penguins |>
  select(
    ends_with("mm")
  )
#> # A tibble: 344 × 3
#>    bill_length_mm bill_depth_mm flipper_length_mm
#>             <dbl>         <dbl>             <int>
#>  1           39.1          18.7               181
#>  2           39.5          17.4               186
#>  3           40.3          18                 195
#>  4           NA            NA                  NA
#>  5           36.7          19.3               193
#>  6           39.3          20.6               190
#>  7           38.9          17.8               181
#>  8           39.2          19.6               195
#>  9           34.1          18.1               193
#> 10           42            20.2               190
#> # ℹ 334 more rows
```

Similarly, there’s `start_with()`. For example, we can grab the bill-related columns that way.

``` r
penguins |>
  select(
    starts_with("bill")
  )
#> # A tibble: 344 × 2
#>    bill_length_mm bill_depth_mm
#>             <dbl>         <dbl>
#>  1           39.1          18.7
#>  2           39.5          17.4
#>  3           40.3          18  
#>  4           NA            NA  
#>  5           36.7          19.3
#>  6           39.3          20.6
#>  7           38.9          17.8
#>  8           39.2          19.6
#>  9           34.1          18.1
#> 10           42            20.2
#> # ℹ 334 more rows
```

## Simplify our first example

Now we have all the tools we need to simplify our first example. Recall that the code looked like this:

``` r
penguins |>
  mutate(
    bill_length_cm = bill_length_mm / 10,
    bill_depth_cm = bill_depth_mm / 10,
    flipper_length_cm = flipper_length_mm / 10,
  ) |>
  select(
    -c(
      bill_length_mm, bill_depth_mm,
      flipper_length_mm
    )
  )
#> # A tibble: 344 × 8
#>    species island    body_mass_g sex     year bill_length_cm bill_depth_cm
#>    <fct>   <fct>           <int> <fct>  <int>          <dbl>         <dbl>
#>  1 Adelie  Torgersen        3750 male    2007           3.91          1.87
#>  2 Adelie  Torgersen        3800 female  2007           3.95          1.74
#>  3 Adelie  Torgersen        3250 female  2007           4.03          1.8 
#>  4 Adelie  Torgersen          NA <NA>    2007          NA            NA   
#>  5 Adelie  Torgersen        3450 female  2007           3.67          1.93
#>  6 Adelie  Torgersen        3650 male    2007           3.93          2.06
#>  7 Adelie  Torgersen        3625 female  2007           3.89          1.78
#>  8 Adelie  Torgersen        4675 male    2007           3.92          1.96
#>  9 Adelie  Torgersen        3475 <NA>    2007           3.41          1.81
#> 10 Adelie  Torgersen        4250 <NA>    2007           4.2           2.02
#> # ℹ 334 more rows
#> # ℹ 1 more variable: flipper_length_cm <dbl>
```

We no longer have to type out all the `mm` column names to remove them (with `-`). We can just use `ends_with()`.

``` r
penguins |>
  mutate(
    bill_length_cm = bill_length_mm / 10,
    bill_depth_cm = bill_depth_mm / 10,
    flipper_length_cm = flipper_length_mm / 10
  ) |>
  select(-ends_with("mm"))
#> # A tibble: 344 × 8
#>    species island    body_mass_g sex     year bill_length_cm bill_depth_cm
#>    <fct>   <fct>           <int> <fct>  <int>          <dbl>         <dbl>
#>  1 Adelie  Torgersen        3750 male    2007           3.91          1.87
#>  2 Adelie  Torgersen        3800 female  2007           3.95          1.74
#>  3 Adelie  Torgersen        3250 female  2007           4.03          1.8 
#>  4 Adelie  Torgersen          NA <NA>    2007          NA            NA   
#>  5 Adelie  Torgersen        3450 female  2007           3.67          1.93
#>  6 Adelie  Torgersen        3650 male    2007           3.93          2.06
#>  7 Adelie  Torgersen        3625 female  2007           3.89          1.78
#>  8 Adelie  Torgersen        4675 male    2007           3.92          1.96
#>  9 Adelie  Torgersen        3475 <NA>    2007           3.41          1.81
#> 10 Adelie  Torgersen        4250 <NA>    2007           4.2           2.02
#> # ℹ 334 more rows
#> # ℹ 1 more variable: flipper_length_cm <dbl>
```

Ahh that’s better better. Much less typing.

## Tidyselect helpers everywhere

Now that we have that covered, let me show you how to simplify the repetitive `mutate()` call too. We can actually use tidyselect helpers there as well. After all, we could tell `mutate()` to take all the columns that end in `mm` and divide their values by 10. To do so, we first define a function that does the tricky math part.

``` r
divide_by_ten <- function(x) x / 10
```

And then we combine `mutate()` with `across()` to apply `divide_by_ten` **across** desired columns.

``` r
penguins |>
  mutate(
    across(
      .cols = ends_with("mm"), # <- tidyselect helper here
      .fns = divide_by_ten
    )
  )
#> # A tibble: 344 × 8
#>    species island    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g
#>    <fct>   <fct>              <dbl>         <dbl>             <dbl>       <int>
#>  1 Adelie  Torgersen           3.91          1.87              18.1        3750
#>  2 Adelie  Torgersen           3.95          1.74              18.6        3800
#>  3 Adelie  Torgersen           4.03          1.8               19.5        3250
#>  4 Adelie  Torgersen          NA            NA                 NA            NA
#>  5 Adelie  Torgersen           3.67          1.93              19.3        3450
#>  6 Adelie  Torgersen           3.93          2.06              19          3650
#>  7 Adelie  Torgersen           3.89          1.78              18.1        3625
#>  8 Adelie  Torgersen           3.92          1.96              19.5        4675
#>  9 Adelie  Torgersen           3.41          1.81              19.3        3475
#> 10 Adelie  Torgersen           4.2           2.02              19          4250
#> # ℹ 334 more rows
#> # ℹ 2 more variables: sex <fct>, year <int>
```

Here, this overwrites the existing columns. But these still end in `mm`. To fix that, we can use `.names` argument in `across()` to fix that. We use `str_remove()` on the previous column names (encoded as `.col`) and append the `_cm` ending ourselves.

``` r
penguins |>
  mutate(
    across(
      .cols = ends_with("mm"),
      .fns = divide_by_ten,
      .names = '{str_remove(.col, "_mm")}_cm'
    )
  ) |>
  select(-ends_with("mm")) # remove old columns here
#> # A tibble: 344 × 8
#>    species island    body_mass_g sex     year bill_length_cm bill_depth_cm
#>    <fct>   <fct>           <int> <fct>  <int>          <dbl>         <dbl>
#>  1 Adelie  Torgersen        3750 male    2007           3.91          1.87
#>  2 Adelie  Torgersen        3800 female  2007           3.95          1.74
#>  3 Adelie  Torgersen        3250 female  2007           4.03          1.8 
#>  4 Adelie  Torgersen          NA <NA>    2007          NA            NA   
#>  5 Adelie  Torgersen        3450 female  2007           3.67          1.93
#>  6 Adelie  Torgersen        3650 male    2007           3.93          2.06
#>  7 Adelie  Torgersen        3625 female  2007           3.89          1.78
#>  8 Adelie  Torgersen        4675 male    2007           3.92          1.96
#>  9 Adelie  Torgersen        3475 <NA>    2007           3.41          1.81
#> 10 Adelie  Torgersen        4250 <NA>    2007           4.2           2.02
#> # ℹ 334 more rows
#> # ℹ 1 more variable: flipper_length_cm <dbl>
```

If you found those last steps a bit confusing, don’t worry about it too much. The point here simply is that tidyselect helpers can be used in all kinds of situations. And with that we have learned another tool for our data analysis journey. 🎉 Hope you’ll get lots of value out of this one. Enjoy the rest of your day and see you next time 👋

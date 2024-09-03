library(tidyverse)

uuid <- letters

make_uuid <- function() {
  sample(letters, 10, replace = TRUE) |>
    str_c(collapse = "")
}

mtcars |>
  as_tibble() |>
  mutate(uuid = make_uuid())

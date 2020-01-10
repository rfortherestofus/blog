library(tidyverse)

data <- tribble(
  ~name, ~age,
  "Bob", 25,
  "Joe", 10,
  "Jill", "six",
  "Josehpine", 11
)

data

data %>% 
  mutate(age_numeric = parse_number(age))

library(tidyverse)
library(palmerpenguins)

penguins %>% 
  group_by(species) %>% 
  summarize(avg_bill_length = mean(bill_length_mm, na.rm = TRUE))

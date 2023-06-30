
# Packages ----------------------------------------------------------------

library(tidyverse)
library(janitor)


# Get Data ----------------------------------------------------------------

nhanes <- read_csv("excel-to-r/nhanes.csv") %>% 
  clean_names()


# mutate ------------------------------------------------------------------

nhanes %>%
  mutate(height_inches = height / 2.54) %>% 
  select(height, height_inches)

sleep_by_gender <- nhanes %>% 
  add_row(gender = NA, sleep_hrs_night = 9) %>% 
  group_by(gender) %>% 
  summarize(mean_sleep = mean(sleep_hrs_night, na.rm = TRUE)) %>% 
  drop_na(gender)

# summarize ---------------------------------------------------------------




# group_by ----------------------------------------------------------------



# arrange -----------------------------------------------------------------




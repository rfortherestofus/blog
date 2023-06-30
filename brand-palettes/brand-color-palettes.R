# Load Packages -----------------------------------------------------------

library(tidyverse)

# Define Colors -----------------------------------------------------------

ga_purple <- "#8359AB"
ga_yellow <- "#FFDE39"
ga_gray <- "#827C78"
ga_blue <- "#49B8F1"
ga_brown <- "#B88262"
ga_pink <- "#DC458E"


# Qualitative -------------------------------------------------------------

scale_color_ga_qualitative <- function() {
  
  scale_color_manual(values = c(ga_blue, 
                                ga_pink, 
                                ga_yellow, 
                                ga_purple, 
                                ga_gray, 
                                ga_brown))
  
}

palmerpenguins::penguins %>%
  ggplot() +
  geom_point(aes(x = bill_length_mm, 
                 y = flipper_length_mm,
                 color = island)) +
  labs(title = "Palmer Penguins", 
       subtitle = "Look at them go!",
       x = "Bill length",
       y = "Flipper length") +
  theme_minimal() +
  scale_color_ga_qualitative()


# Download Data -----------------------------------------------------------

library(tigris)

# Downloaded from https://github.com/tonmcg/US_County_Level_Election_Results_08-20
presidential_returns_by_county <- read_csv("https://github.com/tonmcg/US_County_Level_Election_Results_08-20/raw/master/2020_US_County_Level_Presidential_Results.csv")

# Done with tigris package
us_counties <- counties()

# Merge datasets
nc_presidential_returns_by_county <- us_counties %>% 
  left_join(presidential_returns_by_county,
            by = c("GEOID" = "county_fips")) %>% 
  filter(state_name == "North Carolina") %>% 
  mutate(county_name = str_remove(county_name, " County")) %>% 
  select(county_name, contains("votes"), per_point_diff) 

# Sequential --------------------------------------------------------------

scale_fill_ga_sequential <- function(low_color = ga_yellow, 
                                     high_color = ga_purple) {
  
  scale_fill_gradient(low = low_color, 
                      high = high_color)
  
}

nc_presidential_returns_by_county %>% 
  ggplot(aes(fill = total_votes)) +
  geom_sf() +
  theme_void() +
  scale_fill_ga_sequential()

nc_presidential_returns_by_county %>% 
  ggplot(aes(fill = total_votes)) +
  geom_sf() +
  theme_void() +
  scale_fill_ga_sequential(low_color = ga_purple,
                           high_color = ga_yellow)


# Diverging ---------------------------------------------------------------

scale_fill_ga_diverging <- function(low_color = ga_yellow, 
                                    medium_color = "white",
                                    high_color = ga_pink) {
  
  scale_fill_gradient2(low = low_color, 
                       mid = medium_color,
                       high = high_color)
  
}

nc_presidential_returns_by_county %>% 
  ggplot(aes(fill = per_point_diff)) +
  geom_sf() +
  theme_void() +
  scale_fill_ga_diverging()

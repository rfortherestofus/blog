library(tidyverse)
library(tidycensus)
library(janitor)


oregon_counties_population <- get_acs(year = 2019,
        geography = "county",
        state =  "OR",
        variables = "B01003_001") %>% 
  clean_names() %>% 
  mutate(name = str_remove(name, " County, Oregon")) %>% 
  rename(total_population = estimate,
         county = name) %>% 
  select(county, total_population)




oregon_covid_data <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us-counties.csv") %>% 
  filter(state  == "Oregon") %>% 
  select(county, cases)

population_and_covid_data <- oregon_counties_population %>%
  left_join(oregon_covid_data) %>%
  mutate(cases_per_100k = cases / (total_population / 100000))

population_and_covid_data %>%
  ggplot(aes(1, 1,
             size = total_population,
             stroke = cases_per_100k)) +
  geom_point(shape = 21,
             fill = "red") +
  theme_void() +
  theme(legend.position = "none") +
  facet_wrap(~county)

ggsave(filename = "temp.pdf", 
       device = cairo_pdf)


# Load Packages -----------------------------------------------------------

library(tidyverse)
library(rvest)
library(janitor)
library(lubridate)
library(hrbrthemes)


# Get Supreme Court Nomination Data ---------------------------------------

# Source: https://www.senate.gov/legislative/nominations/SupremeCourtNominations1789present.htm

supreme_court_data <- read_html("https://www.senate.gov/legislative/nominations/SupremeCourtNominations1789present.htm") %>% 
  html_node("table") %>% 
  html_table(fill = TRUE) %>% 
  rename(nominee = X1,
         president = X2,
         nomination_date = X5,
         vote_date = X11) %>% 
  select(nominee, president, nomination_date, vote_date) %>% 
  slice(6:205) %>% 
  mutate(president = na_if(president, "")) %>% 
  fill(president, .direction = "down") %>% 
  filter(str_detect(nomination_date, "President", negate = TRUE)) %>% 
  add_row(nominee = "Coney Barrett, Amy",
          president = "President Trump, Donald",
          nomination_date = "Sep 26, 2020",
          vote_date = NA) %>% 
  mutate(nomination_date = mdy(nomination_date)) %>% 
  mutate(vote_date = mdy(vote_date)) %>% 
  mutate(year = year(nomination_date)) %>% 
  arrange(desc(nomination_date))





# Get Presidential Elections Data -----------------------------------------

# Source: https://www.thegreenpapers.com/Hx/PresidentialElectionEvents.phtml

presidential_election_data <- read_html("https://www.thegreenpapers.com/Hx/PresidentialElectionEvents.phtml") %>% 
  html_node("table") %>% 
  html_table(fill = TRUE) %>% 
  select(X2) %>% 
  set_names("election_date") %>% 
  slice(3:60) %>% 
  add_row(election_date = "3 November 2020") %>% 
  mutate(election_date = str_remove(election_date, "\\*")) %>% 
  mutate(election_date = dmy(election_date)) %>% 
  mutate(year = year(election_date)) %>% 
  arrange(desc(election_date))


# Join Data ---------------------------------------------------------------

supreme_court_and_election_data <- supreme_court_data %>% 
  left_join(presidential_election_data, by = "year") %>% 
  drop_na(election_date) %>% 
  mutate(days_between_nomination_and_election = election_date - nomination_date) %>% 
  filter(days_between_nomination_and_election > 0) %>% 
  select(-c(vote_date, year)) %>% 
  mutate(election_day = 0) %>% 
  separate(nominee, sep = ",", into = c("nominee", NA)) %>% 
  distinct(nominee, .keep_all = TRUE) %>% 
  mutate(days_between_nomination_and_election = days_between_nomination_and_election * -1) %>% 
  # mutate(nominee = str_glue("{nominee} ({year(nomination_date)})")) %>% 
  mutate(nominee = str_glue("{nominee}  ")) %>% 
  mutate(nominee = fct_reorder(nominee, days_between_nomination_and_election)) %>% 
  mutate(year_label = str_glue("  {year(election_date)}"))
 

# Plot --------------------------------------------------------------------


ggplot() +
  geom_point(data = supreme_court_and_election_data,
             aes(days_between_nomination_and_election, nominee),
             color = "#6cabdd") +
  geom_point(data = supreme_court_and_election_data,
             aes(0, nominee),
             color = "#6cabdd") +
  geom_curve(data = supreme_court_and_election_data,
             aes(x = days_between_nomination_and_election,
                 xend = 0,
                 y = nominee,
                 yend = nominee),
             curvature = 0.1,
             color = "#6cabdd") +
  geom_text(data = supreme_court_and_election_data,
            aes(days_between_nomination_and_election, nominee,
                label = nominee),
            hjust = 1,
            family = "Inter") +
  geom_text(data = supreme_court_and_election_data,
            aes(0, nominee,
                label = year_label),
            hjust = 0,
            family = "Inter") +
  labs(title = "Amy Coney Barrett is the Supreme Court justice nominated closet to an election") +
  scale_x_continuous(expand = c(0.5, 1)) +
  theme_ipsum(base_family = "Inter",
              grid = FALSE,
              axis_text_size = 0,
              axis_title_size = 0)

ggsave(here::here("supreme-court/supreme-court.png"),
                  height = 20)
  
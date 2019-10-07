
# Load packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(googlesheets)
library(gmailr)


# Get list of recipients --------------------------------------------------

all_respondents <- gs_title("Automated Survey Administration") %>% 
  gs_read(ws = "List of Respondents")


# Send message to all respondents to take survey --------------------------

dk_send_survey_link <- function(respondent) {
  message <- mime() %>%
    to(respondent) %>%
    from("David Keyes <david@rfortherestofus.com>") %>%
    subject("It's survey time!") %>% 
    text_body("Hi friend, it's time to complete the survey. Here's the link: https://forms.gle/QRs5DaGusEZQT3Ux6") 
  
  send_message(message)
}

walk(all_respondents$email_address, dk_send_survey_link)


# Send message to those who have not completed the survey -----------------

completers <- gs_title("Automated Survey Administration") %>% 
  gs_read(ws = "Survey responses") %>% 
  clean_names() 

non_completers <- all_respondents %>% 
  anti_join(completers)

dk_send_survey_reminder <- function(respondent) {
  message <- mime() %>%
    to(respondent) %>%
    from("David Keyes <david@rfortherestofus.com>") %>%
    subject("Did you forget something?") %>% 
    text_body("Hi friend, looks like you forgot to complete the survey. Snap to it! Here's the link: https://forms.gle/QRs5DaGusEZQT3Ux6") 
  
  send_message(message)
}

walk(non_completers$email_address, dk_send_survey_reminder)




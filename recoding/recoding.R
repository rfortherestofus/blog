
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(readxl)
library(janitor)


# Import Data -------------------------------------------------------------

import_recoding_guide <- function(range_to_import, new_column_name) {
  read_excel("recoding/Random Data Set.xlsx",
             sheet = "Codebook",
             range = range_to_import) %>% 
    clean_names() %>% 
    set_names(c("numeric_value", new_column_name))
}

interview_types <- import_recoding_guide("A1:B5", "interview_type_char")

diagnosis <- import_recoding_guide("A9:B90", "diagnosis_char")

gender <- import_recoding_guide("E1:F5", "gender_char")

overall_health_rating <- import_recoding_guide("E9:F18", "overall_health_rating_char")

substance_use <- import_recoding_guide("E21:F30", "substance_use_char")

belonging <- import_recoding_guide("E33:F41", "belonging_char")

symptoms <- import_recoding_guide("I1:J10", "symptoms_char")

enrolled <- import_recoding_guide("I13:J21", "enrolled_char")

perception_of_care <- import_recoding_guide("I24:J33", "perception_of_care_char")



hmis_data <- read_excel("recoding/Random Data Set.xlsx",
                        sheet = "Sheet1") %>% 
  clean_names() %>% 
  left_join(interview_types, by = c("interview_type" = "numeric_value")) %>% 
  left_join(diagnosis, by = c("diagnosis_1" = "numeric_value")) %>% 
  left_join(diagnosis, by = c("diagnosis_2" = "numeric_value")) %>% 
  left_join(gender, by = c("gender" = "numeric_value")) %>% 
  left_join(overall_health_rating, by = c("rate_overall_health_right_now" = "numeric_value")) %>% 
  left_join(substance_use, by = c("alcohol_use" = "numeric_value")) %>% 
  select(client_id, contains("char"))
  


hmis_data_original <- read_excel("recoding/Random Data Set.xlsx",
                                 sheet = "Sheet1") %>% 
  clean_names()


hmis_data_original %>% 
  count(gender)

hmis_data %>% 
  count(gender_char)

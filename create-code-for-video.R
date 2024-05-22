qmd_file <- "set-consistent-limits/set-consistent-limits.qmd"



# Load Packages -----------------------------------------------------------

library(tidyverse)
library(knitr)
library(xfun)
library(rstudioapi)
library(fs)


# Create R Script File ----------------------------------------------------

rscript_file <- str_replace(
  qmd_file,
  ".qmd",
  ".R"
)

file_delete(rscript_file)

purl(
  input = qmd_file,
  output = rscript_file
)



# Remove Unneeded Text from R Script File ---------------------------------

remove_unneeded_text <- function(string_to_remove) {
  gsub_file(
    file = rscript_file,
    string_to_remove,
    ""
  )
}

text_to_remove <- c(
  "## --------------------------------------------------------------------------------------------------------------------------------",
  "#\\| echo: true",
  "#\\| eval: false"
)

walk(text_to_remove, remove_unneeded_text)

# Open R Script File ------------------------------------------------------

documentOpen(rscript_file)

# Load packages ----------------------------------------------------------

library(tidyverse)
library(pdftools)
library(magick)
library(quarto)
library(fs)
library(here)


# Functions --------------------------------------------------------------

change_file_name <- function(current_name, new_name) {
  if (file_exists(current_name)) {
    file_copy(
      here(current_name),
      here(new_name),
      overwrite = TRUE
    )
  }
  file_delete(here(current_name))
}

render_and_save_png <- function(
  quarto_path,
  dpi = 150,
  page_number = 1
) {
  here(quarto_path) |>
    quarto_render()

  pdf_path <-
    quarto_path |>
    str_replace(
      "\\.qmd",
      ".pdf"
    ) |>
    here()

  output_path <-
    quarto_path |>
    str_replace(
      "\\.qmd",
      ".png"
    ) |>
    str_replace(
      "typst-reports/",
      "typst-blog-post/"
    ) |>
    here()

  # Convert first page to image

  message(glue::glue("✓ PNG saved to: {output_path}"))

  pdf_path |>
    pdf_convert(format = "png", dpi = dpi, pages = page_number) |>
    image_read() |>
    image_shadow() |>
    image_write(output_path)

  return(invisible(output_path))
}


# Generate images --------------------------------------------------------

render_and_save_png("typst-reports/typst-report-typst.qmd")

render_and_save_png("typst-reports/typst-report-typst-yaml-options.qmd")

change_file_name(
  "typst-reports/__brand.yml",
  "typst-reports/_brand.yml"
)

render_and_save_png("typst-reports/typst-report-brandyml.qmd")

change_file_name(
  "typst-reports/_brand.yml",
  "typst-reports/__brand.yml"
)

change_file_name(
  "typst-reports/typst-template-basic.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png("typst-reports/typst-report-typst-basic.qmd")

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-basic.typ"
)

change_file_name(
  "typst-reports/typst-template-paper.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png("typst-reports/typst-report-typst-paper.qmd")

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-paper.typ"
)


change_file_name(
  "typst-reports/typst-template-text.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png("typst-reports/typst-report-typst-text.qmd")

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-text.typ"
)

change_file_name(
  "typst-reports/typst-template-headings-basic.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png("typst-reports/typst-report-typst-headings-basic.qmd")

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-headings-basic.typ"
)

change_file_name(
  "typst-reports/typst-template-headings-complex.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png("typst-reports/typst-report-typst-headings-complex.qmd")

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-headings-complex.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-footer.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png("typst-reports/typst-report-typst-footer.qmd")

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-footer.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-footer-content.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png("typst-reports/typst-report-typst-footer-content.qmd")

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-footer-content.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-footer-content-padding.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-footer-content-padding.qmd"
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-footer-content-padding.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-footer-date-formatting.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-footer-date-formatting.qmd"
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-footer-date-formatting.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-logo.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-logo.qmd"
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-logo.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-logo-title.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-logo-title.qmd"
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-logo-title.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-logo-title-flag.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-logo-title-flag.qmd"
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-logo-title-flag.typ"
)


change_file_name(
  "typst-reports/typst-template-typst-blueline.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-blueline.qmd"
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-blueline.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-source-text.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-source-text.qmd",
  page_number = 2
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-source-text.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-status-boxes.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-status-boxes.qmd",
  page_number = 3
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-status-boxes.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-gray-box.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-gray-box.qmd",
  page_number = 2
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-gray-box.typ"
)

change_file_name(
  "typst-reports/typst-template-typst-gray-box-two-columns.typ",
  "typst-reports/typst-template.typ"
)

render_and_save_png(
  "typst-reports/typst-report-typst-gray-box-two-columns.qmd"
)

change_file_name(
  "typst-reports/typst-template.typ",
  "typst-reports/typst-template-typst-gray-box-two-columns.typ"
)


library(tidyverse)
library(gt)


ferrari_data <- gtcars |>
  select(
    manufacturer = mfr,
    model,
    year,
    horsepower = hp
  ) |> 
  filter(manufacturer == 'Ferrari') |> 
  arrange(horsepower)

ferrari_table <- gt(ferrari_data) |> 
  cols_label(
    manufacturer = 'Manufacturer',
    model = 'Model',
    year = 'Year',
    horsepower = 'Horsepower'
  ) |> 
  tab_header(
    title = 'Ferrari & Horsepower',
    subtitle = 'Data is courtesy of the {gt} R package'
  )

ferrari_table 


my_gt_theme <- function(gt_tbl) {
  
  n_rows <- nrow(gt_tbl$`_data`)
  gt_tbl |> 
    tab_options(
      data_row.padding = px(6),
      heading.align = 'left',
      column_labels.background.color = 'dodgerblue4',
      heading.title.font.size = px(26),
      heading.subtitle.font.size = px(14),
      table_body.hlines.width = px(0)
    ) |> 
    tab_style(
      style = cell_text(
        color = 'dodgerblue4', 
        weight = 'bold', 
        font = google_font('Merriweather')
      ),
      locations = cells_title(groups = 'title')
    ) |> 
    tab_style(
      style = cell_fill(color = 'grey90'),
      locations = cells_body(rows = seq(1, n_rows, 2))
    )
}

ferrari_table |> 
  my_gt_theme()





new_table <- towny |> 
  select(name, status, land_area_km2) |> 
  slice(1:10) |> 
  gt() |> 
  cols_label(
    name = 'Name',
    status = 'Status',
    land_area_km2 = 'Area (in sq. km)'
  ) |> 
  tab_header(
    title = 'Selected Municipalities',
    subtitle = 'Data comes from the gt package'
  ) 

new_table |> 
  my_gt_theme() 





























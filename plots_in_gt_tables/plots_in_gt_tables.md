# Spice up your `gt` table with `ggplot`
Albert Rapp
2023-09-18

- [A basic table](#a-basic-table)
- [Spice up your table](#spice-up-your-table)

Have you ever created a table with `gt` and thought to yourself *“Well,
maybe just showing the numbers doesn’t cut it? I need to add some visual
spice to this table.”* If so, then you’re in great company. Because
spicing up tables with visuals is one of my favorite tricks. I like to
add visual elements like small lines or bars to tables.

Apart from making your table pretty, visuals help to convey an overall
impression of the data to your reader. So, let me show you how you can
add any chart to your table by combining the powers of `gt` and
`ggplot`.

## A basic table

Basically, we need two ingredients. The first thing is a table that we
want to spice up. And then we need ggplots that we can add. Let’s start
with the table. Here, we have a basic table summarizing the penguin
weights of three different species.

``` r
library(tidyverse)
library(gt)
penguin_weights <- palmerpenguins::penguins |>
  summarise(
    min = min(body_mass_g, na.rm = TRUE),
    mean = mean(body_mass_g, na.rm = TRUE),
    max = max(body_mass_g, na.rm = TRUE),
    .by = 'species'
  )

penguin_weights |>
  gt() |>
  tab_spanner(
    label = 'Penguin\'s Weight',
    columns = -species
  ) |> 
  cols_label_with(fn = str_to_title) |> 
  fmt_number(decimals = 2) |> 
  cols_align('left', columns = species)
```

<div id="jwkcncfwmx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jwkcncfwmx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#jwkcncfwmx thead, #jwkcncfwmx tbody, #jwkcncfwmx tfoot, #jwkcncfwmx tr, #jwkcncfwmx td, #jwkcncfwmx th {
  border-style: none;
}
&#10;#jwkcncfwmx p {
  margin: 0;
  padding: 0;
}
&#10;#jwkcncfwmx .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#jwkcncfwmx .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#jwkcncfwmx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#jwkcncfwmx .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#jwkcncfwmx .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#jwkcncfwmx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#jwkcncfwmx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#jwkcncfwmx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#jwkcncfwmx .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#jwkcncfwmx .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#jwkcncfwmx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#jwkcncfwmx .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#jwkcncfwmx .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#jwkcncfwmx .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#jwkcncfwmx .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jwkcncfwmx .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#jwkcncfwmx .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#jwkcncfwmx .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#jwkcncfwmx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jwkcncfwmx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#jwkcncfwmx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jwkcncfwmx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#jwkcncfwmx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jwkcncfwmx .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#jwkcncfwmx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jwkcncfwmx .gt_left {
  text-align: left;
}
&#10;#jwkcncfwmx .gt_center {
  text-align: center;
}
&#10;#jwkcncfwmx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#jwkcncfwmx .gt_font_normal {
  font-weight: normal;
}
&#10;#jwkcncfwmx .gt_font_bold {
  font-weight: bold;
}
&#10;#jwkcncfwmx .gt_font_italic {
  font-style: italic;
}
&#10;#jwkcncfwmx .gt_super {
  font-size: 65%;
}
&#10;#jwkcncfwmx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#jwkcncfwmx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#jwkcncfwmx .gt_indent_1 {
  text-indent: 5px;
}
&#10;#jwkcncfwmx .gt_indent_2 {
  text-indent: 10px;
}
&#10;#jwkcncfwmx .gt_indent_3 {
  text-indent: 15px;
}
&#10;#jwkcncfwmx .gt_indent_4 {
  text-indent: 20px;
}
&#10;#jwkcncfwmx .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    &#10;    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="Species">Species</th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="Penguin's Weight">
        <span class="gt_column_spanner">Penguin's Weight</span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Min">Min</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Mean">Mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Max">Max</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="species" class="gt_row gt_left">Adelie</td>
<td headers="min" class="gt_row gt_right">2,850.00</td>
<td headers="mean" class="gt_row gt_right">3,700.66</td>
<td headers="max" class="gt_row gt_right">4,775.00</td></tr>
    <tr><td headers="species" class="gt_row gt_left">Gentoo</td>
<td headers="min" class="gt_row gt_right">3,950.00</td>
<td headers="mean" class="gt_row gt_right">5,076.02</td>
<td headers="max" class="gt_row gt_right">6,300.00</td></tr>
    <tr><td headers="species" class="gt_row gt_left">Chinstrap</td>
<td headers="min" class="gt_row gt_right">2,700.00</td>
<td headers="mean" class="gt_row gt_right">3,733.09</td>
<td headers="max" class="gt_row gt_right">4,800.00</td></tr>
  </tbody>
  &#10;  
</table>
</div>

In this table, we can see the minimum, maximum and mean values of the
penguin weights for every species. Not the most exciting table, is it?
So, we may want to add a nice visual element like a violin plot. Apart
from being an eye-catching element, this would also add more information
on the distribution of the weights. The resulting table could look
something like this:

<div id="qvqihjeglf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#qvqihjeglf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#qvqihjeglf thead, #qvqihjeglf tbody, #qvqihjeglf tfoot, #qvqihjeglf tr, #qvqihjeglf td, #qvqihjeglf th {
  border-style: none;
}
&#10;#qvqihjeglf p {
  margin: 0;
  padding: 0;
}
&#10;#qvqihjeglf .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#qvqihjeglf .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#qvqihjeglf .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#qvqihjeglf .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#qvqihjeglf .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#qvqihjeglf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#qvqihjeglf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#qvqihjeglf .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#qvqihjeglf .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#qvqihjeglf .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#qvqihjeglf .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#qvqihjeglf .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#qvqihjeglf .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#qvqihjeglf .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#qvqihjeglf .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#qvqihjeglf .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#qvqihjeglf .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#qvqihjeglf .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#qvqihjeglf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#qvqihjeglf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#qvqihjeglf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#qvqihjeglf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#qvqihjeglf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#qvqihjeglf .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#qvqihjeglf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#qvqihjeglf .gt_left {
  text-align: left;
}
&#10;#qvqihjeglf .gt_center {
  text-align: center;
}
&#10;#qvqihjeglf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#qvqihjeglf .gt_font_normal {
  font-weight: normal;
}
&#10;#qvqihjeglf .gt_font_bold {
  font-weight: bold;
}
&#10;#qvqihjeglf .gt_font_italic {
  font-style: italic;
}
&#10;#qvqihjeglf .gt_super {
  font-size: 65%;
}
&#10;#qvqihjeglf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#qvqihjeglf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#qvqihjeglf .gt_indent_1 {
  text-indent: 5px;
}
&#10;#qvqihjeglf .gt_indent_2 {
  text-indent: 10px;
}
&#10;#qvqihjeglf .gt_indent_3 {
  text-indent: 15px;
}
&#10;#qvqihjeglf .gt_indent_4 {
  text-indent: 20px;
}
&#10;#qvqihjeglf .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    &#10;    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="Species">Species</th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="Penguin's Weight">
        <span class="gt_column_spanner">Penguin's Weight</span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Min">Min</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Mean">Mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Max">Max</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Distribution">Distribution</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="species" class="gt_row gt_left">Adelie</td>
<td headers="min" class="gt_row gt_right">2,850.00</td>
<td headers="mean" class="gt_row gt_right">3,700.66</td>
<td headers="max" class="gt_row gt_right">4,775.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwCr3/wOEGFgnVWVQRwAAAABJRU5ErkJggg==" style="height:50px;"></td></tr>
    <tr><td headers="species" class="gt_row gt_left">Gentoo</td>
<td headers="min" class="gt_row gt_right">3,950.00</td>
<td headers="mean" class="gt_row gt_right">5,076.02</td>
<td headers="max" class="gt_row gt_right">6,300.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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" style="height:50px;"></td></tr>
    <tr><td headers="species" class="gt_row gt_left">Chinstrap</td>
<td headers="min" class="gt_row gt_right">2,700.00</td>
<td headers="mean" class="gt_row gt_right">3,733.09</td>
<td headers="max" class="gt_row gt_right">4,800.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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" style="height:50px;"></td></tr>
  </tbody>
  &#10;  
</table>
</div>

## Spice up your table

To build this, let’s think about how to create the ggplots. Then, we can
think about how to add them to the table. So, let us extract the data
for one species and save it into a variable. If we can do this for one
species, we can do it for all species.

``` r
gentoo_data <- palmerpenguins::penguins |>
  filter(species == 'Gentoo') 
```

Then, we can turn this into a violin plot with `geom_violin()`.

``` r
gentoo_data |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  geom_violin(fill = 'dodgerblue4') 
```

<img
src="plots_in_gt_tables_files/figure-commonmark/unnamed-chunk-4-1.png"
style="width:70.0%" />

Nice. It’s a pretty violin plot but notice that we have a lot of grid
lines and a lot of other stuff that we don’t want to bring into our
table. If we would take this image and put it into our table, this will
be too much clutter, right?. So let’s remove all of this with
`theme_void()`.

``` r
gentoo_data |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  geom_violin(fill = 'dodgerblue4') +
  theme_void() 
```

<img
src="plots_in_gt_tables_files/figure-commonmark/unnamed-chunk-5-1.png"
style="width:70.0%" />

Perfect. Now, let’s wrap this into a function that can repeat this for
all species based on the species name. We want to repeat this for every
species, remember?

``` r
plot_violin_species <- function(my_species) {
  palmerpenguins::penguins |>
    filter(species == my_species) |>
    ggplot(aes(x = body_mass_g, y = species)) +
    geom_violin(fill = 'dodgerblue4') +
    theme_void() 
}
```

Next, we need an additional column in our data set where the plots will
live in. At first, this column is only supposed to contain the data that
`plot_violin_species()` needs to generates plots.

``` r
penguin_weights |>
  mutate(Distribution = species) |>
  gt() |>
  tab_spanner(
    label = 'Penguin\'s Weight',
    columns = -species
  ) |> 
  cols_label_with(fn = str_to_title) |> 
  fmt_number(decimals = 2) |> 
  cols_align('left', columns = species)
```

<div id="eqpxziivil" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#eqpxziivil table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#eqpxziivil thead, #eqpxziivil tbody, #eqpxziivil tfoot, #eqpxziivil tr, #eqpxziivil td, #eqpxziivil th {
  border-style: none;
}
&#10;#eqpxziivil p {
  margin: 0;
  padding: 0;
}
&#10;#eqpxziivil .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#eqpxziivil .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#eqpxziivil .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#eqpxziivil .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#eqpxziivil .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#eqpxziivil .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#eqpxziivil .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#eqpxziivil .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#eqpxziivil .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#eqpxziivil .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#eqpxziivil .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#eqpxziivil .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#eqpxziivil .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#eqpxziivil .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#eqpxziivil .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#eqpxziivil .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#eqpxziivil .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#eqpxziivil .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#eqpxziivil .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#eqpxziivil .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#eqpxziivil .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#eqpxziivil .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#eqpxziivil .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#eqpxziivil .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#eqpxziivil .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#eqpxziivil .gt_left {
  text-align: left;
}
&#10;#eqpxziivil .gt_center {
  text-align: center;
}
&#10;#eqpxziivil .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#eqpxziivil .gt_font_normal {
  font-weight: normal;
}
&#10;#eqpxziivil .gt_font_bold {
  font-weight: bold;
}
&#10;#eqpxziivil .gt_font_italic {
  font-style: italic;
}
&#10;#eqpxziivil .gt_super {
  font-size: 65%;
}
&#10;#eqpxziivil .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#eqpxziivil .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#eqpxziivil .gt_indent_1 {
  text-indent: 5px;
}
&#10;#eqpxziivil .gt_indent_2 {
  text-indent: 10px;
}
&#10;#eqpxziivil .gt_indent_3 {
  text-indent: 15px;
}
&#10;#eqpxziivil .gt_indent_4 {
  text-indent: 20px;
}
&#10;#eqpxziivil .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    &#10;    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="Species">Species</th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="Penguin's Weight">
        <span class="gt_column_spanner">Penguin's Weight</span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Min">Min</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Mean">Mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Max">Max</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Distribution">Distribution</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="species" class="gt_row gt_left">Adelie</td>
<td headers="min" class="gt_row gt_right">2,850.00</td>
<td headers="mean" class="gt_row gt_right">3,700.66</td>
<td headers="max" class="gt_row gt_right">4,775.00</td>
<td headers="Distribution" class="gt_row gt_center">Adelie</td></tr>
    <tr><td headers="species" class="gt_row gt_left">Gentoo</td>
<td headers="min" class="gt_row gt_right">3,950.00</td>
<td headers="mean" class="gt_row gt_right">5,076.02</td>
<td headers="max" class="gt_row gt_right">6,300.00</td>
<td headers="Distribution" class="gt_row gt_center">Gentoo</td></tr>
    <tr><td headers="species" class="gt_row gt_left">Chinstrap</td>
<td headers="min" class="gt_row gt_right">2,700.00</td>
<td headers="mean" class="gt_row gt_right">3,733.09</td>
<td headers="max" class="gt_row gt_right">4,800.00</td>
<td headers="Distribution" class="gt_row gt_center">Chinstrap</td></tr>
  </tbody>
  &#10;  
</table>
</div>

In this table you can see that each row of the `Distribution` column now
contains a species name. Now, we have to instruct `gt()` to transform
the content of the `Distribution` column to actual images. And the way
to do that is to use `text_transform()`, `map()` and the
`ggplot_image()` helper function. Take a look at the code that does this
and I’ll explain more afterwards.

``` r
penguin_weights |>
  mutate(Distribution = species) |>
  gt() |>
  tab_spanner(
    label = 'Penguin\'s Weight',
    columns = -species
  ) |> 
  cols_label_with(fn = str_to_title) |> 
  fmt_number(decimals = 2) |> 
  cols_align('left', columns = species) |> 
  text_transform(
    locations = cells_body(columns = 'Distribution'),
    fn = function(column) {
      map(column, plot_violin_species) |>
        ggplot_image(height = px(50), aspect_ratio = 3)
    }
  ) 
```

I know that this looks complicated at first but here’s the rundown:

- First, `text_transform()` needs to know the locations of the cells
  that we want to transform. This information comes from
  `cells_body(columns = 'Distribution')`.

- Second, `text_transform()` needs a function that takes the whole data
  that is stored in the “Distribution” column and generates **images**
  from this.

This latter function that generates images is defined via

``` r
function(column) {
  map(column, plot_violin_species) |>
    ggplot_image(height = px(50), aspect_ratio = 3)
}
```

This does two things:

1.  In the first step `map()` applies `plot_violin_species()` for every
    species. This will give us a list of **ggplot-objects**. This is not
    what `text_transform()` wants. It wants images.

2.  Then, the list of **ggplot-objects** is turned into images with the
    convenient `ggplot_image()` function from `gt`.

Now that we understand what’s going on with this, let’s see this in
action.

``` r
penguin_weights |>
  mutate(Distribution = species) |>
  gt() |>
  tab_spanner(
    label = 'Penguin\'s Weight',
    columns = -species
  ) |> 
  cols_label_with(fn = str_to_title) |> 
  fmt_number(decimals = 2) |> 
  cols_align('left', columns = species) |> 
  text_transform(
    locations = cells_body(columns = 'Distribution'),
    fn = function(column) {
      map(column, plot_violin_species) |>
        ggplot_image(height = px(50), aspect_ratio = 3)
    }
  ) 
```

<div id="yzcdrxtwji" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#yzcdrxtwji table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#yzcdrxtwji thead, #yzcdrxtwji tbody, #yzcdrxtwji tfoot, #yzcdrxtwji tr, #yzcdrxtwji td, #yzcdrxtwji th {
  border-style: none;
}
&#10;#yzcdrxtwji p {
  margin: 0;
  padding: 0;
}
&#10;#yzcdrxtwji .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#yzcdrxtwji .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#yzcdrxtwji .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#yzcdrxtwji .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#yzcdrxtwji .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#yzcdrxtwji .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#yzcdrxtwji .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#yzcdrxtwji .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#yzcdrxtwji .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#yzcdrxtwji .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#yzcdrxtwji .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#yzcdrxtwji .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#yzcdrxtwji .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#yzcdrxtwji .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#yzcdrxtwji .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yzcdrxtwji .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#yzcdrxtwji .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#yzcdrxtwji .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#yzcdrxtwji .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yzcdrxtwji .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#yzcdrxtwji .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yzcdrxtwji .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#yzcdrxtwji .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yzcdrxtwji .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#yzcdrxtwji .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yzcdrxtwji .gt_left {
  text-align: left;
}
&#10;#yzcdrxtwji .gt_center {
  text-align: center;
}
&#10;#yzcdrxtwji .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#yzcdrxtwji .gt_font_normal {
  font-weight: normal;
}
&#10;#yzcdrxtwji .gt_font_bold {
  font-weight: bold;
}
&#10;#yzcdrxtwji .gt_font_italic {
  font-style: italic;
}
&#10;#yzcdrxtwji .gt_super {
  font-size: 65%;
}
&#10;#yzcdrxtwji .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#yzcdrxtwji .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#yzcdrxtwji .gt_indent_1 {
  text-indent: 5px;
}
&#10;#yzcdrxtwji .gt_indent_2 {
  text-indent: 10px;
}
&#10;#yzcdrxtwji .gt_indent_3 {
  text-indent: 15px;
}
&#10;#yzcdrxtwji .gt_indent_4 {
  text-indent: 20px;
}
&#10;#yzcdrxtwji .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    &#10;    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="Species">Species</th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="Penguin's Weight">
        <span class="gt_column_spanner">Penguin's Weight</span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Min">Min</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Mean">Mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Max">Max</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Distribution">Distribution</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="species" class="gt_row gt_left">Adelie</td>
<td headers="min" class="gt_row gt_right">2,850.00</td>
<td headers="mean" class="gt_row gt_right">3,700.66</td>
<td headers="max" class="gt_row gt_right">4,775.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADw5/k/lnkmAvq99BgAAAAASUVORK5CYII=" style="height:50px;"></td></tr>
    <tr><td headers="species" class="gt_row gt_left">Gentoo</td>
<td headers="min" class="gt_row gt_right">3,950.00</td>
<td headers="mean" class="gt_row gt_right">5,076.02</td>
<td headers="max" class="gt_row gt_right">6,300.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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" style="height:50px;"></td></tr>
    <tr><td headers="species" class="gt_row gt_left">Chinstrap</td>
<td headers="min" class="gt_row gt_right">2,700.00</td>
<td headers="mean" class="gt_row gt_right">3,733.09</td>
<td headers="max" class="gt_row gt_right">4,800.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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" style="height:50px;"></td></tr>
  </tbody>
  &#10;  
</table>
</div>

Oh no. It looks like the weights are all very similarly distributed. But
this is clearly not the case because the numbers tell us otherwise.
Also, we have already seen in the first table that the violin plots are
not all in the same location.

The reason why our table doesn’t show this is because
`plot_violin_species()` never takes the whole data set into account.
Remember? We filter the data to only include data on a specific species
data. Hence, the corresponding violin plot is always centered on the
x-axis.

Thus, we need to fix our x-axis in `plot_violin_species()` and set it to
the range of the whole data. We do this by computing the full range and
then set `xlim` in `coord_cartesian()` to that range.

``` r
plot_violin_species <- function(my_species) {
  full_range <- palmerpenguins::penguins |>
    pull(body_mass_g) |>
    range(na.rm = TRUE)

  palmerpenguins::penguins |>
    filter(species == my_species) |>
    ggplot(aes(x = body_mass_g, y = species)) +
    geom_violin(fill = 'dodgerblue4') +
    theme_void() +
    coord_cartesian(xlim = full_range)
}
```

Perfect, now we can rerun our code and our table should look great.

``` r
penguin_weights |>
  mutate(Distribution = species) |>
  gt() |>
  tab_spanner(
    label = 'Penguin\'s Weight',
    columns = -species
  ) |> 
  cols_label_with(fn = str_to_title) |> 
  fmt_number(decimals = 2) |> 
  cols_align('left', columns = species) |> 
  text_transform(
    locations = cells_body(columns = 'Distribution'),
    fn = function(column) {
      map(column, plot_violin_species) |>
        ggplot_image(height = px(50), aspect_ratio = 3)
    }
  ) 
```

<div id="nyzafrdiio" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nyzafrdiio table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#nyzafrdiio thead, #nyzafrdiio tbody, #nyzafrdiio tfoot, #nyzafrdiio tr, #nyzafrdiio td, #nyzafrdiio th {
  border-style: none;
}
&#10;#nyzafrdiio p {
  margin: 0;
  padding: 0;
}
&#10;#nyzafrdiio .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#nyzafrdiio .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#nyzafrdiio .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#nyzafrdiio .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#nyzafrdiio .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#nyzafrdiio .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#nyzafrdiio .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#nyzafrdiio .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#nyzafrdiio .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#nyzafrdiio .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#nyzafrdiio .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#nyzafrdiio .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#nyzafrdiio .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#nyzafrdiio .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#nyzafrdiio .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nyzafrdiio .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#nyzafrdiio .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#nyzafrdiio .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#nyzafrdiio .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nyzafrdiio .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#nyzafrdiio .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nyzafrdiio .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#nyzafrdiio .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nyzafrdiio .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#nyzafrdiio .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nyzafrdiio .gt_left {
  text-align: left;
}
&#10;#nyzafrdiio .gt_center {
  text-align: center;
}
&#10;#nyzafrdiio .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#nyzafrdiio .gt_font_normal {
  font-weight: normal;
}
&#10;#nyzafrdiio .gt_font_bold {
  font-weight: bold;
}
&#10;#nyzafrdiio .gt_font_italic {
  font-style: italic;
}
&#10;#nyzafrdiio .gt_super {
  font-size: 65%;
}
&#10;#nyzafrdiio .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#nyzafrdiio .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#nyzafrdiio .gt_indent_1 {
  text-indent: 5px;
}
&#10;#nyzafrdiio .gt_indent_2 {
  text-indent: 10px;
}
&#10;#nyzafrdiio .gt_indent_3 {
  text-indent: 15px;
}
&#10;#nyzafrdiio .gt_indent_4 {
  text-indent: 20px;
}
&#10;#nyzafrdiio .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    &#10;    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="Species">Species</th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="Penguin's Weight">
        <span class="gt_column_spanner">Penguin's Weight</span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Min">Min</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Mean">Mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Max">Max</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Distribution">Distribution</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="species" class="gt_row gt_left">Adelie</td>
<td headers="min" class="gt_row gt_right">2,850.00</td>
<td headers="mean" class="gt_row gt_right">3,700.66</td>
<td headers="max" class="gt_row gt_right">4,775.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwCr3/wOEGFgnVWVQRwAAAABJRU5ErkJggg==" style="height:50px;"></td></tr>
    <tr><td headers="species" class="gt_row gt_left">Gentoo</td>
<td headers="min" class="gt_row gt_right">3,950.00</td>
<td headers="mean" class="gt_row gt_right">5,076.02</td>
<td headers="max" class="gt_row gt_right">6,300.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABdwAAAH0CAYAAAAnhe8sAAAABmJLR0QAAAAAAAD5Q7t/AAAACXBIWXMAAA9hAAAPYQGoP6dpAAAgAElEQVR4nOzdeZSdd33n+c/399y9bq2SjGUDtiXvQrJVt0pG+EyinOnApNNksikkk54MYW0SwmRhCSEsoSGEEBISOp1MFsgkQBJE3IE0SQgQBMQ4dtWtsmWXF5A3LGtX7VV3fX7f+UMyBobFi6SnlvfrHB2vR7xL59j8nk89/l0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWKMs6wAAAAAAWIfsxhtvrC4uLvbl8/lqmqalJEmKZpZL0zRxd0uSJJXUMbO2uzfMbLnT6SxcccUVC/v27Uuz/gIAAADw/8fgDgAAAABn0Z49e0pLS0tb0zTdYmaXSXqWuz9T0kWycJGkjSbvkxSe6v+GS8tmYdrlR4N0xN2Pmtlhdz9kZg93u92HOp3Ow1NTU+2z9XUBAADgu2NwBwAAAICnJoyMjFwhaTjGeL2ZPcdl203+TH3ds5ZbErtJOXaTSpKGsqVJUakVFENe0fLykJNbIleQW5DszA7vUeZRkit4KvOugncVYlshdpTElpLYUkibMZ8uxxCbiX3jM567wmF5em8I4d4Y4z0hhKk0TacmJydPnM9fKAAAgPWCwR0AAAAAnoBardZvZjdKutFdz3P5LpMqkhRlsZMfUCffH9q5PnVyverkquokPYqhcF76TK6QNpVLl5TvLimfLirfXVS+sxAL6ZyH2Eke+3tddiKY6u5+u6SJJEnGb7vttock+XmJBQAAWKMY3AEAAADgW9izZ09pcXHxf5H0/dH9+SbtkGQu81Z+yFvFjaGZH1S7MKROrle+oh+vXEnaUqE7r0J3ToX2jIqd2Vjozso8htN/R5gxxS9J+vcY4y3tdvvWqampxYzDAQAAVpWVfCIEAAAAgPPquuuuuziXy71Q0n+S2f8q95JbiM3CJmsUn2GNwia1ihvkT/369RXFPCrfnVepM61ie1rl9sk035kLkpu7RwvhDo9xv5l9oVAofOGWW26ZzroZAABgJWNwBwAAALCu1Wq1Z0v6cZm9SO67JKmT602XShcljdJmNQqb5JZ8l59l7QjeVbF9SqXWCZXaJ7zcOuGmGCS5S3ea9Gl3/0y32/3igQMHlrLuBQAAWEkY3AEAAACsO7t37x5qt9svcrf/08x3S1IzPxSXK88Oi6WL1cn1Zp24YphHFTrTKrdOqNw66qXWCQ+KQbKOm75k7v8cQvjnsbGxO8Qd8AAAYJ1jcAcAAACwLuzduzd58MEHn+/uL5HshyXPtXIDcbFySVisPFvdpCfrxFXBPFWpfUqV1lGVm0disTPz2B3wx4P5JyX9Y5Ik/3LrrbfOZ5wKAABw3jG4AwAAAFjTarXaZkkvd9krTX5RGorpQuWyZKHnMrVz/VnnrXpJ2lS5dVQ9rSOqNI+kIbYTybqSfUGKn0iS5BO33Xbbg1l3AgAAnA8M7gAAAADWIhsdHd3t7q9x149LniwXN/t89XJbLm6W29r40NOVxuQqtE+p2jyinuajab4zm0iSK9xtije5+99PTExMiKtnAADAGsXgDgAAAGDN2LNnT25xcfHHXXqd3IdjyKdzla3JfM8V6ua4MuZ8y6VL6mkeVqVxyMut4zK5ueywyT8WQrjp0ksv/bd9+/alWXcCAACcLQzuAAAAAFa93bt3l1ut1ktk4fUmf3Yn35fO9lyVLFQulVuSdR4khdhWpXlYPY1D6mkejqYYZGFaHm9y94+Z2b/W6/VO1p0AAABPB4M7AAAAgFVr27Zt1VKp9POy8Dp53NAsbIozvdeE5eJmyXjcWanMU1VaR9SzfEjV1qOpxU4iswW53yRpX7PZ/PTU1FQ7604AAIAnixMoAAAAgFXnzND+ape9weQDy6XNPtO7zZqFjVmn4Ukyjyq1jqnaeETV5iNpiJ3EpUWTbnL3ffPz858+ePBgK+tOAACAJ4LBHQAAAMCqsXv37nK73X6VLLxJHoeWShf5TN92a+UHs07DWWAeVW4fV0/jEVUbj6Qhtr82vpvZ3zYajc/w5jsAAFjJGNwBAAAArHhnPgz1/3LZO+TxwuXiZp/u226twlDWaThHvnF8/2oazlw7Y9LHYowfNbPPcuc7AABYaRjcAQAAAKxkNjIy8kKX3iP3K5uFTfFU/3WBq2PWF/OocuuYehqPqLd5KLXYTlw2Z/KPmdnfVqvVz+3fv7+bdScAAACDOwAAAIAVaWRkZGeU3mfu39PJ96Une69LlssXiceY9e30m+/HVF3+qqrNQ6nFTuIKM6b4sRjj3/b393+e8R0AAGSFkyoAAACAFWV0dPTCNE3faWY/m4ZinO7bkSz0bJHz+IJvYp6q3DozvrcOpRa7iSxMe0z3ufs+xncAAHC+cWIFAAAAsCJs27atUCqVXuPS2ySrzPVeYzO91ypaLus0rALmqSqto6o2HlFl+ZEYlIbH3nw3s33uvp873wEAwLnG4A4AAAAgc6Ojo/8hjfrvpnjFUuliPzWw0zpJNessrFKmqErziKqNR9TTPP3mu8vmgukmd/+7ubm5zxw8eLCVdScAAFh7GNwBAAAAZOa66667OJ/Pv9fdX9TJVdOTAyPJcvHCrLOwhpy+dua4qo2vqtp89MwHrmrJpE+Y2U2NRuOfp6amFrPuBAAAawODOwAAAIDzbu/evckDDzzw8y79piuUZ/q2hbnq1XJLsk7DGnb6A1ePq9J4RNXGoTSJrcSltkn/YmZ/3263/+HAgQPHs+4EAACrF4M7AAAAgPNqZGRkp0t/Jvfh5dJFfqK/Zt1cT9ZZWG/cVeqcUk/jkKrNR9JcdymR5G727+b+8RjjP0xOTt4jybNOBQAAqweDOwAAAIDzolarVczsbTHGX4m5ip/oryVL5YvFYwmy5yp059XTeFSVxqFY6kyH03/WHjb5J9z9k319fZ/fv39/M+tSAACwsnGyBQAAAHDO1Wq173OFD5jipfM9l+tU33WKIZ91FvAtJWlDPc3DqjQPq9I6Gs3TILOm3D8r6R8lfaper9+fdScAAFh5GNwBAAAAnDM33HBDX5qm73H3V3RyvenxwV1Js7Ap6yzgCTNPVW6fUKV5RJXm4TTfXUikr739/k9m9plWq/Wvd95550zWrQAAIHsM7gAAAADOieHh4RfIwgck3zzXe61N9z1HrpB1FvC05NMlVZpHVW4dVaV1NLXYSSS5zG6X+2fN7HPFYvGLN99880LWrQAA4PxjcAcAAABwVtVqtX53/10ze0kn358eG7ghaRWGss4CzjqTq9ieVrl1TOXWUS+2TniQB50e4Cc9xs9L+mK32735wIEDx7PuBQAA5x6DOwAAAICzZnR09D+k0f9fSZtn+7bZTPVaufFWO9YHU1SpfUql5jGV28e91Drppnj6HwALD5r85hjjv7v7re12+8DU1FQ742QAAHCWMbgDAAAAeNpqtVrF3d9tZq/u5PrSY4PP5a12rHvmUcXurIqtEyq1T6rcOtFNYjN35q923HSHuY+7+4S7T/b399+1f//+ZrbVAADg6WBwBwAAAPC01Gq1G2ThI/K4Zbb3Gk33beeuduDbSNLG6bfgO9MqtE95qTMdw+l74OXu0ULyFZPf7u53ufvdZna3pPvr9Xon43QAAPAEMLgDAAAAeEpqtVpe0pvd/U1prurHhp6bNAubss4CVhlXLm2o2JlWoT2rYndOhc5MN99dSiQ/88xuqUsPmfwed/+KmR00swfd/cFCofDwLbfc0sj2awAAAI9hcAcAAADwpI2MjFzl0kfkPjzfs1Wn+ncqWi7rLGDNME9V6C4o351ToTOvfHdBhXQhzbXnLSj9xv+ExMK05A/L/auSHjWzw5KOuPuxEMLxTqdzotPpnJyamlqS5Fl8PU/VmW/sVWKMPe7eY2aVXC7XI6ni7hVJX/sRYyybWVlS2cxK7l6SVJJUNLOiuxck5R/74a68guVMStwtPP4NDkkyl2LXzFK5OpJ3JLXdvWlmTUlNScuSls1swd3nJc1LmosxTidJMu3upySdrNfry+fr1wsAkD0GdwAAAABPhtVqtVe69D5PirnjA7uSpdLFWTcB64griW3lu4vKdZeUj0vKdZeVS5eUS5fTXGx4SFvf5rtf1nFpTtKsmablPqvTf7xkZksxxqUQQsPdG+7eMrOWpI67dyV1QwhpjDE1Mzczd3dzdwshBHcPZpbEGBNJeTPLSSq4e8HMinp89C6aWenrx3FJZZlVJetxV4+kiuQVk8qSJ0/+VyhEhZxHC+4KckvkFiwqMZmZW2KuIDOT6/SP07889vU/icxc8ii5yxRlnrq5e/Cum6duShU8NYvd5Dt+H8Os4a7jcj1q5o+a2aPufsjMHjazh2OMD9br9VNaZd8MAQB8awzuAAAAAJ6QnTt3bgoh9wEp/qfl0mY/MXiDdUMp6ywA38Q8KsSmcmlTIbaU85aStKUQW0piR8HbCmlbwTueeCda7HhQKovdYB7Dudh9Xeay4G7BXYl7yMktsVSJuSXBQ05RiU7/+ZyiJXLLyUNO0XJyS77ut4/9/uN//NjvuwWd/6nDZZ4qxI6CdxRiW0lsK4mtx390G0piQ/m00c3FhtmZe/sf/xm0JOlgMLvX3e8zs3vTNL17YWHh3oMHD7bO8xcEAHgaGNwBAAAAfFfDw8MvkIUPuTR0amA4zPdcLh4ngLXJPEqeKsglRZlHmfzMm96nx3iXy878O8Al6eveFjcLOv1muZ35bRYj+MoWvKtcuqxcd1H5dEm57uKZK4Tmu7nuUmJnrrc580G6Bz2mE2Z2u6TJJEnqt91226mMvwQAwLfB/+MBAAAA+LYuv/zyYl9f37vM7Jc6hYH0yMDupJPvzzoLANYs86h8uqR8Z1aFzpwKnVmVurPdXHfxa1cFuexhk39J0r/HGL/U399/+/79+7sZZgMAzmBwBwAAAPAtDQ8PX2MhfFTuz5mtXqXpvh1ye9LXKQMAzoLgHRXaMyp1ZlTsnFK5faqbdJdOj/BmDY/6kpnvl7Rf0q31er2TYS4ArFsM7gAAAAC+mQ0PD79MZu+PoZg7PvjcZLm0OesmAMA3SdKGyp1TKrVOqNQ6HoudWZPcZNaQ++ck/YuZ/fP4+PiXxYeyAsB5weAOAAAA4Gu2b98+mM/n/9TMfmy5eKEfH3yupQkfjAoAq0GIHZVax1VpH1OldTTNd+ZP/2dJFh4x+SdijP8wPz+/nw9iBYBzh8EdAAAAgCRpdHT0eWnURyW/aLr/epvtuVIyHhkAYLXKpQ1VWkdVaT6qSvNINE+DzJbl/kkzu6lYLH7y5ptvXsi6EwDWEk7PAAAAwDq3d+/e5IEHHniju/9Gmu/zo0PPS1r5wayzAABnkXmqcvuEehqPqqd5KE3SRiJZR/J/lPTRUqn0D4zvAPD0MbgDAAAA69jOnTsvsiT5iLl/70LlMp3oH5aHfNZZAIBzyV3FzilVG4fU2/hqmqTLiUutYPb3McYPmdmn+NBVAHhqGNwBAACAdWpkZOQ/RrcPyaz/+MBoWKxcmnUSAOC8cxXbp9Tb+Kp6Gw+nIW0lrjBjin9lZn8xPj4+mXUhAKwmDO4AAADAOrNt27ZCqVR6l6RfbuUH47Gh54VOrjfrLABAxkyuUvOo+pYfVKXxSAzy4NIdJv2JpA/X6/W5rBsBYKVjcAcAAADWkVqttlVmH5X78Gz1Kk337ZBbknUWAGCFCbGj3sZXVV26P5Y60+HMlTMfkfTH4+PjY5I860YAWIkY3AEAAIB1Ynh4+EUy+3MPhdKxgRuS5fLFWScBAFaBQmdG/csPqHf5wdRiN5HZpMf4B319fX+zf//+ZtZ9ALCSMLgDAAAAa1ytVqtI+n1JL2sWLojHhnaHblLOOgsAsMpY7Ki38bAGlg6m+c5s4gozwfyP0jT9w8nJycNZ9wHASsDgDgAAAKxhIyMjz3HpY3JdOdO3zWZ6t8l5DAAAPC2uUuuk+pfuU7XxqEtK3eNfu/t7Jycn78i6DgCyxEkbAAAAWJtseHj45TJ7f0xKybHB5yWN4gVZNwEA1phcuqT+xa+ob/ErMSgNbvaZxOzdY2NjnxX3vANYhxjcAQAAgDWmVqv1S/pTSXuXi5v9+NBzLQ3FrLMAAGtY8I76lu7XwOJ9aZI2EplNmvTO8fHx/yEpZt0HAOcLgzsAAACwhoyMjOyKrn2SnjXdf73N9lwpGcd+AMD5YR5VbTyswYW703x3IXGFrwTz/1qtVv96//793az7AOBc4+QNAAAArA2hVqv9smS/1U0qOrbhxqSZH8q6CQCwXrmrp3lIgwt3x2JnJrjCQ/L07Wb2oXq93sk6DwDOFQZ3AAAAYJW74YYbntHtpn8p+fMXy8/WicFRRctnnQUAgCRXpXVUg3N3xVLnVHCFh0zxbb29vR/mjXcAaxGDOwAAALCKjYyMfH90fUSyoZODI2G+cpk45gMAVh5XuXlUQ/N3xlJnOsjCAyb/9fHx8b8Vd7wDWEM4iQMAAACrUK1Wy0t6u6Q3dPID8cjg85JOvi/rLAAAvgtXpXlEQ3MHYrE7G1y6W+6/OjEx8T8ledZ1APB0MbgDAAAAq8zo6OiW1P1vzH10vnqFTvbvlCtknQUAwJPgqjYf1dDcHWc+XFX/7jG+YXJy8gtZlwHA08HgDgAAAKwiIyMjPxXd/1ShUDo2uCtZKj0z6yQAAJ4yk6u69KA2LNyVJulyItknzfSr4+Pjd2XdBgBPBYM7AAAAsArceOONvc1m8w8kvbhR2BSPDz0vdJNy1lkAAJwVpqj+xa9ocOGuNMROkPSBGONbJicnD2fdBgBPBoM7AAAAsMLt3LlzJCS5v3WPl830bbfZ3mvlHOUBAGtQiG0NLNyjgaX7osnbcv/tZrP5nqmpqcWs2wDgieCUDgAAAKxcYWRk5LXu+s00V9HRwd1Js7Ax6yYAAM65XLqkDfN3qrr8kFzhuDx9w8TExF9Kilm3AcB3wuAOAAAArEDXXXfdxbl8/kNy37NYfrZODIwqhnzWWQAAnFfF9rQ2zk3GUvtEkNntHuNrJiYmvph1FwB8OwzuAAAAwAozPDz8oxbCB12hemJwNCyULxFHdwDA+uWqNg5p4/ztadJdSiR9NMb4+snJyYezLgOAb8apHQAAAFghtm3bVi2VSu+T9NJmfkM8PrQ7dHLVrLMAAFgRTFH9C/doaOHuKE87cn9XsVj87VtuuaWRdRsAPIbBHQAAAFgBarXaDbLw1+7x0tm+59hM7zY+GBUAgG8hSZe1cf6AqssPSRYOmfwXx8fHb5LkWbcBACd4AAAAIEN79uzJLSws/Jq7vzXNVf3o0O6kxQejAgDwXZXaJ7VxZjwWu7PBzT4TpFePj4/fl3UXgPWNwR0AAADIyPXXX39FyOU+bO6jCz1bdLJ/WNFyWWcBALBqmFy9S/dr4/yB1GLHJX9vs9l8x9TU1GLWbQDWJwZ3AAAA4PyzkZGRV7j0vmj5/PGB0WSp/KysmwAAWLWS2NLQ/AH1Ld0vlx0OptdwzQyALDC4AwAAAOdRrVbb7G4fMPP/bbm42Y8P7rI0KWedBQDAmlBqT2vj7FgsdmaCFD4lxZ+v1+v3Z90FYP1Isg4AAAAA1ovh4eGfkNmnZOHakwM1OzWw0zzks84CAGDN6CZlLfRstW4oqdI5cZk8/txFF12knp6eW6enp9Os+wCsfbzhDgAAAJxju3fvHmq1Wn9oZj/ZyG+IJ4aeGzq53qyzAABY05LY1Ma5SVWXH5bLDpr8FfV6/XNZdwFY2xjcAQAAgHOoVqv9oMs+KGnDTP+OMFu9Ws4xHACA86bcOqoLZutprruQSPrLGONrJycnT2TdBWBt4qQPAAAAnAO1Wq3fzH7P3X+2lRuIx4eeG9r5gayzAABYl0xRA/N3a3BhyiXNy+MvTUxM/IX4UFUAZxmDOwAAAHCWDQ8Pv0AWPijpwtm+bTZTvVZuIessAADWvUJ3QRtnxmO5fSy464sh2MvHx8fvy7oLwNrB4A4AAACcJbVarV/SeyW9tJPvT48NPjdp5QezzgIAAN/A1bv8kDbOTaYhdqLk72g2m781NTXVzroMwOrH4A4AAACcBSMjI//RZX/uHp8x27vNZnq38VY7AAArWBJb2jA7od7Gw5LZfSa9dHx8/OasuwCsbgzuAAAAwNOwe/fuoXa7/XuSfqZTGEiPDdzAW+0AAKwildZRbZoZS3PpUiLpjyS9sV6vz2XdBWB1YnAHAAAAnqKRkZEfi64/lrRhpu85Nlu9hrfaAQBYhcxTDc7fqYHFe90sHDf5K8fHxz+edReA1YfBHQAAAHiSarXaZkl/KOlHmvmheGLohtDO9WedBQAAnqZiZ0abZm6Lxc5McPe/S5Lk1WNjY0ez7gKweiRZBwAAAACriNVqtZfJwv+Msu3T/dfbycFdloZS1l0AAOAsSJOyFnq2WrScSu3jV0v6LxdfdNGxw4cP3551G4DVgTfcAQAAgCfg+uuvvyLkcn9m7t+zXHhGPDk0GjpJNessAABwjuS7i9o0OxbLrWPBpX9NQnj52NjYA1l3AVjZGNwBAACA72Dbtm2FUqn0epm9xS0fTvTvTBYql4qjNAAA64Grb/khbZybSM27Hbm/acuWLb+/b9++NOsyACsTTwkAAADAtzEyMnKjS38u96sWK5foZN9OpQnXxwAAsN4kaUOb5ure0zhkLtWD2YvHx8fvyroLwMrD4A4AAAB8k+3btw8WCoV3S3p5N6mkJwZ3JcvFC7POAgAAGas2D2njzFiaxLZL/pvNZvOdU1NT7ay7AKwcDO4AAADA42x4ePinLSS/7+6Dc73X2HTvNrklWXcBAIAVIoltbZibVO/yg3LZvSZ/cb1evzXrLgArA4M7AAAAIKlWq13tZn9s7t/bLGyKJwZHQzvXl3UWAABYoSqto7pg9rY06S4HSb8n6c31en056y4A2WJwBwAAwLpWq9Uqkn5dstfFkLdT/TuT+fKlknFUBgAA35nFjjbMH1D/0lfkCg8F858dHx/fn3UXgOzwFAEAAID1ykZGRn7IZf9NHp8537NV0307lIZi1l0AAGCVKbVP6oKZW9N8dyExsz9x99fX6/W5rLsAnH8M7gAAAFh3hoeHL5fCH5j5D7RyA/Hk4EhoFjZmnQUAAFYxU9TQ/F3qX7jbzcIxeXxZvV7/ZNZdAM4vBncAAACsG2euj3mjzN7glgun+nYk8z2XyzkWAwCAs6TYmdEFM7emhc5sIunDkn6xXq+fzLoLwPnBkwUAAADWAxsZGfmx6PY+U7x4oXKZpvuvUzeUsu4CAABrkHnUwOK9Gpy/M5rZrMf0VRMTE/skedZtAM4tBncAAACsaaOjo9ui+/vl/n2t/GA8MVALLa6PAQAA50G+M6cLZm6Lpc6pIOnjkl5Vr9ePZN0F4NxhcAcAAMCatH379sFCofBWd/8FT4p+qm9HstCzletjAADAeWVy9S9+WYNzd8RgvuQx/t8TExN/Id52B9YknjYAAACwpuzduzd58MEHXxbd3iXFgfmeK2y6b7tiKGSdBgAA1rF8uqhNM2Ox3DoWZPbptNt9xe233/5Q1l0Azi4GdwAAAKwZtVrt+2T2frlvaxQvjCcHhkM715d1FgAAwBmuvqUHtGFuIgbFltzfUK/X/1BSzLoMwNnB4A4AAIBVr1arbZX0Hkk/0s31pCf7dyZLpYvFcRcAAKxESbqsC2bHvdI8bG52i7m/pF6v35t1F4CnjycQAAAArFq1Wq3fzN7krl+KCmG2f3uY7blCbknWaQAAAN+Fq9p4RJvm6mlI29E9vs3M3lOv1ztZlwF46hjcAQAAsOrs2bMnt7i4+FKX/abcB+d7tthM33Z1QynrNAAAgCcliS1tnJtQdflhyewuj/HFExMT9ay7ADw1DO4AAABYVYaHh18gC+8z+dWN4oXxZP/1oZ0fyDoLAADgaak0D+uC2bE0dJdN0u8Ui8W33XLLLY2suwA8OQzuAAAAWBVqtdp2mf2O3J/fyVXTk307k+XyReJICwAA1orgHW2Yu0N9SwclCw8E00vGxsY+n3UXgCeOpxMAAACsaLVabbOkt0t6aQyFON23PZmvbJVbyDoNAADgnCi1juuC2dvSfHcxMbM/cffX1+v1uay7AHx3DO4AAABYkbZt21Ytl8uvden1LivOVa8KM9VrFEMh6zQAAIBzzhQ1NH+n+hfucbNw3OSvHB8f/3jWXQC+MwZ3AAAArCh79uzJzc/Pv0QW3mHyTYuVS3Sqd4e6uZ6s0wAAAM67YmdGm2Zui8XOTJD0sRDCL4yNjR3NugvAt8bgDgAAgJXCRk1deG8AACAASURBVEZGXuiy98jjlY3CBfFU//WhVRjKugsAACBTJlf/wr0anL8zBvMlk35xfHz8g5I86zYA34jBHQAAAJmr1Wo3SPZeyW/s5PrSk/3XJ8ulzeK4CgAA8Lh8d1GbZsdjuXU0uNnnY7f78ttvv/0rWXcBeBxPMAAAAMjMrl27rux2u+8ysx9Nk3I63bc9WahcJueYCgAA8G24epcf0qa5yVSxnZr0Nkm/U6/XO1mXAWBwBwAAQAZGR0cvjDG+1d1foSTv09Vrkrnq1XJLsk4DAABYFXKxqQ2zE6o2viqZTZn0kvHx8duy7gLWOwZ3AAAAnDc33HBDX7fbfa3MXueu4nz1SpvpvVZpKGadBgAAsCpVmkd0wexYmqTLQdL7S6XSr998880LWXcB6xWDOwAAAM65PXv2lBYXF18VXW8x+cBi5VJN921XJ+nJOg0AAGDVs9jR0MJdGlj8srt0VB5fOTEx8Q9ZdwHrEYM7AAAAzpm9e/cmDzzwwH92hXea4sXLxQv9VP911s4PZp0GAACw5hTb07pg9ra00JlN3P0md/+FycnJw1l3AesJgzsAAADOBRsZGXlhdL3b5Fc38xvi9MD1oVHYlHUXAADAmmZy9S/ep6G5A1GKDZNev2XLlv9n3759adZtwHrA4A4AAICzanR09Huj+7vlfkMn35ee6tuRLJUuFkdPAACA8yfXXdKm2TGvtI6am415mr58cnLyjqy7gLWOpx4AAACcFbVabViyd0n+/DSppKf6tieLlUvlHDkBAAAy4qo2Dmnj7Hga0qaFEN7bbrd/48CBA0tZlwFrFU8/AAAAeFpGRkaucve3S/qJmBTT6eq2ZL5nq9ySrNMAAAAgKcSONszfob6lg3KFR+Xpq/hQVeDcYHAHAADAUzI6OvqsGONb3f1nleR9pnpNMle9StFyWacBAADgWyi1T+mCubE0355NJH08hPALY2Njj2TdBawlDO4AAAB4Unbs2HFBoVB4o0s/H13JfO/VYbZ6jdJQyDoNAAAA38XpD1X9sobmD0RTbMn9zZL+oF6vd7JuA9YCBncAAAA8Iddff/1ACOG1FsIvu6s037PFZnq3KU0qWacBAADgScqly9o4O+E9zUPm0t3B7BXj4+M3Z90FrHYM7gAAAPiOduzY0ZPP518jszfKvXexcqmme5+jTq6adRoAAACepkrzsDbNjqe5dDlx9w+Y2Rvq9frJrLuA1YrBHQAAAN/Snj17SgsLC6+UhTfL44al0jN9un+7tXP9WacBAADgLDJPNbgwpYGFe1zSvDy+fmJi4s8kxazbgNWGwR0AAADfoFar5d39xbLwGybfvFy80Kf7dlirMJR1GgAAAM6hQndBG2frsdw6Gtxs3NP0VZOTk+NZdwGrCYM7AAAAJEl79+5N7r///p+SJf/VFC9tFjbFU33bQ7N4QdZpAAAAOG9c1eVHtHF+Mk3SRpD0x+12+0133nnnTNZlwGrA4A4AAIAwMjLyoy69U+5XtvJDcbpve1guXSiOiwAAAOtT8K4G5+9S/+J9LtlsMH/d+Pj4B8U1M8B3xBMUAADA+mXDw8M/KLN3mrSjk+9PT/XtSJZKF4ljIgAAACSp0J3XxpnxWG4f55oZ4AngSQoAAGD9sVqt9v1u9g5zH+3ketPp3u3JYvlZknE8BAAAwDdzVRuPaOPc166Z+TNJv1av109mXQasNDxRAQAArCOjo6PfG6O/U/Ibu0klne7bnixWLpVzLAQAAMB3YbGjwYW7NbB4r5tp0aRfq1arf7x///5u1m3ASsGTFQAAwDowOjr6vOj+Drl/X5qU0+ne5yQLlcvkFrJOAwAAwCpT6C5o49yEl5tHzKW7TXp1vV7/XNZdwErA4A4AALCGjYyM7HK3t0vxBWlSSqer25KFni1yS7JOAwAAwKrmqjQOa9P8ZJrrLibu/nfu/iuTk5MPZ10GZInBHQAAYA2q1WrDkr1d8h+MSTGdqV6bzPVcztAOAACAs8o8Vf/ilzW0cFeUp12TfqvT6fz2gQMHlrJuA7LA4A4AALCGjI6OXp+m6dvN7IUxFNKZ6jXJXPUKueWyTgMAAMAalqQNbZi7Q72NhyQLRz2mr52YmPiIJM+6DTifGNwBAADWgOHh4R1m9huSfjiG/ONvtId81mkAAABYR0rtU9owOxFLnVNBZrfJ/TX1ev3WrLuA84XBHQAAYBUbHh7eIemtZvajHgrpTPXqZK56haIxtAMAACAj7qo2HtbG+TvSJG0kkj4SQvjVsbGxR7JOA841BncAAIBVqFarbXf3t5rZj3nInxnar2RoBwAAwIph3tXg4r3qn787mmLXpN9uNpvvnpqaWsy6DThXGNwBAABWkW98o/3M0N5zpSJXxwAAAGCFStJlbZi/U73LD8plJ0z+a1u2bPngvn370qzbgLONwR0AAGAV2Llz53UhhLdK+hGGdgAAAKxGxfa0NsxNxnL7RHCFu+XpL09MTHwq6y7gbGJwBwAAWMFqtdrwmatjfuj0He1XMbQDAABgFXP1NA9rw9xkmu8uJm72GU/T105OTt6RdRlwNjC4AwAArEAjIyO73PUWyX8wnnmjfZ472gEAALBGmEf1Lt2vDQt3piG2g6S/kvTmer3+1azbgKeDwR0AAGAFGRkZudGlt8j9+TEpprPVa5K5nssVLZd1GgAAAHDWBe9oYOEe9S/cG4N5KvffLxQK77rlllums24DngoGdwAAgOzZ8PDw9ymEt5r796ShmM72XpvM9WyVM7QDAABgHUjSZQ0tTKlv6QGXaVHu7ywUCn9wyy23NLJuA54MBncAAIDs2MjIyA+ceaP9hjQppzO91ybzPVvlClm3AQAAAOddvjOvDfMHvKd5yGThmMf0LWb2wXq93sm6DXgiGNwBAADOvzAyMvIj0f3NJl3XTXrSmd5rk4XKZXJjaAcAAACK7ZPaOHcgltrHgyw8YPI3jY+Pf1RSzLoN+E4Y3AEAAM6TWq2Wl/R/uMKbTPGKTr4vna5emyxVLpFzLAMAAAC+iavcPKoNc3fEYnc2yOwuj/GNExMTn5TkWdcB3wpPdgAAAOdYrVarmNlLotuvmuLFrfxgnOm9NiyVnikZxzEAAADgO3JXtXlIQ/MH0nx3IXGzscTs18bGxj4rhnesMDzhAQAAnCPXX3/9QAjh5ywkvyKPQ43CBXG279qwXHyGOIYBAAAAT47JVV1+SBsW7kqT7lLiri+6x1+fnJz8QtZtwGN40gMAADjLdu7ceVEI4ZdcepVJPculi3y691prFTZmnQYAAACseuZRvcsPaGhhKk3SRiKz/XJ/c71e/7es2wAGdwAAgLOkVqtd7e6vMws/41KyWL7EZvuuVTvXl3UaAAAAsOaYovqW7tfgwlSapM3EzT5r7m9jeEeWGNwBAACeHqvVaje6++vN7IVuSZzvuTzMVq9SN6lk3QYAAACseeap+pYOanDxnjRJm4nM9gezt42NjX0+6zasPwzuAAAAT8HevXuT+++//3+3EN4g910xKaazPVcl8z2XKw2FrPMAAACAdefxN97vPn3VjOxmyd9er9c/LT5cFecJgzsAAMCTsGPHjp5cLvdiWfJaU7y0k6ums9Wrk4XKZXJLss4DAAAA1j3zVH3LD2lw8e406S4lMpvwGN8xMTHxcUkx6z6sbQzuAAAAT8B11113cS6Xe7XMfk7ufc3Cpjjbe3VYKl4kGUcqAAAAYKUxj6o2Htbgwt1pvruQyOzLcv9NSR+p1+udrPuwNvF0CAAA8B3s3LlzJITwi5L9pMvDUvnZNle9Ws3CUNZpAAAAAJ4Ak6uncUiDi3enhfZM4gqPmuJ7ms3mn09NTS1m3Ye1hcEdAADgm+zZsye3sLDwI+72S2a+20M+neu5PJnruYIPQgUAAABWLVeldUwDC/fEcutYkNm8x/j+JEn+29jY2NGs67A2MLgDAACcUavVNkp6mcteY/LNnVw1natelcyXL5WHfNZ5AAAAAM6SYntaA0v3qrr8iEvqSv6XIYTfGxsbm8q6DasbgzsAAFj3arXasJm9Orr/tEmFRmmzz1avtOXChdzPDgAAAKxh+XRR/YtfVt/iwWiKQbJPu8ffnZiY+JQkz7oPqw9PkAAAYF26/PLLi319fT9uIfyC3G+ISuJCz5YwV71CnVxf1nkAAAAAzqMQ2+pffkD9i/elSdpIXOErpvi7nU7nrw4cOLCUdR9WDwZ3AACwruzateuyNE1fKQsvl8ehTr4vna1ckSz2XKZouazzAAAAAGTIPKqneUj9C/fFUudUcGlR7n8q6b9PTEwczLoPKx+DOwAAWPP27NmTW1xc/MEY9V/M/AUu01L5mTbfc4UaxU3iSAQAAADgm5U60+pb+LKqjYfd5HK3T0nxD7du3fpP+/btS7Puw8rE0yUAAFizdu7ceUkI4aWy8Ap5fEaaVNK5nq3JfGWL0qScdR4AAACAVSBJm+pbfkD9S1957LqZR4P5H7n7B+r1+pGs+7CyMLgDAIA1Zdu2bYVyufxD7nq55N/vkpZLF2m+53JrlDbLOf4AAAAAeApMrkrzsPqXDnq5ecQkS8308Rjjn27duvXTvPUOicEdAACsEbVabbu7/6wsebEpDqa5nnSusiWZr1ymNKlknQcAAABgDcmnS+pbekC9SwfTJLYSlx02+Z+lafrB22+//aGs+5AdBncAALBq7dq1a0O32/1JC+Glct/pFuJS6VlhoWeLlgsXSMZRBwAAAMC5Yx5VaR1W39L9XmkeleTmZp8P0gfa7fbfHThwYCnrRpxfPIUCAIBV5cyVMT8g6Wfc9UOS51r5oTjfc1lYLF+iGApZJwIAAABYh5J0Wb3LD6tv+f40311MZNaQ+0fd/S+3bt36ea6cWR8Y3AEAwGpgO3fufG6SJD8dXT9t8oE0KaULlcuShcplauf6su4DAAAAgDNcxfYp9S0/pN7Gw6nFTiILR+Xxw2b24fHx8dsledaVODcY3AEAwIo1Ojq6LU3Tn5KF/2zyS9ySuFR+VlioXKpG8Rl8ACoAAACAFc08VaV5RL2Nh1RpPOomN5cdlMcPSfroxMTEPVk34uziKRUAAKwotVptq7u/SGY/bdK1LnmjuFkLlUtsqfxMueWyTgQAAACAJy3EtqrNR9Wz/JBXWsel0+P7PSb/G3ffx/i+NjC4AwCAzI2Ojm6JMe6V2YvkvlOSGoUL4mLl2WGp/CyloZh1IgAAAACcNUnaVE/zkKrLj8Ry+7hJbrLwZY/pPkn/Y2JiYkJcO7MqMbgDAIBMDA8PXxNC+NHo/hMm7ZCkRn5DXKpcEhbLz1KalLNOBAAAAIBzLhebqjQOqafxiJdbx3Xm2pnD8nhTCOETjUbj81NTU+2sO/HEMLgDAIDzJdRqtVFJP+yyHzf55ZLULGyKi+VnhcXyM5UmlYwTAQAAACA7IbZVaR5WT+OQelpHonkaXFqW+z9J+mQ+n//HW2+99VjWnfj2GNwBAMA5t23btkKpXL5H7ltc5s3ShVoqPdOWyherG0pZ5wEAAADAimOKKjWPqdo6rJ7mo2nSXU4kyaU7gtkn0zT9VAjhlnq93sm6FY9jcAcAAOfcrl27NqRpenKu5wpN9+9QtHzWSQAAAACwirgK3QVVGo+q0jzipfaJM1fPaDmYfdbdPx1j/Ozk5OQ94u73TDG4AwCAc+6xwf3EwIjmey7POgcAAAAAVjWLHZVbx1VpHVWldSTNdxfPvP0ejpviZyR9Lk3Tz99+++0HxQB/XjG4AwCAc47BHQAAAADOnVzaULl1VOXmMVXaR9MkbSaSJAvHPKafM7MvSPq3er0+JSlmGrvGMbgDAIBzjsEdAAAAAM4XV767qHLruMrtEyq3jneTdDl3+q9o0aSbJd0cY/xSoVAYu/XWW+czDl5TGNwBAMA5x+D+/7F351Ga3nWd9z/f33XvdVdVV3V3TCcsSWclTTrpuqsSmujY84yPjI7MKBiX0Xl8QEHFAXUAQYdlQNRBcccRZaKiggNN3BlBYGjA0Kar7qqkksq+p/el9qp7vX7f54/uRMjDkqW6r1rer3Ny+qQTOO/uc4Df9eHK7wIAAACA7OTSZZXaJ1Run1SpdSItdOaC5CbJZeE+j+ktIYQD7j7abDbvnJqaamfdvFYxuAMAgLOOwR0AAAAAVo/gXRXbp1Rsn1KpfUql9sk0ia3T19DIOjLd4TGOShpPkmSip6fnjn379jUzjV4jGNwBAMBZx+AOAAAAAKuZK5c2Tg/wnVkV2qe81JmOIbZPf4zVPcrCfSavu/vtku7I5/N33nrrrYfER1m/AoM7AAA46xjcAQAAAGCtOTPCd2ZUaM+o2JlVsTPdzZ25D16SZDbvMb52fHz8oxmGriq5b/y3AAAAAAAAAAA2FlM3qaibVLRUuvCJn8wF76jQmVOhM6vNs+PVJISXSGJwPyNkHQAAAAAAAAAAWBui5dUsbDn9Ty+HhOtknoLBHQAAAAAAAACAFcDgDgAAAAAAAADACmBwBwAAAAAAAABgBTC4AwAAAAAAAACwAhjcAQAAAAAAAABYAQzuAAAAAAAAAACsAAZ3AAAAAAAAAABWAIM7AAAAAAAAAAArgMEdAAAAAAAAAIAVwOAOAAAAAAAAAMAKYHAHAAAAAAAAAGAFMLgDAAAAAAAAALACGNwBAAAAAAAAAFgBDO4AAAAAAAAAAKwABncAAAAAAAAAAFYAgzsAAAAAAAAAACuAwR0AAAAAAAAAgBXA4A4AAAAAAAAAwApgcAcAAAAAAAAAYAXksg4AAAAAAAAAAKwNwTsqdOZU7MxJMTVZ1kWrC4M7AAAAAAAAAOApXLl0WcXOrIqdGRXaMyp1Z7pJd/lfNmWzxRjj/gwjVx0GdwAAAAAAAADY0Fy5tKFSZ1rF9rQK7VNe6kzHEDuJJLl7lIV7g6ke3SclTaZpeuftt99+WJJn2766MLgDAAAAAAAAwAYSvKti+5SK7ZMqtadVap9Mk9hKTv9V67h80qRRdx9394n+/v479+3b18y2em1gcAcAAAAAAACAdSyXLqvUOqFy+6TK7RNpvjMXJDdJ7rJ7TX6Lux8ws7Fms3Hn1NRUO+vmtYrBHQAAAAAAAADWDVe+u6hy67jK7RMqt46lSdo4fTWMtCj3f5LZLTHG/YVCYfTWW2+dz7p4PWFwBwAAAAAAAIA1LJcuq9w6pnLzmCrtfxnYZeGYPP4fSV80sy/Wx8bukhQzjV3nGNwBAAAAAAAAYA0J3lW5dUyV1lGVm0fSfHfxzBvs4bgpflrSPnffN14ffVB81PScYnAHAADnTKEzp+AdRctnnQIAAAAAa4ir0J1XT/OIyo1DXmqflMnNpSW5f9ZC+HSM8bPj46P3iIE9U5Z1AAAAWP927NhRKJXLd8t9u8u8UfwmLZefb4vlC5WGUtZ5AAAAALDqmKLKrWPqaRxWT/NQmqTLZ66Jsds8xk9I+pSZ/XO9Xu9kW4ovx+AOAADOlTA8PDzs7t/tCt9ripdJUrOwNS6Wnx+Wys9XNyln3QgAAAAAmQmxrUrzsHoaB9XTOhLN03DmLfZPSvr7fD7/D7feeuuxrDvxtTG4AwCATAwNDb0ohPCK6H6jSddIUiO/OS5VXhAWyy9QyvgOAAAAYAPIxaZ6GodUaTzm5dbxM1fFhEOm+Jdm9neNRuPzU1NT7aw78fQwuAMAgMyNjIxsd/fvden75T4kSY3C1rhYeWFYKj9faShmnQgAAAAAKyZJm+ppHlR1+bFYbp8wyU1m98p9r7v/9fj4+Li4i31NYnAHAACrSq1Wu0TS98nsh+S+wyVvFM/XQuUiWyo/T2588x0AAADA2hNiW9XmIfUsPeyV9gnp9Jvsd5ni/3L3j4+Pj9+ddSOeOwZ3AACwau3atesqM/uPsvDDJn+hK8SlygvCQvmFapTOl3OUAQAAALCKmaeqNA+rt/GoKo1Dfua6mPvl6YfN7KP1ev2erBuxsnhKBQAAa4ENDQ1dH0L44ej6IZNvSpNSulC+KFnouVjtXH/WfQAAAABwhqvYPqXe5YfV13gstdhJZOGoPP65mX1kbGzsNnFdzLrF4A4AANaUHTt2FMrl8nfEGP+TWfgPkuda+YE4X9keFisvVAyFrBMBAAAAbEBJuqze5UfUt/xQmu8uJjJblvvH3P3PLrnkks/v3bs3zboRZx+DOwAAWLN279492G63f0BmPyr3IbcQl0rPCws9l2i5cJ5kHHUAAAAAnD3mUZXmYfUtPeiV1lGd+fjp50z643a7/ZeTk5NLWTfi3OIpFAAArAu1Wu1qSf+vK7zKFAfSXE86V9mezFcuVppUss4DAAAAsI7k00X1LT2k3qUH0yS2EpcdDqYPdrvdP7ntttseyboP2WFwBwAA68qZK2de7q7XSv5/S6bl0gWa67nEGqVtfGgVAAAAwLNi8tNvsy/e75XWUZMsdY9/LemDl1xyyWe4MgYSgzsAAFjHdu3a9cIQwo/Kwmvk8fw0qaRzPZck85XtSpNy1nkAAAAA1oBcbKp36SH1L92fJmkjkYWDJv+Amd00Ojp6NOs+rC4M7gAAYN3bs2dPbnFx8Ttj1E+a+ctcpqXyhTbfc7kaxa3iSAQAAADgqUrtafUv3aee5Ufd5HK3T5n5+7dv3/5J3mbH18LTJQAA2FCuu+66i9M0fa0svFYeBzv5vnS2clmy2HOxouWyzgMAAACQIfOonuZB9S/cG0udU0EWFjym/1PS/xgfH38g6z6sfgzuAABgQ7r00kuL/f39r5TZG+R+vVsSF3q2h9mey9TJ9WWdBwAAAOAcCrGt/uUH1b9435lrY+w+uf9mp9P5s8nJyaWs+7B2MLgDAIANr1arDbn7T8nsh00qLBfP97nqFbZcPF8yjksAAADAepVPF9W/cK/6lh6Mphgk+0f3+Bvj4+P/KMmz7sPawxMkAADAGdddd93mNE1/zGVvMPkF3VxvOlu9PJkvXyQP+azzAAAAAKyQYntamxbvUbXxuMvUlfuHYoy/OTExcVfWbVjbGNwBAACe4sxHVr87Rv0XM9/tIZ/OVS5J5qqXq5tUss4DAAAA8Ky4Ks2j2rRwTyy3jwWZzXuMv5vP53/31ltvPZZ1HdYHBncAAICvY9euXcMhhJ+R7AdcHpYqL7C5nivVLAxmnQYAAADgaTC5ehoHNbB4V1pozySucMgUf7XZbP7R1NTUYtZ9WF8Y3AEAAJ6Ga6655sJcLvdTMvspufc1C1vjbO+VYal4Afe8AwAAAKuQeVS18agGFqbSfHcxkdl9Jv2Su/9FvV7vZN2H9YmnQwAAgGdg586dPfl8/kdc4c2meFEnV03nqi9K5isXyS3JOg8AAADY8MxT9S4/rMHFu9Kku5y4VDfpPfV6/W8lxaz7sL4xuAMAADwLN954Y/Lggw/+ewvhLXK/PibFdLbn8mS+5zKloZB1HgAAALDhmKfqW35IAwt3pUnaSCS7RfJ31+v1T0vyrPuwMTC4AwAAPEfDw8M3xBjfYmYvd0vifM+lYbZ6ubpJT9ZpAAAAwLpnnqpv6QENLN6dJmkzkdnngtm7RkdHP591GzYeBncAAIAVUqvVrpT0Jsl+xOXJYvkim+17kdq5/qzTAAAAgHXHFNW39KAGFqbSJG0mbvbZIL1zbGzslqzbsHExuAMAAKywXbt2XZAkyc9E99eZ1LNcusCne6+yVmFL1mkAAADAmmce1bv8kAYXpk5fHWP2OZPeztCO1YDBHQAA4Cy59tprNyVJ8pOy8CZ5HGwUtsbZvh1hufhN4hgGAAAAPDMmV3XpYW1evPP0x1DNvqAY3zY+Pv7FrNuAJ/CkBwAAcJbt3r273Gq1Xm0heas8Pq+VH4gzvVeFpdLzJOM4BgAAAHxd7qo2H9fg/B1pvruQuNmop+nPT0xM/B/xMVSsMjzhAQAAnCO1Wi1vZj8Y3d5mipd18n3pdPWqZKnyQjnHMgAAAOApXJXWUQ3O3h6L3dngsjvk8RfGx8c/IYZ2rFI82QEAAJx7YXh4+Hui+9tNuqab9KQzvVclC5WL5JZk3QYAAABkrtg+qS1zk7HUPh5k4SGP6S+Mj4/vlRSzbgO+HgZ3AACA7Njw8PB3uPQOuV+fJuV0pveqZL6yneEdAAAAG1K+M6/N87d7T/OQycIxj+k7zOyP6/V6J+s24OlgcAcAAMie1Wq1PW72TnP/1jQU09neq5K5nkvklsu6DQAAADjrknRZgwtT6lt6yGValPsvFQqF39m/f38j6zbgmWBwBwAAWEWGh4dvcLe3S/FlMRTS2d4XJXM9lykyvAMAAGAdCt7RwMI96lu4Owbz1KTfyufz/33//v3TWbcBzwaDOwAAwCo0PDx83Znh/btiyKcz1SuT+erlipbPOg0AAAB4zsyj+pYf1OD8HWmI7SDpTyW9o16vP5Z1G/BcMLgDAACsYrVabUjSOyT9Bw+FdKZ6RTLXc7liYHgHAADAWuTqaR7Slrnb01x3IZHZp2OavnliYuL2rMuAlcDgDgAAsAbs2rXrGjN7h5m9wkM+nem5IpmrXsHwDgAAgDWj2J7WlrnbYql9PLh0l9z/y/j4+Key7gJWEoM7AADAGjI0NLRT0jvM7JUM7wAAAFgLknRZm+cn1bv8iFx2Iph+/uKLL/6TvXv3plm3ASuNwR0AAGANqtVqV7v7O58c3qtXJnPc8Q4AAIBVxLyrgcV71D9/VzTFrknvbTabvzo1NbWYdRtwtjC4AwAArGFnhvf/dvqqmTN3vDO8AwAAIEvuqjYe1Zb529MkbSSSPhxC+PnR0dHHs04DzjYGdwAAgHVgaGhop5n9N0nfE0M+nam+KJnruUzOVTMAAAA4h0rtU9o8Ox5LnVNBZrea9IaxsbEDWXcB5wqDOwAAwDoyMjJybZqm7zKzfx9DIZ3tvSqZ7blUbrms0wAAALCOJWlDm+duV2/jEbnsiMnfVK/X/0KSZ90GN1jLQAAAIABJREFUnEsM7gAAAOtQrVYbksK7pPhdMSmmM9WrkrmeS+WWZJ0GAACAdcQ8Vf/ifRpcuDPK024w+5V2u/1rk5OTS1m3AVlgcAcAAFjHRkZGRtLU323m/zZNSulM745kvrKd4R0AAADPkavSOKyt8+NprruUuPvN7v7GiYmJR7MuA7LE4A4AALABjIyMvDRKv6gY/680KafTvTuShcp2uYWs0wAAALDGFLoL2jI37uXmEXPprmD2U2NjY/uy7gJWAwZ3AACADWRkZORbY/T3SP7N3aSSTvddnSxWLpJzLAQAAMA3YLGjgYW7tGnxHjfTosf48319fX+wb9++btZtwGrBkxUAAMDGY8PDw98WpV8y95FOrvf08F56vmQcDwEAAPBUrmrjcW2Zm0iTtBHM7IPu/l/r9frJrMuA1YYnKgAAgI3LarXad7r0yybt7OT701N9VydLpQvFMREAAACSVOjOa8vMWCy3jwc3G/U0fd3ExMRY1l3AasWTFAAAAMLw8PArXHqP3K9o5Qfjqb6rQ6N0vjguAgAAbEzBuxqYv1P9i/e6ZLPB/E1jY2N/Iilm3QasZknWAQAAAMicHz58+K5vvuGG35+enr4/ie1aX+ORTZXW8djN91o36cm6DwAAAOeMq7r8uLZNfyGttI6aSb/fabe++7bbbtsvybOuA1Y7XlkCAADAV6jVanlJP+Kyd5n8guXiN/lM/zXWzA9mnQYAAICzKN+d19bZeiy3jgU3G1OMPzE+Pl7PugtYSxjcAQAA8FXt2bOntLCw8FpZeIc8bl4qXejT/TutnevPOg0AAAAryDzV4MJd6l+4yyXNy+Obx8fHbxLXxwDPGIM7AAAAvq6dO3f25PP518vCz8tj32LlIk33vlidXDXrNAAAADxHleZhnTdXT5PuUiLpJklvrdfrJ7PuAtYqBncAAAA8Lddee+2mJEneKLM3uqs037PdZnp3KE0qWacBAADgGcqly9oyO+49zYMms6lg9trR0dEvZd0FrHUM7gAAAHhGdu7ceV4ul3urhfCfoyuZr14RZnuvUhoKWacBAADgGzC5+hfv0+D8ZDTFltzf3tvb+9v79u3rZt0GrAcM7gAAAHhWRkZGnh9jfIe7v9otp9neF4W53isVLZd1GgAAAL6KUvuUzpsbTfPt2UTSX4cQ3jA6Ovp41l3AesLgDgAAgOfkuuuuuzxN01+U9H0xKabT1auS+Z5L5ZZknQYAAABJIba1eX5SfUsPSBYOekxfNz4+/ndZdwHrEYM7AAAAVkStVhuSwi9L8WVpUklP9b44Wey5WM6REwAAICOuauNxbZmtpyFtWgjh19vt9rsmJyeXsi4D1iuefgAAALCiRkZGvjW6v1fu13fyfemp3p3JUvlCcfQEAAA4d/LpkrbMjHqlddTcbFQx/tj4+Phk1l3AesdTDwAAAM4GGx4efnl0vdfkVzbzm+P0pmtDo7A16y4AAIB1zeTqX7hHA/N3RFNsmPTm7du3/+HevXvTrNuAjYDBHQAAAGfNjTfemDz00EM/7Aq/ZIoXNkrb/GTfTmvnB7JOAwAAWHeK7WmdN3sgLXRmE3e/2d3fMDExcTjrLmAjYXAHAADAWXfppZcW+/r6flKWvMMUBxYrL9R03051kp6s0wAAANY8ix1tXrhT/Yv3uUtH5fHH+SgqkA0GdwAAAJwz119/fV+3232jzN7srtJ89XKb6b1KaShmnQYAALAmVZqHdd7saJqkjSDpd0ql0ttvueWWhay7gI2KwR0AAADn3MjIyPkxxne4+48ryftM9apktnqF3JKs0wAAANaEXGxq89y4qsuPSWZTwexVo6Ojo1l3ARsdgzsAAAAyc911113e7XZ/2cxemSbldLr3xclCz3Y5x1QAAICvwdW79LC2zt+WKrZTk94p6dfr9Xon6zIADO4AAABYBWq12vWSvU/yb+7k+9KTfdcmy6Vt4rgKAADwL/LdRW2dHY3l1rEgs30e42vGx8cfyLoLwL/gCQYAAACrhQ0NDX2XhfA+uV/eKJwXT/VfG1qFway7AAAAMmVy9S/co4H5yRjMFk3+s2NjY38sybNuA/CVuCQTAAAAq8aRI0fuu+Lyyz/QarUO5mJjd//ygz2F7rxa+UHFUMg6DwAA4JwrdmZ0/qkvxN7GI2bSzSHYd46NjX0x6y4AXx1vuAMAAGBV2rFjR7VYLL7RQniLu0pzvVfaTPVFDO8AAGBDME81uHCn+hfudrNw3OSvHRsb+9usuwB8fQzuAAAAWNVqtdo2Se+W9KMxFOJ039XJfOUSuYWs0wAAAM6KUuu4vml2NM11FxJ3/wMze0u9Xp/LugvAN8bgDgAAgDWhVqtdLbP3yf3bO7lqerJvV7JcvkAcaQEAwHoRvKPNc7erb+kBycJDwfTq0dHRz2fdBeDp4+kEAAAAa8rQ0NDLZOG3TH5lo3h+PNl/TWjnB7LOAgAAeE4qzcM6b3Y0Dd1lM7NfKxQK79q/f38j6y4AzwyDOwAAANacPXv25Obn519tIfkVeRyc77lEM31XqxtKWacBAAA8I0lsactsXdXGY5LZHR7jq8bHx+tZdwF4dhjcAQAAsGbVarV+d/8Fs/CzUSGZ7b86zPZcJrck6zQAAIBvwFVtPKats/U0eCfK/Z2S3lev1ztZlwF49hjcAQAAsOaNjIxsjzG+T9L3dJOe9OSmXclS6UJx3AUAAKtRLm1o6+yoV5qHzc32m/ur6/X6PVl3AXjueAIBAADAujE8PLzHpffLfUejeH48uWlXaOf6s84CAAA4w9W39JC2zE+k5mlb7m+p1+u/JylmXQZgZfDP2gIAAGDdOHz48CPffMMNfzA9PX0olza+pW/p/lISW9YsbOGaGQAAkKl8d1HnT38p9i/dZyb/bNrt/tuJiYl/lORZtwFYObzhDgAAgHXp6quvHigUCu9099d7UvRTfTuThZ5L5ByBAQDAOWRy9S/ep4G522MwX/IY3zA+Pv4hMbQD6xJPGwAAAFjXdu3adVVIkvfL/V+38gPxxKZaaBW2ZJ0FAAA2gHxnTufNHIilzqkg6a8lva5erx/JugvA2cPgDgAAgI3AhoeHXxHdftsUL1yoXKzp/mvUDaWsuwAAwDpkHrVp8W4NzN8ZzWxWHn+iXq9/XLzVDqx7XGQJAACADeHw4cN3X3DBtg9IisXu3Ev7lx5UDPnQLgyK91AAAMBKKXZmdMH0F9Lq8mMhmH04CeHfjY2NjWXdBeDc4MkCAAAAG06tVrtEst+R/Dvb+U3xxKbh0OSaGQAA8ByYpxpcuFP9C3e7ZEdN/pp6vf6JrLsAnFsM7gAAANiobHh4+OUu+z15fN58Zbum+69RGopZdwEAgDWm1D6h82ZuTfPdxcTd/8DM3lKv1+ey7gJw7jG4AwAAYEOr1WoVM/uv7vq5GPJ2qv/aZL58sWQclQEAwNdnsaPN85PqX7pfrvBIMH/V2NjYvqy7AGSHpwgAAABAUq1Wu9LNPmDu39osbI0nBoZDO9efdRYAAFilKq2jOm/2QJp0l4Ok35T09nq9vpx1F4BsMbgDAAAA/8KGhob+o4Xkt919cK73SpvufbHckqy7AADAKpHEtjbPTah3+WG57J5g+pGxsbEDWXcBWB14cgAAAAC+zJEjR+7YsnnzB/O53GCpdaLWu/xI2sn1hU6uN+s0AACQsWrzoLad3JeW2qeimf1is9n4odtvv/2xrLsArB684Q4AAAB8DcPDwze4dJPcr1isvFAn+3YpTUpZZwEAgHMsSRvaOlf3nsZBc7OxIL1qbGzszqy7AKw+vOEOAAAAfA2HDx9+fHBg4A/z+Xyr0Jn7lv7lh9RNSqGd3yTeXQEAYCNw9S0/rAumv5gWunNtM/u57Rdf/JrPfOYzx7IuA7A68ZQAAAAAPA3XXnvtZSGX+5/m/q8axfPjiYHh0EmqWWcBAICzJN9d0NbZsVhuHQtu9tlcCK85cODAw1l3AVjdGNwBAACAp8+Gh4df7dJvRreemf5rwlz1cjnHagAA1g2Ta9Pivdo0d3sMpiWP8afHx8f/RJJn3QZg9ePJAAAAAHiGarXaNnd/v5m9opkfjCcGrw/tXH/WWQAA4Dkqdma0dfrWWOzOBkkfDyG8fnR09GjWXQDWDgZ3AAAA4FkaHh5+ZXR9QNLmmd4dNtt7ldxC1lkAAOAZMk81uHCn+hfudrNwzOQ/MTY29jdZdwFYe/hoKgAAAPAsHT58+O6LLnrhTTFNt5Xbx6+ptg6lzcLmkCblrNMAAMDTVGkd1QUnP59WmofNpA/kcsl3j46OTmbdBWBt4g13AAAAYAUMDw9/R3TdJPn5s707bKZ3B2+7AwCwiiWxpS1zE6ouPyKZ3RvMXj06OvqlrLsArG0M7gAAAMAKqdVq/ZLeJ+nHOvn+9NjAS5JWfiDrLAAA8BVcvcuPaMvceBpiN0r+i81m871TU1PtrMsArH0M7gAAAMAKGxoaepks/LHk58/2vdhmqtztDgDAalDoLmjLzGgst48Hd30xBHvN2NjYvVl3AVg/GNwBAACAs6BWq/W7+2+Y2atbuU3x+OBLQju/KessAAA2JFPUwMJd2jQ/5ZLm5fFnxsfHPyTJs24DsL4wuAMAAABnUa1W+3eu8EeSb53u22lzvVfKOYYDAHDOVFrHtHV2LM11FxJJH4oxvnliYuJE1l0A1idO+gAAAMBZtnv37sF2u/1+ST/YyG+OJwZfEjq53qyzAABY15LYPPNR1EflsgeC6TVjY2P7su4CsL4xuAMAAADnyNDQ0PfJ7A+l0Hty01CY77lEHMkBAFhZJlff0gManLstmqfdYPbu2dnZ9z3wwAOtrNsArH+c7gEAAIBzqFarbXO3m8z8O5aL5/vxgestTcpZZwEAsC6U2qe0ZXYsFjszwd0+aeb/uV6vP5h1F4CNg8EdAAAAOPdseHj4tS79VrR8/vimkWSp/PysmwAAWLOS2NLg/KT6lh6Uyw7L4+vHx8f/SnwUFcA5xuAOAAAAZOTaa6+9LORyHzb3kYXKxTq5qaZouayzAABYM0yu3qUHtWV+MrXYccnf1+l03jM5ObmUdRuAjYnBHQAAAMjQnj17cgsLC7/g7u9Mc1U/Org7aRW2ZJ0FAMCqV2qf1JaZsVjszgaZfdqk14+Njd2bdReAjY3BHQAAAFgFarXa9bLwF+7xotm+F9tM7w45x3UAAP5/knRZW+ZvV3X5UcnCQY/pT3N9DIDVIsk6AAAAAIB05MiRQ4MDAzflc7nzyq3jQ+Xm0dgsfpPFUMg6DQCAVcE81cDiPTp/+pZY6My05f6eYqHwA6Ojo3dk3QYAT+CVGQAAAGCVGRoaeoUs/JEs9J7YNBIWKi8UR3cAwMblqjYOasv8RJp0lxMz+6i7/1y9Xn8s6zIAeCpO7QAAAMAqdM0111yYy+f/XO57Fssv0IlNI4ohn3UWAADnVKkzrc2zE7HUPhFkNuEx/vT4+PgXs+4CgK+FwR0AAABYvcLw8PCb3PXLaa6iowO7kyYfVAUAbAC5dEmb5ydVXX5UrnBcnr5lfHz8TyXFrNsA4OthcAcAAABWuV27dg2HJPdR93jxTN/VNtt7FR9UBQCsSyG2tWnhLm1aui+avG3Se9vt9q9NTk4uZd0GAE8Hp3QAAABgDdixY0e1XC7/jru/qlHYGo8PvjR0k3LWWQAArAhTVP/ifRpcuCu12A6SbooxvnNiYuJw1m0A8EwwuAMAAABryPDw8A9G9w8qFErHBq5LlkrPyzoJAIBnzeSqLj2szQt3pEnaSKTw9yHoraOjo1NZtwHAs8HgDgAAAKwx11133cXdGD9q7iPzPZfp5KZdcoWsswAAePrcVW0e1OD8ZJrvLiRutl8xvoUPogJY6xjcAQAAgDWoVqvlJb1b0ls6+f54ZOCGpJPvyzoLAIBvwFVpHtHg3GQsdmeDzKY8xreOj49/QpJnXQcAzxWDOwAAALCGjYyMfFsa/SOSbT45MBzmKxeLYz4AYPVxVVpHNTB3Ryx1poPLHgymt42NjX1MUsy6DgBWCidxAAAAYI3buXPnefl88U+l+LLF8gt0YmBE0fJZZwEAoNNvtB/VwPydsdQ5FVzhkWD+zmq1+pF9+/Z1s64DgJXG4A4AAACsD6FWq/2sZO/tJhUd23xD0swPZt0EANio3FVtHdKm+alY7MwEV3hEnr6rr6/vzxnaAaxnDO4AAADAOjIyMjKSRv+4pOdP919jsz1XSMaxHwBwbphHVRuPamDhrjTfXUhkdp/H+It9fX3/i6EdwEbAyRsAAABYZ2q1Wr+kP5T0fcvFbX588CWWhmLWWQCAdSzEjvqWH9SmxXvTJG0kMpsw6ZfGxsb+StzRDmADYXAHAAAA1icbGhr6MZm9Pyal5NjAS5NG8bysmwAA60wuXVL/4v3qW7w/BqVBZp8OZr86Ojr6WUmedR8AnGsM7gAAAMA6Njw8/GKXPi73K2b6XqyZ3h1yHgMAAM+Jq9Q6of7F+1RtHnJJqeQfiTH+xsTExO1Z1wFAljhpAwAAAOtcrVarSPotSa9pFs6LxwZ3h25SzjoLALDGWOyot/GoNi3dn+Y7c4krzMjT/2Fmv1ev149k3QcAqwGDOwAAALBBDA0Nfb/MbvKQLx3b9JJkuXxh1kkAgDWg2JlV39KDqi499MS1MeMe4++e+RBqM+s+AFhNGNwBAACADWRkZGR7dN8r96G56hU61bdTbknWWQCAVSbEtnobj6t36cFY7EwHl1rB7COSPjA2NnYg6z4AWK0Y3AEAAIANZseOHYVSqfTLkt7Yyg/EY4MvDZ1cb9ZZAICMmVzl1lH1Lj2sSuPxGOTBpdtN+kNJH67X63NZNwLAasfgDgAAAGxQw8PD3xnd/lxm/cc3jYTFykVZJwEAzjlXsX1KvcuPqrf5WBrSViIL0/L4Z2b2obGxsYmsCwFgLWFwBwAAADawXbt2XRCS5MNy37NQuUgn+mvykM86CwBwNrmr2DmlauNx9TYeT5N0OXGpJfe/kvRhM/tUvV7vZJ0JAGsRgzsAAACwwd14443Jww8//NYY47vTfJ8fHXxp0soPZJ0FAFhB5qnKrePqaR5WT/NgmqSNRLKO5J8ws481Go2/m5qaWsy6EwDWOgZ3AAAAAJKkkZGRl0bXR939wun+a22253LJeGQAgLUqlzZUaR1RpXlYleaRaJ4GmS3L/RNm9pfFYvETt9xyy0LWnQCwnnB6BgAAAPCka6+9dlOSJB+U9L3LxfP9+MBLLE1KWWcBAJ6GEDsqt4+r3DqmSutomu/MJ5IkC497TP9G0t/Pz8/ve+CBB1rZlgLA+sXgDgAAAOCprFar/ahL74+hmDs+8JJkubQt6yYAwFMkaUPlzimVWidUah6Lxe5skCSZNeT+OUmfSpLkkwcOHLhfkmcaCwAbBIM7AAAAgK9qaGjoRRbCx+T+4rnqFTrVt1NuSdZZALAhBe+o0J5RqTOtYnta5c7JbtJdzkmSzBoedUsI2idpn7sf4KOnAJANBncAAAAAX9Oll15a7Ovr+xUz+9lOflN6ZGB30sn3Z50FAOuWeVQuXVSxO698e1bF7pyKnelurruUe+LvcYVHTPFLkv45xri/v7//tn379nUzzAYAnMHgDgAAAOAbqtVq3+6yP3dp86n+oTBfvVQ8TgDrkcvcZYoyj5KnMp3+c7nLJPmX3UxisjN/dvrvkgW5maTTP7olcjc+wPwUwbvKpUvKdZeUT5eU7y4q311QvjPfzaVLiclNktw9Wkju95hOhBAmJE3k8/n6/v37pzP+JQAAvgb+Fw8AAADA07Jr166tZslNZv7y5eI2PzF4vXUDH1QFVhvzqCS2lKQNJd5SkrZO/3lsK8SWQuwoxLaCtz3xbrTY8aBUFrvBPIazcdW3y1wW3C24W87dgtxylioxtyS45RQtkVtOMZz+8fTP5eQhJ7fkyb/ullNqyekx/8v+dR5yp0f/cz51uMzTM7+vHSXeVkhbSrx95ve9paTbUBIbysdGmksbsthJvvLfQUtmdr/HeI+Z3Wdmd6dpevfCwsI9fOAUANYWBncAAAAAz4QNDw+/Nrr/todC7vjA9clS6cKsm4ANxJWkLeXTpa94QzqXLiuXLqe5tKEQW1/jYwvWcWlOshmTz0g+I2nezBZjjEuSliUtm1lTUlNS28za7t519zSE0I0xxhBC1OlV3mKMQZKFEEKMMTGzRFJeUk5Swd2LIYSCuxfdvWhmRXcvmVlZ0hN/VCTrkVnVXT1mZ37OvSx57qv8Qr6uqBAt5DwqnBn2E8kSiwrmMnML5hYkC5JOv33vLj05kZjOvM3vOv0XnnjjP/WgGC2mbp6eHtm9a+Zp8nX/TwqzhrsdM/khyQ+7+0EzO2hmj6Zp+mg+n3/4wIED0+KjpgCwLjC4AwAAAHjGhoeHr3DpI3Ifmu+5RKf6dynaM97FAHwN5qkK3XnlO/Onf0wXlG/Px0K66Obdp7wdbafM9KjcHzOzQzHGw5KOmNnxGOMxdz8ZYzwxOTm5rDU26tZqtXwulyt3u90ed++RVHnixyRJemKM5RBCT4yxfGbEr0gqmVnZ3Ys6Peg/OfxLyrt7wd1zUsgrKCf3IIUz/wXmJpmbubt7arKu5F1JbUkdSQ1JrTM/LktadvcFM1swszlJc2mazuRyuVOSTuVyuZP79+9vnNvfNQBAlhjcAQAAADwrtVotL+lt7v62NNfjxwZ3J83C1qyzgDXGlUuXVezMqPDkBzJnurnuUqIz93hLlrr0cDDd7e73S3rQ3R8KITxcrVYf3bdvXzPTXwIAAHgSgzsAAACA56RWq13vsg+b/JLZ6pWa7t8pV8g6C1iVknRZpfa0Sp1TKrSnvdSZjuHMfd5f/oFMM5ty96kQwl3u/lC9Xu9k3Q4AAL4xBncAAAAAz1mtVqtI+u+SXt/J96XHNr0kaRUGs84CMmUeVezOqtQ6oWL7pMqtE90kNs9cXWIdN91u7qOSxt19oq+vb4q31QEAWNsY3AEAAACsmJGRkW9Lo39I8m2zvTtspneH3HjbHRuDKarUPqVS85jK7eNeap10Uzz9HwALD3tM/8nM/tndb221WndMTU21M04GAAArjMEdAAAAwIqq1Wr9kn5d0o928v3psU3X87Y71iWTq9A+pUrruMqto15snfAgD+4eZTZh0ufd/Z+63e4tk5OTx7PuBQAAZx+DOwAAAICzYmho6GWy8EeSb5vrfZFN913N3e5Y8/LpksrNI6q0jqrSOpba6fvX/czA/llJnysWi/90yy23LGTdCgAAzj0GdwAAAABnzfXXX9/X6XR+1cx+vJPrTY8PXJc0C1uzzgKeNlNUuXVcleYRVZqH0nx38fQHTmWPmvwf3P3TnU7nc3fcccdM1q0AACB7DO4AAAAAzrparfavXeGPTPGi+Z5LdarvGsWQzzoL+KqStKGe5mFVmodVaR6Jphhk1pT7ZyT9g6RP1ev1B7PuBAAAqw+DOwAAAIBzolarVdz9nZLeFHNlP9FfS5bKzxOPJcieq9CZOz2yNw7GUmc6nP5Ze9TkfyPpE729vV/Yt29fM+NQAACwynGyBQAAAHBOjYyMXBvdb5L70HLpAj/RX7NurifrLGwwJlexfUo9jYOqNh9Pc92lRJK72/4Q9Dcxxr8bHx+/R5Jn3QoAANYOBncAAAAA59yNN96YPPTQQ69z6VdcoTzTtyPMVa+UW5J1GtYx86hy+7gqjcdVbRxMk9hKXGqb9I9m9lftdvvvJycnj2fdCQAA1i4GdwAAAACZ2bVr1wVm9utm9gOdXDU9uWk4WS6en3UW1hHzVOXWMVUbj6vaPJRabCcuLZn0t2Z2c6PR+NTU1NRi1p0AAGB9YHAHAAAAkLldu3b9Gwu53zfFy5ZKF/qpTbusk1SzzsIaZYqqNI+o2nhcPc2DqcVu4rI5ebw5hHDz7OzsZx944IFW1p0AAGD9YXAHAAAAsCrs2LGjUCqVXu/SuySrzPVeaTO9OxQtl3Ua1oAvH9kry4/HoDS4wkww3yvp4+6+r16vd7LuBAAA6xuDOwAAAIBVZWRk5PwY43skvToNxTjdtzNZ6Nku5/EFT/HkdTHLj6naOv0muyxMe0z3SvpYX1/fF/bt29fNuhMAAGwcnFgBAAAArErDw8O7ovRb5v6vOvm+9FTfNclS6QLxGLOxmcczd7I/pmrzYGqxkzzxJnuM8aOM7AAAIEucVAEAAACsZjY0NPRdFsL75H55s7A1nuq/JjQLW7Luwjn0xMje03hMvU9++NTmTL7XzD5WrVY/x8gOAABWAwZ3AAAAAKvenj17couLi/9PdL3H5NuWi+f7dN9OaxUGs07DWWIeVW4fV8/yY6o2H09D7CSyMO8x/bikvWb2We5kBwAAqw2DOwAAAIA1Y/fu3eVOp/MTLnubPA4ulS7wmd4XM7yvE0+O7I3HVW08nobYTlxaNOlmM/too9H47NTUVDvrTgAAgK+FwR0AAADAmrNjx45qqVT6KZe91eSblkvbfKZ3h3HVzNpzemQ/duZN9oNpiJ0nR3ZJe5vN5qcZ2QEAwFrB4A4AAABgzdqxY0e1XC6/zmU/J4+bm4Wtcab3RWG5uE0yHndWK/NUldYRVRsH1dM8lFrsJDJbkPvNZra30Wh8hpEdAACsRZxAAQAAAKx5u3fvLrfb7Ve57C0mf0En35fO9lyRLFQukluSdR4khdhWpXlY1eZBVRqHoykGWZiWx5slfVzS57iTHQAArHUM7gAAAADWjT179uTm5+dfKbM3m1SLIZ/OVS5JFqqXqZP0ZJ234eS6S+ppHVZP46CXWsdlcnOFQ6Z4c4zx5ksvvfSWvXv3pll3AgAArBQGdwAAAADrkY2MjOx29ze463slT5aL23y+eqktF7fJLWTdty6ZXMX2KfU0j6ineTDNd+YSSXKFu0zxZnf/m/Hx8XFJnnEqAADAWcF+AzWkAAAFHklEQVTgDgAAAGBdq9Vq2yT9mCv8uClemIZiulC5OFmoXKR2flPWeWtekjZVbh1VT+uIKs3DaYidRLKuuz5v5n+bJMnfHThw4OGsOwEAAM4FBncAAAAAG8KNN96YPPzww9/u7q+S7Lslz7dym+JSz0Vhofx8dbly5mkxRZVaJ1VpHVG5eTQWOzNBklzhuDz9+xDC/06S5NO33nrrfNatAAAA5xqDOwAAAIANZ/fu3YPtdvv73e2HzfylktTMD8blyvPDUul5aud6s05cNcyjCp1plVvHVW4d81LruAd5kKwj0y1y/2SM8ZMTExOT4qoYAACwwTG4AwAAANjQarXaC8zslS59v9yvl6ROrpouly5Mlkvb1ChslVuSdeY5E7yrYvukSq2TKrdPeKl1wk0xSHKXJk36tLt/1sy+UK/Xl7PuBQAAWE0Y3AEAAADgjF27dl2QJMnL3f3lMvs3ci+5hdgsbLVG8TxrFLaqVdwi1/r46Kp5VL47p1JnRsX2KZXbJ9N8Zz5Ibu4eLYTbPMbPhxA+n8/nv7h///7prJsBAABWMwZ3AAAAAPgq9uzZU1pcXPyWGOO3WQjfLvdrJJnLvJUf9FZxc2gVBtXKD6qT65Wv6scrVy62lO/MqdCZU6Ezo2JnNha6czKPT9zBPmOKX5L0z+7+pVardWBqamox43AAAIA1ZTWfCAEAAABg1ajVav1m9lJJ3+yu3S6/zqQeSYqy2MlvUiffH9q5XnVyferkquokPYohr3Px6GVyhbShfLqsXHdR+XRJ+e6icp2FWErn3WL7yXtxXHZCHsfM7HYzq4cQ6gcOHHhE3MEOAADwnDC4AwAAAMCzE6677rpLY4w1P/32+9Uuu9rkz9OXPWu5JbGblGM3qSRpKFkaiopJUanl5aGgaIncEkUFyUx68rqaKHOXPCoolXmq4F2F2FaIbSWxrSS2lKTNmIuNGNJGYl/5jOeycMhjeq+ku83s7hDCVLfbvWtiYuLEufttAgAA2DgY3AEAAABgBe3Zs6c0Nze33cye+ON57v48d79QlmyTtEWe9pvZs74I3qUlszDj8qOK8bCZHXP3Q2Z2KITwSKfTebTT6Tw6NTXVXsFfGgAAAL4BBncAAAAAOPfshhtuqC4vL/fm8/lqp9Mp53K5gqR8jDG4uyVJkrp718zaZrbs7o0Y4/z27dsX9+7dm2b9CwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4P9rDw4IAAAAAIT8f92QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMBIubjAeWYHYIoAAAAASUVORK5CYII=" style="height:50px;"></td></tr>
    <tr><td headers="species" class="gt_row gt_left">Chinstrap</td>
<td headers="min" class="gt_row gt_right">2,700.00</td>
<td headers="mean" class="gt_row gt_right">3,733.09</td>
<td headers="max" class="gt_row gt_right">4,800.00</td>
<td headers="Distribution" class="gt_row gt_center"><img src="data:image/png;base64,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" style="height:50px;"></td></tr>
  </tbody>
  &#10;  
</table>
</div>

Excellent. This looks much better. So, crisis averted: No misleading
chart from us today.

Thus, let us end this blog post on this cheerful note. For more
information, you may find this [`gt` book
helpful](https://gt.albert-rapp.de/). See you next time. 👋

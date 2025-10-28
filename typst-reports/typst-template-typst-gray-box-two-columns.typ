#let blueline() = { line(length: 100%, stroke: 2pt + rgb("#68ACE5")) }

#let source_text(source_info) = {
  align(right)[
    #text(
      source_info,
      font: "Bitter",
      size: 9pt,
      style: "italic",
    )]
}

#let status-box(top-box-text: "", bottom-box-text: "") = {
  let top_box = box(
    width: 2in,
    height: 0.7in,
    fill: rgb("#002D72"),
    inset: 6pt,
    align(center + horizon)[
      #text(fill: white, weight: "bold", size: 9pt)[#top-box-text]
    ],
  )

  let bottom_box = box(
    width: 2in,
    height: 0.7in,
    fill: white,
    inset: 6pt,
    align(center + horizon)[
      #text(fill: black, size: 14pt)[#bottom-box-text]
    ],
  )

  stack(top_box, bottom_box, spacing: 0pt)
}

#let report(
  title: none,
  date: none,
  content,
) = {
  set page(
    paper: "us-letter",
    margin: (top: 0.5in, bottom: 1in, x: 0.75in),
    footer: {
      rect(
        width: 100%,
        height: 0.75in,
        outset: (x: 15%),
        fill: rgb("#68ACE5"),
        pad(top: 16pt, block([
          #grid(
            columns: (75%, 25%),
            align(left)[
              #text(
                upper(title),
                font: "Bitter",
                fill: white,
                weight: "bold",
              )
            ],
            align(right)[
              #text(
                upper(date),
                font: "Bitter",
                fill: white,
                weight: "bold",
              )
            ],
          )
        ])),
      )
    },
  )
  set text(
    lang: "en",
    region: "US",
    font: "Lato",
    size: 11pt,
  )
  show heading: it => {
    let sizes = (
      "1": 16pt, // Heading level 1
      "2": 10pt, // Heading level 2
    )
    let level = str(it.level)
    let size = sizes.at(level)
    let formatted_heading = if level == "1" { upper(it) } else { it }
    let alignment = if level == "2" { center } else { left }

    set text(
      size: size,
      fill: rgb("#002D72"),
      font: "Bitter",
      weight: "bold",
    )
    align(alignment)[#formatted_heading]
  }

  image("logo.png", width: 4in)

  blueline()

  grid(
    columns: (80%, 15%, 5%),
    align(left)[
      #text(
        upper(title),
        font: "Bitter",
        size: 20pt,
        fill: rgb("#002D72"),
        weight: "bold",
      )
    ],
    align(right)[
      #image("flag.svg")
    ],
    align(right)[],
  )

  blueline()

  content
}

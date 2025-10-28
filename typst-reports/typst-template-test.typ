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
        pad(top: 16pt, block(
          width: 100%,
          fill: rgb("#68ACE5"),
          [
            #grid(
              columns: (75%, 25%),
              align(left)[
                #text(upper(title), fill: white, weight: 600, font: "Bitter")
              ],
              align(right)[
                #text(upper(date), fill: white, weight: 600, font: "Bitter")],
            )
          ],
        )),
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
      "1": 18pt, // Heading level 1
      "2": 16pt, // Heading level 2
      "3": 14pt, // Heading level 3
      "4": 12pt, // Heading level 4
    )
    let level = str(it.level)
    let size = sizes.at(level)

    set text(
      size: size,
      fill: rgb("#002D72"),
      font: "Bitter",
      weight: "bold",
    )
    it
  }

  content
}

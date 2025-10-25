# How to Make High-Quality PDFs with Quarto and Typst
David Keyes
2025-10-24

In our consulting work as [Clarity Data Studio](https://claritydatastudio.com/), we make a lot of PDFs, like the [recent reports looking at childhood immunization made for the Johns Hopkins University International Vaccine Access Center.](https://publichealth.jhu.edu/ivac/monitoring-childhood-immunization-at-the-state-level)

\[TODO: add screenshots\]

Many clients come to us for support making highly-branded PDF reports, something I spoke about in my 2024 posit::conf talk [Report Design in R: Small Tweaks that Make a Big Difference](https://www.youtube.com/watch?v=bp1SMhLoz_M&list=PL9HYL-VRX0oSFkdF4fJeY63eGDvgofcbn&index=30&t=1s&ab_channel=PositPBC)

In the last couple years, we’ve moved to Typst almost exclusively for making PDFs. Of the two promises that Typst makes (powerful and easy to learn), we agree with the first. The second, however, a bit less so.

[The Typst website has great documentation](https://typst.app/docs/), but it mostly covers how to write directly in Typst, rather than working in Quarto and rendering with Typst. People often ask me how we make reports with Typst, but I don’t have anywhere to point them to.

So, along with consultant [Joseph Barbier](https://barbierjoseph.com/) (who has become a true expert in this area), here is an extended tutorial on making high-quality PDFs using Quarto and Typst. We’ll recreate elements of the [childhood immunization reports made for the Johns Hopkins University International Vaccine Access Center.](https://publichealth.jhu.edu/ivac/monitoring-childhood-immunization-at-the-state-level).

\[TODO: Add screenshot of reports\]

Let’s get started!

## Create a Quarto Document

To begin, we’ll create a Quarto document. You might be tempted to use YAML with `format: pdf`, like so:

``` yaml
---
title: Status of Childhood Immunization in Alabama
format: pdf
---
```

With `format: pdf`, Quarto will use LaTeX to render your PDF. Instead, we’ll use `format: typst`:

``` yaml
---
title: Status of Childhood Immunization in Alabama
format: typst
---
```

If you render your report, it looks quite plain:

\[TODO: Add screenshot\]

### Tweaks within Quarto doc

If you look at the [Quarto docs](https://quarto.org/docs/output-formats/typst.html), you’ll see that you can make additional tweaks within the YAML. You can set properties like the font, page size and margins:

``` yaml
---
title: Status of Childhood Immunization in Alabama
format:
  typst:
    mainfont: "Comic Sans MS"
    papersize: us-letter
    margin:
      x: 2in
      y: 2in
---
```

On rendering, we can see our updated PDF:

\[TODO: Add screenshot\]

TODO: Show other options: https://quarto.org/docs/reference/formats/typst.html#figures

YAML options get us started, but they don’t let us do things like set different fonts and fonts for text.

## `_brand.yml`

The next step on our PDF customization journey takes us to [brand.yml](https://posit-dev.github.io/brand-yml/). This tool, created by Posit developer Garrick Aden-Buie ([I spoke with him about it in June 2025](https://rfortherestofus.com/2025/06/podcast-episode-27)), allows you to create a single `_brand.yml` file that controls the look and feel of files rendered from Quarto docs (this goes beyond the scope of this blog post, but you can use a single `_brand.yml` file to make multiple formats follow your brand guidelines).

Let’s create a `_brand.yml` file. This file will allow us to use custom fonts (Bitter and Lato, which is close to the actual font, known as Gentian, used for the reports). Additionally, we will set the color of the headings to be a navy blue.

``` yaml
TODO: add fonts: Lato and Bitter
```

This gets us a decent part of the way there. But see how all of the headings are the same size? That’s not ideal and `_brand.yml` doesn’t give us any tools to fix this. It also doesn’t allow us to make customizations to the header or the footer of our report. Overall, `_brand.yml` is great if you want to make some simple customizations to a PDF document, but if we want to make a truly unique report, we’ll need to create a custom Typst template.

## Create a custom Typst template

In order to make a custom Typst template, we’ll begin by deleting the `_brand.yml` file. Instead, we’ll create two files:

- `typst-show.typ`
- `typst-template.typ`

The `typst-show.typ` file connects Quarto and Typst, enabling us to pass variables from the former to the latter. We’ll see this show up when doing things like adding the title in the footer of the report:

\[TODO: Add screenshot of footer like this: https://show.rfor.us/mfWZhKKR\]

The `typst-template.typ` file is where we will define our custom template. We’ll use it to do things like set text styles, design headers and footers, and more.

We also need to tell our Quarto document to use these files, which we can do by adjusting our YAML:

``` yaml
---
title: Status of Childhood Immunization in Alabama
format:
   typst:
      template-partials: 
         - typst-show.typ
         - typst-template.typ
---
```

### The `typst-show.typ` file

Our `typst-show.typ` file looks like this:

``` typ
#show: body => report(
  title: [$title$],
  date: [$date$],
  body,
)
```

The Typst syntax ([detailed in great depth on the Typst website](https://typst.app/docs/reference/syntax/)) tells Typst to take the `title` (“Status of Childhood Immunization in Alabama”) and `date` (“September 2025”) data from Quarto and pass them to Typst. You’ll see that `title` and `date` are wrapped within a function we create called `report()` ([Typst has functions just like R does](https://typst.app/docs/reference/foundations/function/)). This function is how we’ll create our template, which we’ll do in the `typst-template.typ` file.

### The `typst-template` file

The `typst-template.typ` file defines our template. We’ll use it to do things like define our paper size, margins and text styles, add headers and footers, and more.

We’ll begin by adding the following code to our `typst-template.typ` file:

``` typ
#let report(
  title: none,
  date: none,
  content,
) = {
  content
}
```

This again allows us to define a Typst function we call `report()` with three arguments: `title`, `date`, and `content`. The `title` and `date` arguments will take data from our Quarto doc (passed through by the `typst-show.typ` file). The `content` argument allows us to pass all content from our Quarto document to the template.

We can render our report again and see what it looks like:

\[TODO: Add screenshot\]

Nothing looks terribly different, though you’ll see that the title is no longer there (we’ll add it back soon). For now, though, let’s begin by customizing the look and feel of the report.

#### Paper Size, Margins, etc

We can begin by adjusting the paper size and margins of our report. We’ll use what’s known as a [set rule](https://typst.app/docs/reference/styling/#set-rules) in Typst. The set rule allows us to define the styling of some element. We want to style the report as a whole, which we do using the `page()` function:

``` typ
#let report(
  title: none,
  date: none,
  content,
) = {
  set page(
    paper: "us-letter",
    margin: (top: 0.5in, bottom: 1in, x: 2in),
  )
  content
}
```

You can see that I’ve defined the paper size with the `paper` argument to be “us-letter” (i.e. 8.5 by 11 inches). You can choose any number of preset options for paper sizes or use the `height` and `width` arguments to manually specify the size.

I’ve also defined the margins, setting the top and bottom margins to a reasonable 0.5 inches and 1 inch respectively. I’ve made the margins on the side (that is, the `x` margins) be 2 inches in order to make this change obvious when rendering:

\[TODO: Add screenshot\]

Now that we’ve adjusted the overall page properties, it’s time to adjust the text style.

#### Set text style

To set the text style, we’ll also use a set rule. In this case, we’ll combine the set rule with the `text()` function. Our updated `typst-template.typ` file now looks like this:

``` typ
#let report(
  title: none,
  date: none,
  content,
) = {
  set page(
    paper: "us-letter",
    margin: (top: 0.5in, bottom: 1in, x: 0.75in),
  )
  set text(
    lang: "en",
    region: "US",
    font: "Lato",
    size: 11pt,
  )

  content
}
```

You can see how, within the `text()` function, we’ve set both the language (English), the region (US), the font family to use (Lato), and the size (11pt). The font family and size will be visible when we render again:

\[TODO: Add screenshot\]

#### Set heading style

You’ll see that while we’ve changed the font family for both paragraph text and headings in our rendered report, we haven’t changed the size of headings (i.e. the headings still use their default sizes, not 11pt). In order to target headings, we need to use what’s known as a [show rule](https://typst.app/docs/reference/styling/#show-rules). Our `typst-template.typ` file now looks like this:

``` typ
#let report(
  title: none,
  date: none,
  content,
) = {
  set page(
    paper: "us-letter",
    margin: (top: 0.5in, bottom: 1in, x: 0.75in),
  )
  set text(
    lang: "en",
    region: "US",
    font: "Lato",
    size: 11pt,
  )
  show heading: set text(
    font: "Bitter",
    size: 20pt,
    weight: "bold",
  )

  content
}
```

Our show rule tells Typst to just target headings. From there, we again use a set rule to specify the font, size, and weight.

At this point, all of headings are the exact same size. But we likely want to have level 2 headings be larger than level 3 headings and so on. To do this, we need to alter our heading syntax a bit, using instead what Typst calls a [show rule with function](https://typst.app/docs/reference/styling/#show-rules). Our `typst-template.typ` file now looks like this:

``` typ
#let report(
  title: none,
  date: none,
  content,
) = {
  set page(
    paper: "us-letter",
    margin: (top: 0.5in, bottom: 1in, x: 0.75in),
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
```

The code now uses the show rule with function with the parameter `heading_properties`. The line `show heading: it =>` defines what Typst calls an [unnamed function](https://typst.app/docs/reference/foundations/function/#unnamed). The `it` here is the function’s parameter. Within the function, we begin by defining the sizes in what Typst calls a [dictionary](https://typst.app/docs/reference/foundations/dictionary/) (kind of like a named list in R TODO check if this is right):

``` typ
let sizes = (
  "1": 18pt, // Heading level 1
  "2": 16pt, // Heading level 2
  "3": 14pt, // Heading level 3
  "4": 12pt, // Heading level 4
)
```

We then tell Typst to pull the level from the sizes using the code `let level = str(it.level)`. Next, we define `size` with this code: `let size = sizes.at(level)`. We then use the `size` variable we have created in setting the properties of the headings (we’ve also adjusted the color here to be blue):

``` typ
set text(
    size: size,
    fill: rgb("#002D72"),
    font: "Bitter",
    weight: "bold",
  )
```

Finally, within our unnamed function, we return `it`, which contains all of the properties of our headings. We can see the changes when we render:

\[TODO: Add screenshot\]

#### Header and footer

We’ve dealt with paragraph and heading text. Next, let’s customize our report’s footer. In the reports we made, we added the report title as well as the date in the footer:

\[TODO: Add screenshot\]

To do this

#### Custom elements (e.g. blue lines, flags, status-boxes)

#### Cover page

## Tools to Use

## Conclusion

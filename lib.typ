#import "core/theming.typ" as core
#import "components/button.typ" as buttons
#import "components/sidebar.typ" as sidebar
#import "components/sweeps.typ" as sweeps

#let theme-state = state("theme-state")

#let tiefcars(
  theme: "tng",
  body,
) = {
  core.apply-theme(theme)

  context {
    let theme = theme-state.get()
    set text(font: "Antonio", size: 10.5pt, fill: theme.fg)
    set page(margin: 20pt, fill: theme.bg)

    body
  }
}

#let one-page-layout(title: none, subtitle-text: none, top-height: 4, sidebar-button-texts: (), body) = {
  sidebar.sidebar(top-height: top-height, button-texts: sidebar-button-texts)

  context {
    let theme = theme-state.get()
    set text(fill: theme.heading, size: 40pt, weight: "bold")
    place(top + right, title)
  }

  place(top + left, dx: 120pt, dy: 60pt, box(width: 100% - 120pt, align(left, subtitle-text)))

  place(top + left, dx: 120pt, dy: top-height * 45pt + 160pt, box(
    width: 100% - 120pt,
    height: 100% - top-height * 45pt - 160pt,
    body,
  ))
}

#let multi-page-layout(odd-even: false, sidebar-button-texts: (), sidebar-width: 80pt, page-margins: 15pt, body) = {
  let margin-ext = 20pt
  let h1-pad = 20pt

  context {
    let theme = theme-state.get()

    let heading-positions-state = state("heading-positions-state", ())
    show heading: it => {
      let current-heading-position = here().position().y
      heading-positions-state.update(prev => (..prev, current-heading-position))
      pad(left: h1-pad, it)
    }

    let sel-page-margins
    if type(page-margins) == int {
      sel-page-margins = (top: page-margins, right: page-margins, bottom: page-margins, left: page-margins)
    } else {
      sel-page-margins = page-margins
    }

    sel-page-margins = (
      top: sel-page-margins + 10pt,
      right: sel-page-margins,
      bottom: sel-page-margins,
      left: sel-page-margins + sidebar-width + margin-ext,
    )

    set page(
      margin: sel-page-margins,
    )

    place(
      top + left,
      dx: -sidebar-width - margin-ext,
      dy: -10pt,
      {
        stack(
          dir: ttb,
          spacing: 5pt,
          sidebar.sidebar-button(5pt, sidebar-width),
          sweeps.top-sweep(60pt, sidebar-width, theme.heading, sweep-width: margin-ext + h1-pad - 5pt),
          v(15pt),
          sweeps.bottom-sweep(40pt, sidebar-width, theme.heading, sweep-width: margin-ext + h1-pad - 5pt),
          sidebar.sidebar-button(15pt, sidebar-width, elem-text: ""),
          sweeps.top-sweep(40pt, sidebar-width, theme.heading, sweep-width: margin-ext + h1-pad - 5pt),
          sidebar.sidebar-button(40pt, sidebar-width),
          sidebar.sidebar-button(40pt, sidebar-width),
          sidebar.sidebar-button(40pt, sidebar-width),
          sidebar.sidebar-button(40pt, sidebar-width),
          sidebar.sidebar-button(40pt, sidebar-width),
          sidebar.sidebar-button(40pt, sidebar-width),
        )
      },
    )

    v(40pt)
    [
      #set text(size: 23pt, fill: theme.heading)

      #pad(left: margin-ext + 5pt, stack(
        dir: ltr, spacing: 5pt)[
        #box(radius: (left: 10pt), height: 20pt, width: 20pt, fill: theme.heading)
      ][
        The Title Of The Document
      ][
        #box(radius: (right: 10pt), height: 20pt, width: 20pt, fill: theme.heading)
      ])
    ]

    body
  }
}

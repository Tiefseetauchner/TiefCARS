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

#let default-layout(title: none, subtitle-text: none, top-height: 4, body, sidebar-button-texts: ()) = {
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

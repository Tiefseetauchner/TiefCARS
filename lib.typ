#import "core/theming.typ" as core
#import "components/button.typ" as buttons
#import "components/sidebar.typ" as sidebar

#let theme-state = state("theme-state")

#let lcars(
  theme: "tng",
  body,
) = {
  core.apply-theme(theme)

  set text(font: "Antonio", size: 10.5pt)

  context {
    let theme = theme-state.final()
    set page(margin: 10pt, fill: theme.bg)

    body
  }
}


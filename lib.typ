#import "core/theming.typ": apply-theme, tng-theme-dark
#import "components/button.typ": l-button

#let theme-state = state("theme-state", tng-theme-dark)
#let button = l-button

#let lcars(
  theme: "tng",
  body,
) = {
  apply-theme(theme)

  context {
    let theme = theme-state.final()
    set page(margin: 10pt, fill: theme.bg)

    body
  }
}


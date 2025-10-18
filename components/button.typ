#let button(variant, inset: none, body) = {
  context {
    let theme = state("theme-state").final()
    let selected-variant = theme.accent.at("a-" + str(variant))
    if inset == none {
      inset = (y: 8pt, x: 16pt)
    }

    set text(fill: theme.elem-fg)

    box(
      inset: inset,
      fill: selected-variant,
      radius: 4pt,
    )[
      #body
    ]
  }
}

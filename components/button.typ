#let button(variant, inset: none, body) = {
  context {
    let theme = state("theme-state").final()
    let selected-variant = theme.accent.at("a-" + str(variant))
    let sel-inset = if inset == none {
      (y: 8pt, x: 16pt)
    } else { inset }

    set text(fill: theme.elem-fg)

    box(
      inset: sel-inset,
      fill: selected-variant,
      radius: 4pt,
    )[
      #body
    ]
  }
}

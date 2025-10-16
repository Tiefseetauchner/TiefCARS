#let l-button(variant) = {
  context {
    let theme = state("theme-state").final()
    let selected-variant = if variant == 1 {
      theme.variant-1
    } else if variant == 2 {
      theme.variant-2
    } else if variant == 3 {
      theme.variant-3
    } else if variant == 4 {
      theme.variant-4
    } else if variant == 5 {
      theme.variant-5
    } else {
      assert(true, "Selected button variant '" + variant + "' is not available.")
    }

    box(
      inset: (y: 8pt, x: 16pt),
      fill: selected-variant,
      radius: 4pt,
    )[
      #text(
        "Button",
        fill: theme.fg,
      )
    ]
  }
}

#let tng-theme-dark = (
  variant-1: color.rgb("cc4444"),
  variant-2: color.rgb("5566ff"),
  variant-3: color.rgb("8899ff"),
  variant-4: color.rgb("9966ff"),
  variant-5: color.rgb("cc5599"),
  bg: luma(5%),
  fg: black,
)

#let nemesis-blue-theme-dark = (
  prim: color.hsv(210deg, 50%, 30%),
  sec: color.hsv(210deg, 50%, 50%),
  acc: color.hsv(210deg, 90%, 70%),
  bg: color.hsv(210deg, 50%, 20%),
  fg: color.hsv(210deg, 50%, 90%),
  fg-sec: color.hsv(210deg, 50%, 60%),
  fg-acc: color.hsv(210deg, 90%, 90%),
)

#let apply-theme(theme) = {
  let selected-theme = if theme == "tng" { tng-theme-dark } else if theme == "nemesis-blue" {
    nemesis-blue-theme-dark
  } else {
    assert(true, "Selected theme '" + theme + "' is not available.")
  }

  set text(font: "Antonio", size: 10.5pt)

  state("theme-state").update(selected-theme)
}

#let tng-theme-dark = (
  accent: (
    a-0: color.rgb("666688"),
    a-1: color.rgb("ffaa90"),
    a-2: color.rgb("8899ff"),
    a-3: color.rgb("f5f6fa"),
    a-4: color.rgb("ff9966"),
  ),
  red: color.rgb("cc4444"),
  green: color.rgb("999933"),
  bg: luma(5%),
  fg: white,
  elem-fg: black,
)

#let nemesis-blue-theme-dark = (
  accent: (
    a-0: color.rgb("2233ff"),
    a-1: color.rgb("2266ff"),
    a-2: color.rgb("6699ff"),
    a-3: color.rgb("88bbff"),
    a-4: color.rgb("9966cc"),
  ),
  red: color.rgb("cc2233"),
  green: color.rgb("99cc33"),
  bg: luma(5%),
  fg: white,
  elem-fg: black,
)

#let apply-theme(theme) = {
  let selected-theme = if theme == "tng" {
    tng-theme-dark
  } else if theme == "nemesis-blue" {
    nemesis-blue-theme-dark
  } else {
    assert(true, "Selected theme '" + theme + "' is not available.")
  }

  state("theme-state").update(selected-theme)
}

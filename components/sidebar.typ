#let sidebar-button-color-state = state("sidebar-button-color-state", 256)

#let m = 123843
#let a = 16807
#let next = s => {
  let s2 = if s <= 0 { 1 } else if s >= m { calc.rem(s, m) } else { s }
  calc.rem(s2 * a, m)
}
#let pick5 = s => {
  let x = next(s)
  calc.floor((s * 5) / m)
}

#let random-string() = {
  let res = (
    str(calc.rem(next(sidebar-button-color-state.get()), 10))
      + "-"
      + str(calc.rem(next(next(sidebar-button-color-state.get())), 10))
      + str(calc.rem(next(next(next(sidebar-button-color-state.get()))), 10))
      + str(calc.rem(next(next(next(next(sidebar-button-color-state.get())))), 10))
      + str(calc.rem(next(next(next(next(next(sidebar-button-color-state.get()))))), 10))
      + str(calc.rem(next(next(next(next(next(next(sidebar-button-color-state.get())))))), 10))
      + str(calc.rem(next(next(next(next(next(next(next(sidebar-button-color-state.get()))))))), 10))
  )
  res
}

#let sidebar-button(height, width, color: none, text: none) = {
  context {
    let sel-color
    if color == none {
      let theme = state("theme-state").final()
      sidebar-button-color-state.update(curr => next(curr))
      sel-color = theme.accent.at("a-" + str(pick5(sidebar-button-color-state.get())))
    } else {
      sel-color = color
    }

    let sel-text
    if text == none {
      sel-text = random-string()
    } else {
      sel-text = text
    }

    box(height: height, width: width, fill: sel-color, inset: 5pt, align(end + bottom, sel-text))
  }
}

#let sidebar-bar(height, width, page-width, color: none, top-text: none, bottom-text: none) = {
  let theme = state("theme-state").final()
  let sel-color
  if color == none {
    sidebar-button-color-state.update(curr => next(curr))
    sel-color = theme.accent.at("a-" + str(pick5(sidebar-button-color-state.get())))
  } else {
    sel-color = color
  }

  let sel-top-text
  if text == none {
    sel-top-text = random-string()
  } else {
    sel-top-text = top-text
  }

  let sel-bottom-text
  if text == none {
    sel-bottom-text = random-string()
  } else {
    sel-bottom-text = bottom-text
  }

  box(
    // stroke: (paint: green),
    width: page-width,
    height: height,
    stack(
      place(
        top + left,
        dy: -height / 6,
        box(
          clip: true,
          width: height / 1.5,
          height: height / 1.5,
          radius: height / 3,
          place(
            top + left,
            dy: height / 3,
            box(
              fill: sel-color,
              width: height / 3,
              height: height / 3,
            ),
          ),
        ),
      ),
      place(
        top + left,
        dy: height / 6,
        dx: height / 3,
        box(
          fill: sel-color,
          height: height / 3,
          width: width,
        ),
      ),
      place(
        top + left,
        dy: height / 12,
        dx: width,
        box(
          fill: sel-color,
          width: height / 12,
          height: height / 12,
        ),
      ),
      place(
        top + left,
        dx: width,
        box(
          fill: theme.bg,
          width: height / 6,
          height: height / 6,
          radius: height / 12,
        ),
      ),
      place(top + left, box(
        fill: sel-color,
        width: width,
        height: height / 6,
        inset: 5pt,
        align(end + bottom, sel-top-text),
      )),
    ),
  )
}

#let sidebar(top-height: none) = {
  if top-height == none {
    top-height = 4
  }
  let sidebar-width = 100pt
  layout(size => {
    stack(
      dir: ttb,
      spacing: 5pt,
      sidebar-button(5pt, sidebar-width, text: ""),
      ..range(top-height).map(x => {
        sidebar-button(40pt, sidebar-width)
      }),
      sidebar-bar(200pt, sidebar-width, size.width),
    )
  })
}

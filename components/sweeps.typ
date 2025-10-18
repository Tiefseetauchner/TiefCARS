#import "../core/rnd.typ": *

#let bottom-sweep(height, width, sweep-color, sweep-width: none, sweep-text: none) = {
  context {
    let theme = state("theme-state").final()
    let sel-sweep-text
    if sweep-text == none {
      sel-sweep-text = random-string(1, 4732)
    } else {
      sel-sweep-text = sweep-text
    }

    let sel-sweep-width = if sweep-width == none { width / 1.5 } else { sweep-width }

    // Top left rounded corner
    place(
      bottom + left,
      dy: height / 6,
      box(
        clip: true,
        width: height / 1.5,
        height: height / 1.5,
        radius: height / 3,
        // place(top + left, box(fill: sweep-color, width: height / 3, height: height / 3)),
        [
          #place(top + left, box(fill: sweep-color, width: height / 3, height: height / 6)),
          #place(top + left, box(fill: sweep-color, width: height / 6, height: height / 3)),
        ],
      ),
    )
    // Fill to inner rounded corner
    place(bottom + left, dy: -height / 6, dx: height / 6, box(
      fill: sweep-color,
      height: height / 6,
      width: width - height / 6,
    ))
    // Right extending box
    place(bottom + left, dy: -height / 3, dx: width, box(
      fill: sweep-color,
      height: height / 6,
      width: sel-sweep-width,
    ))
    // Fill to right extending box
    place(bottom + left, dy: -height / 3, dx: height / 3, box(
      fill: sweep-color,
      height: height / 6,
      width: width - height / 3,
    ))
    // Fill for inner rounded corner
    place(bottom + left, dy: -height * 3 / 12, dx: width, box(
      fill: sweep-color,
      width: height / 12,
      height: height / 12,
    ))
    // Overlay for inner rounded corner
    place(bottom + left, dy: -height / 6, dx: width, box(
      fill: theme.bg,
      width: height / 6,
      height: height / 6,
      radius: height / 12,
    ))
    // Bottom  box
    place(bottom + left, box(
      fill: sweep-color,
      width: width,
      height: height / 6,
      inset: 5pt,
      align(end + bottom, sel-sweep-text),
    ))
  }
}

#let top-sweep(height, width, sweep-color, sweep-width: none, sweep-text: none) = {
  context {
    let theme = state("theme-state").final()
    let sel-sweep-text
    if sweep-text == none {
      sel-sweep-text = random-string(1, 4732)
    } else {
      sel-sweep-text = sweep-text
    }

    let sel-sweep-width = if sweep-width == none { width / 1.5 } else { sweep-width }

    // Bottom Left rounded corner
    place(top + left, dy: -height / 6, box(
      clip: true,
      width: height / 1.5,
      height: height / 1.5,
      radius: height / 3,
      place(bottom + left, box(fill: sweep-color, width: height / 3, height: height / 3)),
    ))
    // Right extending box
    place(top + left, dy: height / 3, dx: width, box(fill: sweep-color, height: height / 6, width: sel-sweep-width))
    // Fill to right extending box
    place(top + left, dy: height / 3, dx: height / 3, box(
      fill: sweep-color,
      height: height / 6,
      width: width - height / 3,
    ))
    // Fill for inner rounded corner
    place(top + left, dy: height * 3 / 12, dx: width, box(
      fill: sweep-color,
      width: height / 12,
      height: height / 12,
    ))
    // Overlay for inner rounded corner
    place(top + left, dy: height / 6, dx: width, box(
      fill: theme.bg,
      width: height / 6,
      height: height / 6,
      radius: height / 12,
    ))
    // Fill to inner rounded corner
    place(top + left, dy: height / 6, dx: height / 6, box(
      fill: sweep-color,
      height: height / 6,
      width: width - height / 6,
    ))
    // Top box
    place(top + left, box(
      fill: sweep-color,
      width: width,
      height: height / 6,
      inset: 5pt,
      align(end + bottom, sel-sweep-text),
    ))
  }
}

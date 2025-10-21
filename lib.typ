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

#let one-page-layout(title: none, subtitle-text: none, top-height: 4, sidebar-button-texts: (), body) = {
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

#let multi-page-layout(
  odd-even: false,
  sidebar-button-texts: (),
  sidebar-width: 80pt,
  page-margins: 15pt,
  title: none,
  body,
) = {
  let margin-ext = 20pt
  let h1-pad = 20pt

  context {
    let theme = theme-state.get()

    let heading-positions-state = state("heading-positions-state", ())
    let current-y-position-state = state("current-y-position-state", 10pt)
    let prev-y-position-state = state("prev-y-position-state", 10pt)

    show heading: it => {
      let current-heading-position = here().position().y
      let page-number = here().page()

      heading-positions-state.update(prev => (..prev, (page: page-number, y-pos: current-heading-position)))
      set text(size: 15pt)
      pad(left: h1-pad, it)
    }

    let sel-page-margins
    if type(page-margins) == int {
      sel-page-margins = (top: page-margins, right: page-margins, bottom: page-margins, left: page-margins)
    } else {
      sel-page-margins = page-margins
    }

    sel-page-margins = (
      top: sel-page-margins + 10pt,
      right: sel-page-margins,
      bottom: sel-page-margins,
      left: sel-page-margins + sidebar-width + margin-ext,
    )

    set page(
      margin: sel-page-margins,
      background: context {
        place(
          top + left,
          dx: sel-page-margins.left,
          dy: sel-page-margins.top,
          box(
            width: 100% - sel-page-margins.left - sel-page-margins.right,
            height: 100% - sel-page-margins.top - sel-page-margins.bottom,
            stroke: (paint: green),
          ),
        )
        // layout(page-size => {
        let page-number = here().page()

        let heading-positions-of-page = heading-positions-state.final().filter(h => h.page == page-number)

        place(
          top + left,
          dy: sel-page-margins.top - 10pt,
          dx: sel-page-margins.left - sidebar-width - margin-ext,
        )[
          #sidebar.sidebar-button(5pt, sidebar-width, elem-text: "")

          #for h in heading-positions-of-page {
            context {
              let prev-y-position = prev-y-position-state.get()
              prev-y-position-state.update(c => h.y-pos)

              let y-pos = h.y-pos - sel-page-margins.top + 10pt
              let current-y-position = current-y-position-state.get()
              let remaining-buttons-height = y-pos - current-y-position
              let remaining-buttons = calc.floor(remaining-buttons-height / 45pt)
              let last-button-height = if remaining-buttons-height > 0pt {
                remaining-buttons-height - (remaining-buttons * 40pt) + 5pt
              } else {
                0pt
              }

              current-y-position-state.update(c => c + y-pos + 45pt)

              place(top + left, dy: prev-y-position + 30pt)[
                #stack(
                  dir: ttb,
                  spacing: 5pt,
                  ..range(remaining-buttons).map(_ => { sidebar.sidebar-button(40pt, sidebar-width) }),
                  if last-button-height >= 0pt {
                    sidebar.sidebar-button(last-button-height, sidebar-width, elem-text: if last-button-height > 20pt {
                      none
                    } else {
                      ""
                    })
                  },
                )]
              place(
                top + left,
                dy: y-pos,
              )[
                #sweeps.bottom-sweep(40pt, sidebar-width, theme.heading, sweep-width: margin-ext + h1-pad - 5pt)
                #place(top + right, dx: 400pt)[
                  #box(width: 300pt)[
                    y-pos: #y-pos
                    current-y-position: #current-y-position
                    remaining-buttons-height: #remaining-buttons-height
                    remaining-buttons: #remaining-buttons
                    last-button-height: #last-button-height
                  ]
                ]
              ]
            }
          }
        ]
        // })
      },
    )

    if title != none {
      v(40pt)
      [
        #set text(size: 23pt, fill: theme.heading)

        #pad(left: margin-ext + 5pt, stack(
          dir: ltr,
          spacing: 5pt,
        )[
          #box(radius: (left: 10pt), height: 20pt, width: 20pt, fill: theme.heading)
        ][
          The Title Of The Document
        ][
          #box(radius: (right: 10pt), height: 20pt, width: 20pt, fill: theme.heading)
        ])
      ]
    }

    body
  }
}

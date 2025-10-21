#import "../components/sidebar.typ" as sidebar
#import "../components/sweeps.typ" as sweeps

#let multi-page-layout(
  odd-even: false,
  sidebar-width: 80pt,
  page-margins: 15pt,
  title: none,
  body,
) = {
  let margin-ext = 20pt
  let h1-pad = 20pt

  context {
    let first-page = here().page()
    let theme = state("theme-state").get()

    let heading-positions-state = state("heading-positions-state", ())

    show heading: it => {
      let current-heading-position = here().position().y
      let page-number = here().page()

      heading-positions-state.update(prev => (..prev, (page: page-number, y-pos: current-heading-position)))
      set text(size: 15pt)
      pad(left: h1-pad, it)
    }

    let sel-page-margins
    if type(page-margins) == length {
      sel-page-margins = (top: page-margins, right: page-margins, bottom: page-margins, left: page-margins)
    } else {
      sel-page-margins = page-margins
    }


    sel-page-margins = (
      top: sel-page-margins.top + 10pt,
      right: sel-page-margins.right,
      bottom: sel-page-margins.bottom,
      left: sel-page-margins.left + sidebar-width + margin-ext,
    )

    let title-height = if title != none { 65pt } else { 0pt }

    set page(
      margin: sel-page-margins,
      background: context {
        place(top + left)[
          #layout(page-size => {
            let page-number = here().page()
            let is-even-page = calc.rem(page-number, 2) == 0

            let heading-positions-of-page = heading-positions-state.final().filter(h => h.page == page-number)

            place(
              top + left,
              dy: sel-page-margins.top - 10pt,
              dx: sel-page-margins.left - sidebar-width - margin-ext,
            )[
              #let sidebar-elements = ()
              #sidebar-elements.push(sidebar.sidebar-button(5pt, sidebar-width, elem-text: ""))
              #sidebar-elements.push(v(5pt))
              #let current-y-position = 10pt

              #if title != none and page-number == first-page {
                sidebar-elements.push([
                  #sweeps.top-left-sweep(60pt, sidebar-width, theme.red, sweep-width: margin-ext + h1-pad - 5pt)

                  #place(top + left, dy: 40pt, dx: sidebar-width + margin-ext + h1-pad)[
                    #stack(
                      dir: ltr,
                      spacing: 5pt,
                    )[
                      #box(radius: (left: 10pt), height: 20pt, width: 20pt, fill: theme.heading)
                    ][
                      #set text(size: 23pt, fill: theme.heading)
                      #title
                    ][
                      #box(radius: (right: 10pt), height: 20pt, width: 20pt, fill: theme.heading)
                    ][
                      #context sidebar.sidebar-button(
                        20pt,
                        page-size.width - here().position().x - sel-page-margins.right,
                      )
                    ]
                  ]

                ])

                sidebar-elements.push(v(5pt))
              }

              #for h in heading-positions-of-page {
                let y-pos = h.y-pos - sel-page-margins.top + 10pt
                y-pos -= if title != none and page-number == first-page { title-height } else { 0pt }
                let remaining-spacing = y-pos - current-y-position


                while remaining-spacing > 45pt {
                  sidebar-elements.push(sidebar.sidebar-button(
                    40pt,
                    sidebar-width,
                  ))

                  sidebar-elements.push(v(5pt))

                  remaining-spacing -= 45pt
                }

                if remaining-spacing >= 10pt {
                  sidebar-elements.push(sidebar.sidebar-button(
                    remaining-spacing - 5pt,
                    sidebar-width,
                    elem-text: if remaining-spacing > 25pt { none } else { "" },
                  ))

                  remaining-spacing -= remaining-spacing - 5pt
                }

                sidebar-elements.push(v(remaining-spacing))

                sidebar-elements.push(sweeps.bottom-left-sweep(
                  40pt,
                  sidebar-width,
                  theme.heading,
                  sweep-width: margin-ext + h1-pad - 5pt,
                ))

                sidebar-elements.push(v(5pt))

                current-y-position = y-pos + 45pt
              }

              #let remaining-spacing = (
                page-size.height
                  - sel-page-margins.top
                  - sel-page-margins.bottom
                  - current-y-position
                  - if title != none and page-number == first-page { title-height } else { 0pt }
              )

              #{
                while remaining-spacing > 45pt {
                  sidebar-elements.push(sidebar.sidebar-button(
                    40pt,
                    sidebar-width,
                  ))

                  sidebar-elements.push(v(5pt))

                  remaining-spacing -= 45pt
                }

                if remaining-spacing >= 10pt {
                  sidebar-elements.push(sidebar.sidebar-button(
                    remaining-spacing - 5pt,
                    sidebar-width,
                    elem-text: if remaining-spacing > 25pt { none } else { "" },
                  ))

                  remaining-spacing -= remaining-spacing - 5pt
                }

                sidebar-elements.push(v(remaining-spacing))
              }

              #stack(dir: ttb, ..sidebar-elements)
            ]
          })]
      },
    )

    pagebreak(weak: true)

    if title != none {
      v(title-height)
    }

    body
  }
}

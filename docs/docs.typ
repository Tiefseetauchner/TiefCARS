#import "@preview/tiefcars:0.2.0": *

#show: tiefcars.with(theme: "tng")

#context {
  [
    #let theme = state("theme-state").get()

    #single-page-layout(
      title: [TiefCARS],
      subtitle-text: [
        #align(right)[
          #[#set text(size: 24pt)
            The most flexible way to create LCARS Interfaces using Typst.]

          #set text(fill: luma(45%))

          2038503437590223-4398072549052834-3540985420934750392843509872384-945837430859874345-4380543098423
          3409554098354334-6045938540945683-4350340985624984575167853218742-897843214842488945-6578964231564
          1451657445248941-4587564561234854-5468756486442468515246847915154-457854687431235357-9876514857324
          4579854578975213-7478941567354875-5798416575645443213576531457657-597851277421543487-5498445154872
        ]
      ],
      top-height: 5,
    )[
      #place(bottom + right)[A project by Tiefseetauchner.]
    ]

    #pagebreak()

    #single-page-layout(
      title: "Single Page Layout Support",
      subtitle-text: [Demonstrating versatility for single page Documents or title pages.],
      top-height: 8,
    )[
      The `single-page-layout()` function allows for easy creation of title pages or single page documents with a special flair.
    ]

    #pagebreak(to: "odd")

    #multi-page-layout(
      title: "TiefCARS Design System",
      odd-even: true,
      page-binding: right,
    )[

      #quote(
        attribution: "Lena Tauchner",
        block: true,
      )[A somewhat complete page layouting system for Typst, imitating the LCARS User Interface (roughly)]


      = Introduction

      TiefCARS is a highly dynamic, customizable layouting and drawing library to easily generate elements similar to those seen in the Library Computer Access/Retrieval System (LCARS).

      Aside from its flexibility, TiefCARS is a highly dynamic library. It offers multiple simple ways to generate an initial document, responds to dynamic page sizes and allows theming.

      With its modular architecture, using pseudo-random number generators for colors and text, the output is both predictable on a per-compile basis and modular.

      = Reasoning for Development

      When creating props, one either designs their own LCARS interface via some sort of manual editor (Inkscape, Gimp, ...), which costs time and sometimes results in less than satisfactory outcomes, or they may download preset templates. Either way is not flexible for props that are either custom or in active use (and changing).

      That's why a library for typst, allowing creative and flexible typesetting, is necessary for any prop designer. Using this library, one can create PADD content, screen elements, ..., without the hassle of placing individual items on a screen.

      = Elements

      TiefCars ships with a variety of elements, ready to be used. Among the buttons and sweeps, there are also more complex examples like sidebars.

      == Button

      The button is a material part of any UI/UX Design, and thus needs to be implemented in TiefCARS. A button is inserted using `#buttons.button(variant)[Content]`

      #buttons.button(3)[Content]

      A button also allows custom insets: `#buttons.button(3, inset: (left: 12pt, top: 2pt, right: 4pt, bottom: 7pt))[Content]`

      #buttons.button(3, inset: (left: 12pt, top: 2pt, right: 4pt, bottom: 7pt))[Content]

      == Sidebar Button

      The sidebar of an LCARS interface does not use the usual buttons, instead relying on rectangular buttons with a text in the bottom right. This is displayable via the `#sidebar.sidebar-button(40pt, 100pt)` command:

      #sidebar.sidebar-button(40pt, 100pt)

      Sidebar buttons also allow for further customization like the color and the text displayed: `#sidebar.sidebar-button(40pt, 100pt, color: red, elem-text: "TiefCARS <3")`

      #sidebar.sidebar-button(40pt, 100pt, color: red, elem-text: "TiefCARS <3")

      == Sweeps

      There are four variants of sweeps available, all functioning in the same way:

      #grid(columns: (1fr, 1fr), gutter: 5pt)[
        `sweeps.bottom-left-sweep`
        #sweeps.bottom-left-sweep(20pt, 100pt, theme.accent.a-5)
      ][
        `sweeps.bottom-right-sweep`
        #sweeps.bottom-right-sweep(20pt, 100pt, theme.accent.a-5)
      ][
        `sweeps.top-left-sweep`
        #sweeps.top-left-sweep(20pt, 100pt, theme.accent.a-5)
      ][
        `sweeps.top-right-sweep`
        #sweeps.top-right-sweep(20pt, 100pt, theme.accent.a-5)
      ]

      Each sweep requires three parameters: height, width and color. `#sweeps.bottom-left-sweep(20pt, 100pt, theme.accent.a-5)`

      A sweep may also include the following parameters: sweep-text, sweep-width.

      `#sweeps.bottom-left-sweep(20pt, 100pt, green, sweep-text: "Toaster", sweep-width: 200pt)`\
      #sweeps.bottom-left-sweep(20pt, 100pt, green, sweep-text: "Toaster", sweep-width: 200pt)

      `#sweeps.bottom-left-sweep(20pt, 100pt, blue, sweep-text: "Toaster", sweep-width: 20pt)`\
      #sweeps.bottom-left-sweep(20pt, 100pt, blue, sweep-text: "Toaster", sweep-width: 20pt)

      == Other elements

      Less relevant/mostly internal elements are: sidebar-bar, sidebar

      These are not discussed in this document.

      = Layouting

      == Single Page Layout

      See Page 1; creates a layout with the iconic horizontal bar. Allows adding text, subtext, and a limited body.

      ```typst
      #single-page-layout(
        title: [Your Title],
        subtitle-text: [
            Text for your subtitle
          ]
        ],
        top-height: 5,
      )[
        Main Body
      ]
      ```

      == Multi Page Layout

      The current layout. Allows multipage-input, dynamically selecting headings and creating a sweep to it.

      ```typst
      #multi-page-layout(
        odd-even: false,
        sidebar-width: 50pt,
      )[
        Content
      ]
      ```

      Or, if only showing one multi page layout in a document:

      ```typst
      #show: multi-page-layout.with(
        title: "My amazing document"
      )

      = Content
      ```
    ]

    #set page(width: 100mm, height: 100mm)
    #multi-page-layout(
      odd-even: false,
      sidebar-width: 50pt,
    )[

      = Flexibility

      TiefCARS is built for flexibility - different page formats are, of course, supported.

      You can build beautiful post cards or business cards with TiefCARS!

      Keep in mind that the layouting is configurable - make it just right for your project using optional parameters.
    ]

    #set page(paper: "a4")
    #multi-page-layout(
      odd-even: true,
      page-binding: right,
    )[
      = Contribution guidelines

      There's not really much to consider, other than the request to keep a folder structure. Components go into `components/`, so on.

      Theming can always be expanded and may be a simple entry point, that'd be nice :)
    ]
  ]
}

#!/bin/bash
set -e

SHADOW="70x10+0+0"

function createImage() {
  typst c examples/$1.typ examples/$1.c.pdf

  magick -density 600 examples/$1.c.pdf -background white -alpha off -resize 25% "test/page.png" # 150dpi -> 1240x1754 for A4
  # magick -density 150 examples/$1.c.pdf -background white -alpha off "test/page.png" # 150dpi -> 1240x1754 for A4

  magick -size 3010x2139 canvas:none \
    \( test/page-0.png  \( +clone -background black -shadow $SHADOW \) +swap -background none -layers merge +repage \) -geometry +10+10     -compose over -composite \
    \( test/page-1.png  \( +clone -background black -shadow $SHADOW \) +swap -background none -layers merge +repage \) -geometry +810+10     -compose over -composite \
    \( test/page-2.png  \( +clone -background black -shadow $SHADOW \) +swap -background none -layers merge +repage \) -geometry +1610+10     -compose over -composite \
    examples/$1.png

  echo "Created $1.png"
}

createImage ex1
createImage ex2
createImage ex3
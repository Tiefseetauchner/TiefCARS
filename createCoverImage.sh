#!/bin/bash
set -e

SHADOW="70x10+10+10"

typst c test.typ test.pdf

magick -density 600 test.pdf -background white -alpha off -resize 25% "test/page.png" # 150dpi -> 1240x1754 for A4
# magick -density 150 test.pdf -background white -alpha off "test/page.png" # 150dpi -> 1240x1754 for A4


magick -size 3010x2139 canvas:none \
  \( test/page-4.png  \( +clone -background black -shadow $SHADOW \) +swap -background none -layers merge +repage \) -geometry +1735+30 -compose over -composite \
  \( test/page-1.png  \( +clone -background black -shadow $SHADOW \) +swap -background none -layers merge +repage \) -geometry +600+80   -compose over -composite \
  \( test/page-15.png \( +clone -background black -shadow $SHADOW \) +swap -background none -layers merge +repage \) -geometry +800+350  -compose over -composite \
  \( test/page-0.png  \( +clone -background black -shadow $SHADOW \) +swap -background none -layers merge +repage \) -geometry +0+0     -compose over -composite \
  cover.png

echo "Created cover.png"
#!/usr/bin/env sh

TMP_DIR="/tmp/hyperlock"
LOGO="/usr/share/themes/hypercube/logo.png"

{
  # create temp dir
  mkdir $TMP_DIR

  # capture screen
  imlib2_grab $TMP_DIR/screenshot-raw.png

  # blur screen & apply logo overlay
  ffmpeg -i $TMP_DIR/screenshot-raw.png -i $LOGO \
  -filter_complex "[0] boxblur=5 [screen];[1] scale=100:-1 [logo]; \
  [screen][logo] overlay=(W-w-50):(H-h-50)" \
  $TMP_DIR/lockscreen.png

  # pause all the players
  playerctl pause

  # actually lock the screen
  i3lock -t -n -e -i $TMP_DIR/lockscreen.png

  rm -Rf $TMP_DIR # remove all the stuff that was generated just now
} &> /dev/null

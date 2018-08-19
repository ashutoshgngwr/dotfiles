#!/bin/sh

OUTPUT_PATH="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png"

imlib2_grab "$OUTPUT_PATH"
notify-send "Pew!" "Pew! Pew!" -u "normal" -i "$OUTPUT_PATH"
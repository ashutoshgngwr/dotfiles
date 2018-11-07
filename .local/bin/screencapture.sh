#!/bin/bash

######################################################
# Author: Ashutosh Gangwar <ashutoshgngwr@gmail.com>
# Created on 15 Oct, 2018
######################################################

CACHE_PATH="/tmp/screencaptures"
OUTPUT_THUMB="$CACHE_PATH/$(date +%Y-%m-%d-%H-%M-%S).png"
OUTPUT_FILE="$HOME/Videos/Screencaptures/$(date +%Y-%m-%d-%H-%M-%S).mp4"
COUNT=0
SECONDS=0

mkdir "$CACHE_PATH"
imlib2_grab "$OUTPUT_THUMB"
notify-send "Screencapture started" "Get your act together!" -u "low" -i "$OUTPUT_THUMB"

while true; do
	printf "\rRecording: %03ds" "$SECONDS"
	read -r -t 0.02 -N 1
	if [ "$?" == "0" ]; then
		break
	fi
	imlib2_grab "$CACHE_PATH/$(printf %08d $COUNT).jpg"
	COUNT=$((COUNT + 1))
done
echo "" && wait
notify-send "Screencapture ended" "You can be a fool again! :D" -u "normal" -i "$OUTPUT_THUMB"
echo "Rendering video"
echo "FPS: $((COUNT / SECONDS))"
ffmpeg \
	-framerate "$((COUNT / SECONDS))" \
	-i "$CACHE_PATH/%08d.jpg" \
	-c:v libx264 \
	-crf 23 \
	"$OUTPUT_FILE"

notify-send "Screencapture rendered" "To the editing line we will proceed!" -u "low" -i "$OUTPUT_THUMB"
rm -rf "$CACHE_PATH" "$OUTPUT_THUMB"

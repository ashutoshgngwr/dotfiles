#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch status bar
for mon in $(polybar --list-monitors | cut -d ":" -f1); do
    MONITOR=$mon polybar --reload main > /dev/null 2>&1 &
done
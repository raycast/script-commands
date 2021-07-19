#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Timer
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🍅
# @raycast.argument1 { "type": "text", "placeholder": "Duration", "optional": true }
# @raycast.packageName Pomodoro

# Documentation:
# @raycast.description Start a Pomodoro timer
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann

FILENAME="pomodoro_timer_end.txt"

if [ -n "$1" ]; then
  DURATION_IN_MINUTES="$1"
else
  DURATION_IN_MINUTES="20"
fi

NOW=$(date +"%s")
END=$(( $NOW + ($DURATION_IN_MINUTES * 60) ))
echo $END > $FILENAME

echo "Started timer for $DURATION_IN_MINUTES minutes"
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop Timer
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🍅
# @raycast.packageName Pomodoro

# Documentation:
# @raycast.description Stop active Pomodoro timer
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann

FILENAME="pomodoro_timer_end.txt"

rm $FILENAME

echo "Stopped timer"
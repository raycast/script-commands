#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.title Caffeinate Stop
# @raycast.mode silent
# @raycast.author Maxim Krouk
#
# @raycast.authorURL https://github.com/maximkrouk
# @raycast.description Kills all caffeinate processes
# @raycast.icon ☕️
# @raycast.packageName System

pkill -f caffeinate
echo "Done"

#!/bin/bash

# Install DND Me from https://runtimesharks.com/projects/dnd-me?ref=producthunt

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start DND
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔕
# @raycast.argument1 { "type": "text", "placeholder": "Duration", "optional": true }
# @raycast.packageName DND Me

# Documentation:
# @raycast.description Starts DND via DND Me. The parameter has to be a menu item or slider equivalent: 15m, 30m, 1h, 2h, ..., 12h, next, next-hour, next-half-hour; it defaults to next. next-hour means the next 60m mark, next-half-hour means the next 30m mark and next means the first of the two. For example, if it's 9:22, next-hour means 10:00, next-half-hour means 9:30 and next means 9:30.
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com/projects/dnd-me

duration=$1

if [[ -z "$1" ]]
then
  duration=next
fi

open "dndme://start-dnd/$duration"

echo "DND on"

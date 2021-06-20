#!/bin/bash

# Note: NotePlan3 required
# Install via Mac App Store: https://apps.apple.com/app/noteplan-3/id1505432629

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Append To Daily Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/noteplan3.png
# @raycast.argument1 { "type": "text", "placeholder": "- Quick note", "percentEncoded": true, "optional": true }
# @raycast.packageName NotePlan3

# Documentation: Appends text to the daily note. If no input is given it will use the current clipboard item.
# @raycast.description Append to daily note
# @raycast.author Göran Damberg
# @raycast.authorURL https://github.com/gdamberg

text=""
if [ -z "${1}" ]; then
    text="$(pbpaste | python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))')"
else
    text="${1}"
fi
open "noteplan://x-callback-url/addText?noteDate=today&mode=append&openNote=no&text=${text}"

echo "Appended to daily note."
#!/bin/bash

# Note: NotePlan3 required
# Install via Mac App Store: https://apps.apple.com/app/noteplan-3/id1505432629

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Note From Clipboard
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon images/noteplan3.png
# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true, "optional": false }
# @raycast.packageName NotePlan3

# Documentation: Creates a new note from clipboard
# @raycast.description Create a new note from clipboard
# @raycast.author Göran Damberg
# @raycast.authorURL https://github.com/gdamberg

text="$(pbpaste | python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))')"

open "noteplan://x-callback-url/addNote?noteTitle=${1}&openNote=yes&text=${text}"
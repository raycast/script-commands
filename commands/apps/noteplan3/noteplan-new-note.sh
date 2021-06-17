#!/bin/bash

# Note: NotePlan3 required
# Install via Mac App Store: https://apps.apple.com/app/noteplan-3/id1505432629

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/noteplan.ico
# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true, "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "Content", "percentEncoded": true, "optional": true }
# @raycast.packageName NotePlan3

# Documentation: Creates a new note
# @raycast.description Create a new note
# @raycast.author Göran Damberg
# @raycast.authorURL https://github.com/gdamberg

text=""
if [ -n "${2}" ]; then
    text="&text=${2}"
fi

open "noteplan://x-callback-url/addNote?noteTitle=${1}&openNote=yes${text}"
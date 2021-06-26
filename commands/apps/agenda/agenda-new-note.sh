#!/bin/bash

# Note: Agenda required
# Install via Mac App Store: https://apps.apple.com/us/app/agenda/id1287445660

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create New On the Agenda Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/agenda.png
# @raycast.argument1 { "type": "text", "placeholder": "Project Title", "percentEncoded": true}
# @raycast.argument2 { "type": "text", "placeholder": "Title", "percentEncoded": true }
# @raycast.argument3 { "type": "text", "placeholder": "Note Text", "percentEncoded": true, "optional": true }
# @raycast.packageName Agenda

# Documentation:
# @raycast.description Creates New Note and adds it to On the Agenda
# @raycast.author Michael Ellis
# @raycast.authorURL https://github.com/mtellis2


open "agenda://x-callback-url/create-note?project-title=$1&title=$2&text=$3&on-the-agenda=true&date=today"

echo "Created On the Agenda Note."
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create To-Do
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/things.png
# @raycast.packageName Things
# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "When (e.g. \"today\")", "percentEncoded": true, "optional": true }

# Documentation:
# @raycast.description Create a new To-Do with title and optional deadline.
# @raycast.author Things
# @raycast.authorURL https://twitter.com/culturedcode/

open "things:///add?title=$1&when=$2"
echo "Created To-Do"
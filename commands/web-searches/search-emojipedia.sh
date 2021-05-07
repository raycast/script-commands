#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Emojipedia
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon 🔎
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true}

# Documentation:
# @raycast.description Search for emojis at emojipedia.
# @raycast.author Benedict Neo
# @raycast.authorURL https://github.com/benthecoder

open "https://emojipedia.org/search/?q=$1"

#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wayback Machine Search
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon images/ia-logo.jpg
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "url", "percentEncoded": true }

open "https://web.archive.org/web/*/${1}"

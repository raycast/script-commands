#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in YouTube
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/youtube.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://www.youtube.com/results?search_query=$1"
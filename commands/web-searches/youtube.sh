#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in YouTube
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/youtube.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://www.youtube.com/results?search_query${1// /%20}"

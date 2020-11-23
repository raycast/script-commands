#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in DuckDuckGo
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/duck-duck-go.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://duckduckgo.com/?q=${1// /%20}"

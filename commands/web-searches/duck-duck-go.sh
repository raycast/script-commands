#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in DuckDuckGo
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/duck-duck-go.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true}

open "https://duckduckgo.com/?q=$1"

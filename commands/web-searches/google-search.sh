#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Google
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/google.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://www.google.com/search?q=${1// /%20}"

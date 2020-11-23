#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Ecosia
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/ecosia.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "query" }

# Documentation:
# @raycast.author Sasivarnan R
# @raycast.authorURL https://github.com/sasivarnan


open "https://www.ecosia.org/search?q=${1// /%20}"

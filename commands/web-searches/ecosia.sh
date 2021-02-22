#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Ecosia
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/ecosia.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

# Documentation:
# @raycast.author Sasivarnan R
# @raycast.authorURL https://github.com/sasivarnan


open "https://www.ecosia.org/search?q=${1}"

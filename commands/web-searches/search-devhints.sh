#!/bin/bash

# Required parameters:
# @raycast.author Francois
# @raycast.authorURL https://github.com/AsterYujano
# @raycast.schemaVersion 1
# @raycast.title Search in devhints.io
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/devhints.png
# @raycast.argument1 { "type": "text", "placeholder": "Search term...", "percentEncoded": true }

open "https://devhints.io/?q=$1"

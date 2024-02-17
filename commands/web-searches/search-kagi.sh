#!/bin/bash

# @raycast.title Search Kagi
# @raycast.author Travis Carr
# @raycast.authorURL https://github.com/tmcarr
# @raycast.description Search Kagi.

# @raycast.icon images/kagi.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true }

open "https://kagi.com/search?q=${1}"

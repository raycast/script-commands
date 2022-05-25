#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search stackoverflow with google
# @raycast.mode silent
# @raycast.packageName Web Searches
#
# Documentation:
# @raycast.description Search stackoverflow with google
# @raycast.author Volca
# @raycast.authorURL https://github.com/volca

# Optional parameters:
# @raycast.icon images/stackoverflow.png
# @raycast.argument1 { "type": "text", "placeholder": "关键词...", "percentEncoded": true}

open "https://www.google.com/search?q=site:stackoverflow.com%20$1"

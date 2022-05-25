#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search v2ex with google
# @raycast.mode silent
# @raycast.packageName Web Searches
#
# Documentation:
# @raycast.description Search v2ex with google
# @raycast.author Volca
# @raycast.authorURL https://github.com/volca

# Optional parameters:
# @raycast.icon images/v2ex.png
# @raycast.argument1 { "type": "text", "placeholder": "关键词...", "percentEncoded": true}

open "https://www.google.com/search?q=site:v2ex.com/t%20$1"

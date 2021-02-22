#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title njt
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon 🐸
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "package-name [destination]", "percentEncoded": true }

open "https://njt.now.sh/jump?from=raycast&to=${1}"

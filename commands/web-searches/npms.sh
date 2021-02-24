#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title npms
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon images/npms.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "package name", "percentEncoded": true }

open "https://npms.io/search?q=${1}"

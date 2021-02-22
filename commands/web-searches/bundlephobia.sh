#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Bundlephobia cost
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon 📦
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "package name", "percentEncoded": true }

open "https://bundlephobia.com/result?p=${1}"

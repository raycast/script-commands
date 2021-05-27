#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Hacker News
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/hacker-news.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }
# @raycast.packageName Web Searches

# Documentation:
# @raycast.description Search Hacker News
# @raycast.authorURL https://github.com/s-oram
# @raycast.author Shannon Matthews

open -n "https://hn.algolia.com/?q=${1}"

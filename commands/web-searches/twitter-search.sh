#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Twitter
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/twitter.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://twitter.com/search?q=${1// /%20}&src=typed_query"

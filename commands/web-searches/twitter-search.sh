#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Twitter
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/twitter.png
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://twitter.com/search?q=${1// /%20}&src=typed_query"

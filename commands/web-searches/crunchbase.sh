#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Crunchbase
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/crunchbase.png
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://www.crunchbase.com/textsearch?q=${1// /%20}"

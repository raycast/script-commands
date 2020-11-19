#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Amazon
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/amazon.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://www.amazon.com/s?k=$1"
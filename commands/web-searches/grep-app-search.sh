#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in grep.app
# @raycast.mode silent

# Optional parameters:
# @raycast.icon https://grep.app/favicon.ico
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "query" }

open "https://grep.app/search?q=${1// /%20}"

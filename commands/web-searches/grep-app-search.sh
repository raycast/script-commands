#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in grep.app
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon https://grep.app/favicon.ico
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://grep.app/search?q=${1}"

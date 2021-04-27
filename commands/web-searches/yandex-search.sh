#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Yandex
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/yandex.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true}
# @raycast.packageName Web Searches

open "https://yandex.com/search/?text=$1"

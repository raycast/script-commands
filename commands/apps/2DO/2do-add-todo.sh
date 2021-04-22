#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create 2DO
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/2do-icon.png
# @raycast.argument1 { "type": "text", "placeholder": "Task Title" }
# @raycast.argument2 { "type": "text", "placeholder": "When Due (1-torrmow)", "percentEncoded": true, "optional": true }
# @raycast.packageName apps

# Documentation:
# @raycast.author 张扬
# @raycast.authorURL https://github.com/dreamkidd

open "twodo://x-callback-url/add?task=$1&due=$2"
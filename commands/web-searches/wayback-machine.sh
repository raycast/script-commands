#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wayback Machine search
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon 📦
# @raycast.argument1 { "type": "text", "placeholder": "url" }

open "https://web.archive.org/web/*/${1// /%20}"

#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unfurl URL
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon 🔗
# @raycast.packageName using unfurler.com
# @raycast.argument1 { "type": "text", "placeholder": "url" }

open "https://unfurler.com/?url=${1// /%20}"

#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title unfurl
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon 🔗
# @raycast.packageName Link unfurl tester
# @raycast.argument1 { "type": "text", "placeholder": "url" }

open "https://unfurler.com/?url=${1// /%20}"

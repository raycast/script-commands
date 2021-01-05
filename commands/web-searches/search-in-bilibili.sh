#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Search in Bilibili
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/bilibili.png
# @raycast.argument1 { "type": "text", "placeholder": "关键词...", "percentEncoded": true }

open "https://search.bilibili.com/all?keyword=$1"
#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Search in Baidu
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/baidu.png
# @raycast.argument1 { "type": "text", "placeholder": "关键词...", "percentEncoded": true }

open "https://www.baidu.com/s?wd=$1"

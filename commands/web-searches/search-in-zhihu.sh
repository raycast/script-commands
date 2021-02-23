#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Search in Zhihu
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/zhihu.png
# @raycast.argument1 { "type": "text", "placeholder": "关键词...", "percentEncoded": true}

open "https://www.zhihu.com/search?type=content&q=$1"

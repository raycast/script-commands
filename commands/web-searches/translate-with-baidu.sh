#!/bin/bash

# Required parameters:
# @raycast.author sunbufu
# @authorURL https://sunbufu.github.io/
# @raycast.schemaVersion 1
# @raycast.title Translate with Baidu
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/baidu-translate.png
# @raycast.argument1 { "type": "text", "placeholder": "keyword", "percentEncoded": true }

open "https://fanyi.baidu.com/#lit/zh/$1"
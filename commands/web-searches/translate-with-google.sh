#!/bin/bash

# Required parameters:
# @raycast.author sunbufu
# @authorURL https://sunbufu.github.io/
# @raycast.schemaVersion 1
# @raycast.title Translate with Google
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/google-translate.png
# @raycast.argument1 { "type": "text", "placeholder": "keyword", "percentEncoded": true }

open "https://translate.google.cn/?sl=auto&tl=zh-CN&text=$1&op=translate"
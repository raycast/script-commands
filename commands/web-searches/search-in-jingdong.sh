#!/bin/bash

# Required parameters:
# @raycast.author sunbufu
# @raycast.authorURL https://sunbufu.github.io/
# @raycast.schemaVersion 1
# @raycast.title Search in Jingdong
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/jingdong.png
# @raycast.argument1 { "type": "text", "placeholder": "keyword", "percentEncoded": true }

open "https://search.jd.com/Search?keyword=$1"
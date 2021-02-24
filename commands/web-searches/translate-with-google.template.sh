#!/bin/bash

# Required parameters:
# @raycast.author sunbufu
# @raycast.authorURL https://sunbufu.github.io/
# @raycast.schemaVersion 1
# @raycast.title Translate with Google
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/google-translate.png
# @raycast.argument1 { "type": "text", "placeholder": "keyword", "percentEncoded": true }

# Most common acronyms
# en = English
# es = Spanish
# fr = French
# pt = Portuguese
# zh-CN = Chinese
# more to come
# For the source language, you can also use "auto", for automatic detection
source="" # Source language acronym
destination="" # Destination language acronym 

# You can use "translate.google.cn" in China.
domain="translate.google.com"

open "https://$domain/?sl=$source&tl=$destination&text=$1&op=translate"
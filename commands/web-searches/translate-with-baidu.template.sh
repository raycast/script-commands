#!/bin/bash

# Required parameters:
# @raycast.author sunbufu
# @raycast.authorURL https://sunbufu.github.io/
# @raycast.schemaVersion 1
# @raycast.title Translate with Baidu
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/baidu-translate.png
# @raycast.argument1 { "type": "text", "placeholder": "keyword", "percentEncoded": true }

# Most common acronyms
# en = English
# spa = Spanish
# fra = French
# pt = Portuguese
# zh = Chinese
# more to come
# For the source language, you can also use "auto", for automatic detection
source="" # Source language acronym
destination="" # Destination language acronym 

open "https://fanyi.baidu.com/#$source/$destination/$1"
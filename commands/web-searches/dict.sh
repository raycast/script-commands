#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dict.cc
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/dict.png
# @raycast.argument1 { "type": "text", "placeholder": "Text" }
# @raycast.packageName Translations

# Documentation:
# @raycast.description Open Dict.cc
# @raycast.author Luka Harambasic
# @raycast.authorURL https://harambasic.de

open "https://www.dict.cc/?s=${1// /%20}"

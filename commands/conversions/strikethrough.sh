#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Strikethrough Text
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔠
# @raycast.packageName Conversions
# @raycast.argument1 { "type": "text", "placeholder": "Text", "optional": true}

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Converts given text (or clipboard if no argument) to t̶e̶x̶t̶

LANG=en_US.UTF-8

if [ "$1" = "" ]; then
    input=$(pbpaste)
else
    input=$1
fi

output=$(python3 -c "print('\u0336'.join('$input') + '\u0336')")
echo $output | tee >(pbcopy)

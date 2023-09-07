#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Query cheat.sh
# @raycast.mode fullOutput
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon images/cheat.png
# @raycast.argument1 { "type": "text", "placeholder": "Language / Command" }
# @raycast.argument2 { "type": "text", "placeholder": "Question", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Query the cheat.sh service (https://github.com/chubin/cheat.sh). You can change the color style in the script.

language=$1
question=${2// /+}
# Available styles: https://cht.sh/:styles-demo
style="paraiso-dark"

# get a random answer each time
randnum=$((1 + (RANDOM%4)))

# https://github.com/chubin/cheat.sh#usage
if [ -z "$question" ]; then
  curl -s cht.sh/$language?style=$style
else
  curl -s cht.sh/$language/$question/$randnum?style=$style
fi

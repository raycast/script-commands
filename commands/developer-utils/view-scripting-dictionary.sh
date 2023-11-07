#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title View Scripting Dictionary
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📖
# @raycast.argument1 { "type": "text", "placeholder": "Application", "optional": true }
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Opens the Scripting Dictionary for the given application, defaulting to the active application if none is provided.
# @raycast.author Stephen Kaplan
# @raycast.authorURL https://github.com/SKaplanOfficial

if [ -z "$1" ]; then
  open -a "Script Editor" "$(osascript -e "tell application \"System Events\" to get POSIX path of application file of (first application process whose frontmost is true)")"
  exit
fi
open -a "Script Editor" "$(osascript -e "POSIX path of (path to application \"$1\")")"


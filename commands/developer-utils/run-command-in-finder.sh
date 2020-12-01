#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run Command On Front Finder Window
# @raycast.mode silent
# @raycast.author Wesley Martin
# @raycast.authorURL https://github.com/itsmewes
#
# Optional parameters:
# @raycast.icon 🛠
# @raycast.packageName Finder Command
# @raycast.argument1 { "type": "text", "placeholder": "Write command" }

dir=$(osascript <<'EOF'
    tell application "Finder" to get the POSIX path of (target of front window as alias)
EOF
)
( cd "$dir" && $@ )
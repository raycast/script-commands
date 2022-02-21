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
# @raycast.packageName Developer Utils
# @raycast.argument1 { "type": "text", "placeholder": "Write command" }

# Documentation:
# @raycast.description Runs the specified command in the path of the frontmost Finder window.

dir=$(osascript <<'EOF'
    tell application "Finder"
        if exists Finder window 1 then
            get the POSIX path of (target of Finder window 1 as alias)
        else
            get the POSIX path of (desktop as alias)
        end if
    end tell
EOF
)
( cd "$dir" && $@ )

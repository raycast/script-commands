#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Focused Finder Window Path
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📁
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Copies full path of the currently focused Finder window
# @raycast.author Vishal Telangre
# @raycast.authorURL https://github.com/vishaltelangre

path=$(osascript <<'EOF'
    tell application "Finder"
        if exists Finder window 1 then
            get the POSIX path of (target of Finder window 1 as alias)
        else
            get the POSIX path of (desktop as alias)
        end if
    end tell
EOF
)
echo $path | tr -d '\n' | pbcopy
echo "Copied $path to clipboard"

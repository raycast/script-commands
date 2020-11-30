#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run command on front finder window
# @raycast.mode silent
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
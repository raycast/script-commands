#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Menu Icons
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎛️
# @raycast.packageName System Utilities

# Documentation:
# @raycast.description Show or hide Tahoe menu icons
# @raycast.author chrismessina
# @raycast.authorURL https://raycast.com/chrismessina

set -euo pipefail

current_value="$(defaults read -g NSMenuEnableActionImages 2>/dev/null || echo 1)"
normalized="$(echo "$current_value" | tr '[:upper:]' '[:lower:]')"

if [[ "$normalized" == "0" || "$normalized" == "no" || "$normalized" == "false" ]]; then
    next_state="true"
else
    next_state="false"
fi

if ! defaults write -g NSMenuEnableActionImages -bool "$next_state"; then
    echo "Failed to toggle menu action icons." >&2
    exit 1
fi

killall Finder
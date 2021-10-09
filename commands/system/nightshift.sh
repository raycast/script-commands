#!/bin/bash

# Dependency: This script requires `nightlight` to be installed: https://github.com/smudge/nightlight
# Install via homebrew: `brew install smudge/smudge/nightlight`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Night Shift
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌘
# @raycast.packageName System
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Enable or disable (toggle) the Night Shift mode (until tomorrow/sunrise). Required: https://github.com/smudge/nightlight
# @raycast.author BhEaN

if command -v nightlight; then
    nightlight toggle
    status=$(nightlight status)
    echo "Night Shift ${status}"
else
    echo "Command not found, please install smudge/nightlight first!"
    exit 1
fi

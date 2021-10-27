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

# Documentation:
# @raycast.description Toggle Night Shift mode (until tomorrow/sunrise). Required [nightlight](https://github.com/smudge/nightlight)
# @raycast.author BhEaN
# @raycast.authorURL https://github.com/bhean

if ! command -v nightlight &> /dev/null; then
    echo "Download nightlight is required (https://github.com/smudge/nightlight)".
    exit 1;
fi

nightlight toggle
status=$(nightlight status)
echo "Night Shift ${status}"

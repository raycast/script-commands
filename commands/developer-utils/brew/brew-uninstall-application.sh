#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Uninstall Application
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🍺
# @raycast.argument1 { "type": "text", "placeholder": "Application" }
# @raycast.packageName Brew

# Documentation:
# @raycast.description Uninstalls an Specified Application Using Homebrew
# @raycast.author StevenRCE0
# @raycast.authorURL https://github.com/StevenRCE0

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

# Workaround for the error message
exec 2>/dev/null

brew cat --cask "$1";
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
  echo "That's not a Homebrew cask. Check the spelling or try uninstalling it manually.";
  exit 2;
fi

echo "brew uninstall --cask --force --zap \"$1\"" | pbcopy;
echo "Copied command to clipboard.";

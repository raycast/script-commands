#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Cask Upgrade
# @raycast.mode fullOutput
# @raycast.packageName Brew
#
# Optional parameters:
# @raycast.icon 🍺
#
# Documentation:
# @raycast.description Run Brew Cask Upgrade
# @raycast.author LanikSJ
# @raycast.authorURL https://github.com/LanikSJ

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

if ! command -v brew cu &> /dev/null; then
  echo "brew cask upgrade command is required (https://github.com/buo/homebrew-cask-upgrade).";
  exit 1;
fi

brew cu -ay

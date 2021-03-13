#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Update
# @raycast.mode fullOutput
# @raycast.packageName Brew
#
# Optional parameters:
# @raycast.icon 🍺
#
# Documentation:
# @raycast.description Run Brew Update
# @raycast.author chengzhiqi
# @raycast.authorURL https://twitter.com/1872Fate

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

brew update

#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title List
# @raycast.mode fullOutput
# @raycast.packageName Brew
#
# Optional parameters:
# @raycast.icon 🍺
#
# Documentation:
# @raycast.description Show Brew List
# @raycast.author chengzhiqi
# @raycast.authorURL https://twitter.com/1872Fate

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

brew list

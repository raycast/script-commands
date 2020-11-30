#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Services List
# @raycast.mode fullOutput
# @raycast.packageName Brew
#
# Optional parameters:
# @raycast.icon 🍺
#
# Documentation:
# @raycast.description Show Brew Services List
# @raycast.author Thiago Holanda
# @raycast.authorURL https://twitter.com/tholanda

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

brew services list

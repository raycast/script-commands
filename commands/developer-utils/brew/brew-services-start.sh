#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Service
# @raycast.mode compact
# @raycast.packageName Brew
# @raycast.argument1 {"type":"text", "placeholder": "Service Name" }
#
# Optional parameters:
# @raycast.icon 🍺
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Start Service in Brew
# @raycast.author Thiago Holanda
# @raycast.authorURL https://twitter.com/tholanda

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

brew services start $1

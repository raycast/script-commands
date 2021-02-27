#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Install a package
# @raycast.mode fullOutput
# @raycast.packageName Brew
#
# Optional parameters:
# @raycast.icon 🍺
# @raycast.needsConfirmation true
# @raycast.argument1 {"type": "text", "placeholder": "Package name"}
#
# Documentation:
# @raycast.description Installs specified brew package.
# @raycast.author Alex Zotov
# @raycast.authorURL https://github.com/lex4hex

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

brew install $1
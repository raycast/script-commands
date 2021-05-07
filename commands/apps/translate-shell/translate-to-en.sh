#!/bin/bash

# Dependency: requires translate-shell
# Install with Homebrew: `brew install translate-shell`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate to EN
# @raycast.mode fullOutput
# @raycast.packageName Translate Shell

# Optional parameters:
# @raycast.argument1 {"type": "text", "placeholder": "Word or Sentence"}
# @raycast.icon 📖

# Documentation:
# @raycast.author tiancheng92
# @raycast.authorURL https://github.com/tiancheng92
# @raycast.description Translate and copy brief translation to clipboard.

if ! command -v trans &> /dev/null; then
	echo "trans command is required (https://github.com/soimort/translate-shell).";
	exit 1;
fi

trans :en "$1" # display
trans :en "$1" -b | pbcopy # copy brief to clipboard
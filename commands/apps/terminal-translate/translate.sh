#!/bin/bash

# Dependency: requires translate-shell
# Install with Homebrew: `npm install terminal-translate -g`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📖
# @raycast.argument1 { "type": "text", "placeholder": "Word or Sentence" }
# @raycast.packageName Terminal Translate

# Documentation:
# @raycast.description Translate word or sentence.
# @raycast.author Fatpandac
# @raycast.authorURL https://github.com/Fatpandac

if ! command -v tl &> /dev/null; then
	echo "trans command is required (https://github.com/ShanaMaid/terminal-translate).";
	exit 1;
fi

tl $1

#!/bin/bash

# Dependency: requires z (https://github.com/rupa/z)
# Install via homebrew: `brew install z`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in VS Code
# @raycast.mode compact
# @raycast.packageName VS Code
# @raycast.argument1 { "type": "text", "placeholder": "fuzzy-folder-name" }
#
# Optional parameters:
# @raycast.icon images/vscode-logo.png

source $(brew --prefix)/etc/profile.d/z.sh

if ! command -v _z &> /dev/null; then
	echo "_z command is required (https://github.com/rupa/z).";
	exit 1;
fi

FOLDER=$(_z -e $1)
if [ -z "$FOLDER" ]
then
	echo "Unable to find any matching folder"
    exit 1
else
    echo "Opening $FOLDER in VS Code"
	code $FOLDER
fi

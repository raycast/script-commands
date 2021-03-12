#!/bin/bash

# List of available gitignore types: https://www.toptal.com/developers/gitignore/api/list

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create .gitignore
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 🤐
# @raycast.argument1 { "type": "text", "placeholder": "Types (react,node,vscode)", "optional": false }

# Documentation:
# @raycast.description Generates a .gitignore file via https://gitignore.io
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com

params="$1"

if [[ -z "$params" ]]
then
	echo "Missing params"
	exit 1
fi

result=$(curl -s "https://www.toptal.com/developers/gitignore/api/$params" | sed -e "1d")

if [[ "$result" =~ !!\ ERROR.+!! ]]
then
	echo "Unsupported gitignore type"
	exit 1
fi

echo "$result" | pbcopy

echo "Copied to clipboard!"

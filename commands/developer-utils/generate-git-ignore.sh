#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate a .gitignore file
# @raycast.mode fullOutput
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 🤐
# @raycast.argument1 { "type": "text", "placeholder": "Technologies (react,node,vscode)", "optional": true }

# Documentation:
# @raycast.description Generates a .gitignore file via https://gitignore.io
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com

params="$1"

if [[ -z "$params" ]]
then
	params="react,node,vscode"
fi

result=$(curl -s "https://www.toptal.com/developers/gitignore/api/$params" | sed -e "1d")

echo "$result" | pbcopy
echo "$result"

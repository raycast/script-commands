#!/bin/bash

# Dependency: requires json-to-go-cli, jq
# Install with npm: `npm i json-to-go-cli -g`
# Install with brew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Json to go struct
# @raycast.mode fullOutput
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.argument1 {"type": "text", "placeholder": "inline", "optional": true}
# @raycast.icon images/go.jpg

# Documentation:
# @raycast.author tiancheng92
# @raycast.authorURL https://github.com/tiancheng92
# @raycast.description convert the copied json into golang structure

export LC_ALL=en_US.UTF-8
export PATH="/opt/homebrew/bin:$PATH"

if ! command -v json-to-go &> /dev/null; then
	echo "trans command is required (https://github.com/mholt/json-to-go).";
	exit 1;
fi

if ! command -v jq &> /dev/null; then
	echo "jq command is required (https://stedolan.github.io/jq/).";
	exit 1;
fi


echo "$(pbpaste)" | jq &> /dev/null

if [ $(echo $?) != 0 ]; then
	echo "json parse error";
	echo "row data : $(pbpaste)"
	exit 1;
fi

if [ "$1" != "" ]; then
	json-to-go -s "$(pbpaste)" -i
	json-to-go -s "$(pbpaste)" -i | pbcopy
else
	json-to-go -s "$(pbpaste)"
	json-to-go -s "$(pbpaste)" | pbcopy
fi

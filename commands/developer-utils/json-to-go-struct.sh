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
# @raycast.icon images/go.jpg

# Documentation:
# @raycast.author tiancheng92
# @raycast.authorURL https://github.com/tiancheng92
# @raycast.description convert the copied json into a go structure

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

echo "$(pbpaste)" | jq > /dev/null # Judge the legitimacy of json and output an error
json-to-go -s "$(pbpaste)"
#!/bin/bash

# Dependency: requires strip-indent (https://github.com/sindresorhus/strip-indent-cli)
# Install via npm: `npm install --global strip-indent-cli`

# @raycast.schemaVersion 1
# @raycast.title Shift Clipboard Contents Left
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Strip leading whitespace from each line in a string.
# @raycast.packageName Developer Utilities
# @raycast.needsConfirmation true
# @raycast.icon 📋

if ! command -v strip-indent &> /dev/null; then
	echo "strip-indent command is required (https://github.com/sindresorhus/strip-indent-cli).";
	exit 1;
fi

clipboard=$(pbpaste)

# The line with the least number of leading whitespace, ignoring empty lines, determines the number to remove.
echo "$clipboard" | strip-indent | pbcopy

echo "Copied left-shifted content"
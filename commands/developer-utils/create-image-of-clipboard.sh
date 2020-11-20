#!/bin/bash

# Dependency: carbon-now-cli (https://github.com/mixn/carbon-now-cli)
# Install via npm: `npm i -g carbon-now-cli`

# @raycast.schemaVersion 1
# @raycast.title Create Image of Clipboard Contents
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Create beautiful image of clipboard contents (typically code).
# @raycast.packageName Developer Utilities
# @raycast.currentDirectoryPath ~/Desktop

# For best experience, change needsConfirmation to "true".
# @raycast.needsConfirmation false

if ! command -v carbon-now &> /dev/null; then
	echo "carbon-now command is required (https://github.com/mixn/carbon-now-cli).";
	exit 1;
fi

date=$(date +%s)
filename="carbon-${date}"

carbon-now --from-clipboard -h --target $filename

echo "Image saved to Desktop"
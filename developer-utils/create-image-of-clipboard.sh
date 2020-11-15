#!/bin/bash -l

# Dependency: carbon-now-cli (https://github.com/mixn/carbon-now-cli)
# Install via npm: `npm i -g carbon-now-cli`

# @raycast.schemaVersion 1
# @raycast.title Create image of clipboard contents
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Create beautiful image of clipboard contents (typically code).
# @raycast.packageName Developer Utilities
# @raycast.needsConfirmation true
# @raycast.currentDirectoryPath ~/Desktop

if ! command -v carbon-now &> /dev/null; then
	echo "carbon-now command is required (https://github.com/mixn/carbon-now-cli).";
	exit 1;
fi

carbon-now --from-clipboard -h

echo "Image saved to Desktop"
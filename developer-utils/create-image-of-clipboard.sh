#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Create image of clipboard contents
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Create beautiful image of clipboard contents (typically code).
# @raycast.packageName Developer Utilities
# @raycast.needsConfirmation true
# @raycast.currentDirectoryPath ~/Desktop

cmnd=$(npm config get prefix)/bin/carbon-now

if ! command -v $cmnd &> /dev/null; then
	echo "carbon-now command is required (https://github.com/mixn/carbon-now-cli).";
	exit 1;
fi

"$cmnd" --from-clipboard -h

echo "Image saved to Desktop"
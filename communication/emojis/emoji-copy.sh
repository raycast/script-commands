#!/bin/bash

# Dependency: emoj (https://github.com/sindresorhus/emoj)
# Install via npm: `npm install --global emoj`

# @raycast.schemaVersion 1
# @raycast.title Copy emoji
# @raycast.mode compact
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Copy first emoji found from clipboard value.
# @raycast.packageName Communication
# @raycast.needsConfirmation true
# @raycast.icon 📙

if ! command -v emoj &> /dev/null; then
	echo "emoj command is required (https://github.com/sindresorhus/emoj).";
	exit 1;
fi

clipboard=$(pbpaste)

emojis=$(emoj -c "$clipboard")

if [ -z "$emojis" ]; then
	echo "No emojis found for \"${clipboard}\""
	exit 0
fi

echo "Copied emoji for \"$clipboard\""
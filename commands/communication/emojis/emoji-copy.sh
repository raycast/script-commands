#!/bin/bash

# Dependency: emoj (https://github.com/sindresorhus/emoj)
# Install via npm: `npm install --global emoj`

# @raycast.schemaVersion 1
# @raycast.title Copy Emoji
# @raycast.mode compact
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Copy first emoji related to the typed query.
# @raycast.packageName Communication
# @raycast.icon 📙
# @raycast.argument1 { "type": "text", "placeholder": "query" }

if ! command -v emoj &> /dev/null; then
	echo "emoj command is required (https://github.com/sindresorhus/emoj).";
	exit 1;
fi

emojis=$(emoj -c "$1")

if [ -z "$emojis" ]; then
	echo "No emojis found for \"$1\""
	exit 0
fi

echo "Copied emoji for \"$1\""

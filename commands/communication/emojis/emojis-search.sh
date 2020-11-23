#!/bin/bash

# Dependency: emoj (https://github.com/sindresorhus/emoj)
# Install via npm: `npm install --global emoj`

# @raycast.schemaVersion 1
# @raycast.title Search Emojis
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search related emojis to input.
# @raycast.packageName Communication
# @raycast.icon 📙
# @raycast.argument1 { "type": "text", "placeholder": "Search for..." }

if ! command -v emoj &> /dev/null; then
	echo "emoj command is required (https://github.com/sindresorhus/emoj).";
	exit 1;
fi

emojis=$(emoj "$1")

if [ -z "$emojis" ]; then
	echo "No emojis found for \"${1}\""
	exit 0
fi

echo "Emojis found for \"$1\":"
echo ""
echo "$emojis"
echo ""
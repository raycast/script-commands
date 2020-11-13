#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Get emojis
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search emojis for clipboard value.
# @raycast.needsConfirmation true
# @raycast.packageName Communication
# @raycast.icon 📙

if ! command -v emoj &> /dev/null; then
	echo "emoj command is required (https://github.com/sindresorhus/emoj).";
	exit 1;
fi

clipboard=$(pbpaste)

emojis=$(emoj "$clipboard")

if [ -z "$emojis" ]; then
	echo "No emojis found for \"${clipboard}\""
	exit 0
fi

echo "Emojis found for \"$clipboard\":"
echo ""
echo "$emojis"
echo ""
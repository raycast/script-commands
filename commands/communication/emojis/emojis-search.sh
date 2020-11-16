#!/bin/bash

# Dependency: emoj (https://github.com/sindresorhus/emoj)
# Install via npm: `npm install --global emoj`

# @raycast.schemaVersion 1
# @raycast.title Search Related Emojis from Clipboard Content
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search related emojis to clipboard content.
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
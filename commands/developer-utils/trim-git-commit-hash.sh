#!/bin/bash

# @raycast.title Trim Git Commit Hash
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Trim full git commit hash down to seven characters.

# @raycast.icon ✂
# @raycast.mode silent
# @raycast.packageName Developer Utilities
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Full git commit hash" }

str="$1"
echo ${str:0:7} | tr -d '\n' | pbcopy

echo "Copied to clipboard"

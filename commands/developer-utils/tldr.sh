#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Print TLDR doc
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Command" }
# @raycast.argument2 { "type": "text", "placeholder": "OS [linux, osx, sunos, windows]", "optional": true }
# @raycast.packageName Developer Utils

# @Documentation:
# @raycast.description Print the tldr documentation for a command
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

if ! command -v tldr &>/dev/null; then
    echo "tldr CLI is not installed."
    echo "Installation instructions: https://dbrgn.github.io/tealdeer/installing.html"
    exit 1
fi

command=$1
os=$2

if test -z "$os"; then
    tldr "$command" --color always
else
    tldr "$command" --os "$os" --color always
fi

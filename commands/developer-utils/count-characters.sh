#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Count Characters Bash
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Text", "optional": true }
# @raycast.packageName Developer Utilities

# Documentation:
# @raycast.description Counts the characters of either the clipboard or the passed argument
# @raycast.author es183923

arg=$1

if [ -z "$arg" ]
then
    # arg is NULL
    str=$(pbpaste)
    echo "${#str} chars"
else
    echo "${#arg} chars"
fi

#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate Random Number
# @raycast.mode silent
# @raycast.packageName Math
# @raycast.argument1 { "type": "text", "placeholder": "0"}
# @raycast.argument2 { "type": "text", "placeholder": "0"}
#
# Optional parameters:
# @raycast.icon 🔢
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Generate a number between a given range (inclusive) and then copy the value
# @raycast.author Matt Gleich
# @raycast.authorURL https://mattglei.ch

VALUE=$(jot -r 1 $1 $2)
echo $VALUE | pbcopy

echo "Copied value of" $VALUE

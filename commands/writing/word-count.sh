#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Word Count
# @raycast.mode inline
# @raycast.refreshTime 15s

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Writing

# Documentation:
# @raycast.description Counts the number of words of the text in the clipboard
# @raycast.author Benny Wong
# @raycast.authorURL https://bwong.net

pbpaste | wc | awk '{print "Words: " $2 ", Lines: " $1 ", Characters: ", $3}'
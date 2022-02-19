#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title Text Diff Checker
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Compare two texts and find diff (per characters, words, lines, etc.)
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://textdiff?clipboard

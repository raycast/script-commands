#!/bin/bash

# Dependency: requires translate-shell
# Install with Homebrew: `brew install translate-shell`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate To ZH
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.argument1 {"type": "text", "placeholder": "Word Or Sentence"}
# @raycast.icon 📖

# Documentation:
# @raycast.author tiancheng92
# @raycast.authorURL https://github.com/tiancheng92
# @raycast.description translate and copy brief translation to clipboard

export LC_ALL=en_US.UTF-8
export PATH="/opt/homebrew/bin:$PATH"

trans :zh $1 -d # display dictionary
trans :zh $1 -b | pbcopy # copy brief to clipboard

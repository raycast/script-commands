#!/bin/bash

# Dependency: requires translate-shell
# Install with Homebrew: `brew install translate-shell`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate To EN
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.argument1 {"type": "text", "placeholder": "Word Or Sentence"}
# @raycast.icon 📖

# Documentation:
# @raycast.author tiancheng92

export LC_ALL=en_US.UTF-8
export PATH="/opt/homebrew/bin:$PATH"

trans :en $1 -d # display dictionary
trans :en $1 -b | pbcopy # copy brief to clipboard

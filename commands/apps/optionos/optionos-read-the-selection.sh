#!/bin/bash

# Note: optionOS required
# Install via Homebrew: `brew install --cask yemreak/tap/optionos` or download from https://optionos.app

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Read the Selection
# @raycast.mode silent
# @raycast.packageName optionOS

# Optional parameters:
# @raycast.icon images/optionos.png

# Documentation:
# @raycast.description Select text, run this, hear it.
# @raycast.author Yunus Emre Ak
# @raycast.authorURL https://github.com/yemreak

open "optionos-say://selection"

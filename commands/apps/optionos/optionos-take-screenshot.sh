#!/bin/bash

# Note: optionOS required
# Install via Homebrew: `brew install --cask yemreak/tap/optionos` or download from https://optionos.app

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Take Screenshot
# @raycast.mode silent
# @raycast.packageName optionOS

# Optional parameters:
# @raycast.icon images/optionos.png

# Documentation:
# @raycast.description The window under your cursor becomes a file your agent sees.
# @raycast.author Yunus Emre Ak
# @raycast.authorURL https://github.com/yemreak

open "optionos-screen://action/take-a-screenshot-of-the-window-under-the-cursor"

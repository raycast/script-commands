#!/bin/bash

# Note: optionOS required
# Install via Homebrew: `brew install --cask yemreak/tap/optionos` or download from https://optionos.app

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Recording
# @raycast.mode silent
# @raycast.packageName optionOS

# Optional parameters:
# @raycast.icon images/optionos.png

# Documentation:
# @raycast.description Start or stop a dictation. The text lands where you were.
# @raycast.author yemreak
# @raycast.authorURL https://github.com/yemreak

open "optionos-dictation://record"

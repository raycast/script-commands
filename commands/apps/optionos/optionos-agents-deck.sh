#!/bin/bash

# Note: optionOS required
# Install via Homebrew: `brew install --cask yemreak/tap/optionos` or download from https://optionos.app

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Agents Deck
# @raycast.mode silent
# @raycast.packageName optionOS

# Optional parameters:
# @raycast.icon images/optionos.png

# Documentation:
# @raycast.description Every running agent in one deck. Pick one, keep talking.
# @raycast.author Yunus Emre Ak
# @raycast.authorURL https://github.com/yemreak

open "optionos-agent://deck"

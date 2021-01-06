#!/bin/bash

# Dependency: requires defaultbrowser (https://github.com/kerma/defaultbrowser/)
# Install via Homebrew: `brew install defaultbrowser`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch Default Browser to Chrome
# @raycast.mode silent
# @raycast.packageName Browsing

# Optional parameters:
# @raycast.icon 🧭

# Documentation:
# @raycast.description Set Chrome as the default browser.

defaultbrowser chrome
exit 0

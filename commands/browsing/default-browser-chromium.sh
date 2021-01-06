#!/bin/bash

# Dependency: requires defaultbrowser (https://github.com/kerma/defaultbrowser/)
# Install via Homebrew: `brew install defaultbrowser`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch Default Browser to Chromium
# @raycast.mode silent
# @raycast.packageName Browsing

# Optional parameters:
# @raycast.icon 🧭

# Documentation:
# @raycast.author Marc Klingen
# @raycast.authorURL https://github.com/marcklingen
# @raycast.description Set Chromium as the default browser.

defaultbrowser chromium
exit 0

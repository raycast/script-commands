#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reset Launchpad
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🚀
# @raycast.packageName System

# Documentation:
# @raycast.description Resets the macOS Launchpad to its default state
# @raycast.author Zach Dawson
# @raycast.authorURL https://raycast.com/zdawz

sudo find 2>/dev/null /private/var/folders/ -type d -name com.apple.dock.launchpad -exec rm -rf {} +
killall Dock

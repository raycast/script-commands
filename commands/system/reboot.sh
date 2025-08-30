#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reboot
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔄
# @raycast.packageName System

# Documentation:
# @raycast.description Reboot macOS with a clean session (apps will not be restored).
# @raycast.author Ninh Hai Dang
# @raycast.authorURL https://github.com/ninhhaidang

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script only works on macOS"
    exit 1
fi

# Disable saving app state before restart
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

# Trigger reboot with confirmation
osascript -e 'tell application "loginwindow" to «event aevtrrst»'
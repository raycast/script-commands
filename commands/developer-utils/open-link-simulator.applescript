#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Deep Link
# @raycast.mode compact

# Optional parameters:
# @raycast.argument1 { "type": "text", "placeholder": "Deep Link" }

# Documentation:
# @raycast.description Opens a URL inside the currently booted iOS Simulator. Can be used to open deeplinks
# @raycast.author Tomás Martins
# @raycast.authorURL https://github.com/tfmart
# @raycast.icon 🔗

# @raycast.packageName Developer Utilities
# @raycast.schemaVersion 1

on run argv
	do shell script "xcrun simctl openurl booted " & (item 1 of argv)
end run
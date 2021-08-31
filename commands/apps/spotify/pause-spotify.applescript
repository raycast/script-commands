#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pause Spotify
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/logo.png
# @raycast.packageName Spotify

# Documentation:
# @raycast.description Pause Spotify
# @raycast.author Dan Tamas
# @raycast.authorURL https://twitter.com/dan_tamas

tell application "Spotify" to pause


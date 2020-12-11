#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pause
# @raycast.mode silent
# @raycast.packageName Spotify

# Optional parameters:
# @raycast.icon images/spotify-logo.png

# Documentation:
# @raycast.description Pause current track in Spotify.

tell application "Spotify" to pause
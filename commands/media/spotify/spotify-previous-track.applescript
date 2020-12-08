#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Previous Track
# @raycast.mode silent
# @raycast.packageName Spotify

# Optional parameters:
# @raycast.icon images/spotify-logo.png

# Documentation:
# @raycast.description Skips to the previous track in Spotify.

tell application "Spotify" to previous track
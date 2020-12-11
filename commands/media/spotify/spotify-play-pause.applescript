#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Play/Pause
# @raycast.mode silent
# @raycast.packageName Spotify

# Optional parameters:
# @raycast.icon images/spotify-logo.png

# Documentation:
# @raycast.description Toggles play or pause of current track in Spotify.

tell application "Spotify" to playpause
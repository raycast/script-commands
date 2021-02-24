#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play Track or Playlist
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Spotify
# @raycast.icon images/spotify-logo.png

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Play playlist or track in Spotify.

# Customization:
# 1. Copy URI of track or playlist from Spotify, e.g. your discover weekly
# 2. Adjust title and description of command
property uri: ""

tell application "Spotify" to play track uri
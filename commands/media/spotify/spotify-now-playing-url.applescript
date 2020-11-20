#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Playing Song URL
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/spotify-logo.png
# @raycast.packageName Spotify
# Documentation:
# @raycast.author Jack LaFond
# @raycast.authorURL https://github.com/jacc
# @raycast.description Get link to current Spotify playing song

tell application "Spotify"
	set spotifyURL to spotify url of the current track
end tell

set AppleScript's text item delimiters to ":"
set idPart to third text item of spotifyURL

set the clipboard to ("https://open.spotify.com/track/" & idPart)

#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Current Track
# @raycast.mode inline
# @raycast.refreshTime 30s

# Optional parameters:
# @raycast.packageName Spotify
# @raycast.icon images/spotify-logo.png

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Show currently playing track in Spotify.

if application "Spotify" is not running then
	log "Not playing"
	return
end if

property currentTrackName : "Unknown Track"
property currentTrackArtist : "Unknown Artist"
property playerState : "stopped"

tell application "Spotify"
	try
		set currentTrackName to name of the current track
		set currentTrackArtist to artist of the current track
		set playerState to player state as string
	end try
end tell

if playerState is "playing" then
	log currentTrackName & " by " & currentTrackArtist
else if playerState is "paused" then
	log currentTrackName & " by " & currentTrackArtist & " (Paused)"
else
	log "Not playing"
end if

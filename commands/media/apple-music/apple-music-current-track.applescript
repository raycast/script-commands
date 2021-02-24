#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Current Track
# @raycast.mode inline
# @raycast.refreshTime 10s

# @raycast.packageName Music
# @raycast.icon images/apple-music-logo.png

# @raycast.author mmerle
# @raycast.authorURL https://github.com/mmerle
# @raycast.description Show currently playing track in Music.


if application "Music" is not running then
	log "Not playing"
	return
end if

property currentTrackName : "Unknown Track"
property currentTrackArtist : "Unknown Artist"
property playerState : "stopped"

tell application "Music"
	try
		set currentTrackName to name of the current track
		set currentTrackArtist to artist of the current track
		set playerState to player state as string
	end try
end tell

if playerState is "playing" then
	log currentTrackName & " - " & currentTrackArtist
else if playerState is "paused" then
	log currentTrackName & " - " & currentTrackArtist & " (Paused)"
else
	log "Not playing"
end if
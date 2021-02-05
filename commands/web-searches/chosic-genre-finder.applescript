#!/usr/bin/osascript


# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Chosic Genre Finder
# @raycast.mode inline

# Optional parameters:
# @raycast.packageName Spotify
# @raycast.icon https://cdn.iconscout.com/icon/free/png-512/spotify-11-432546.png

# Documentation:
# @raycast.description Find the genre of the current Spotify track 
# @raycast.author quelhasu
# @raycast.authorURL https://github.com/quelhasu

if application "Spotify" is not running then
	log "Not playing"
	return
end if

tell application "Spotify"
	try
		set spotifyURI to spotify url of the current track
		set currentTrackName to name of the current track
		set currentTrackArtist to artist of the current track
		set playerState to player state as string
	end try
end tell

set AppleScript's text item delimiters to ":"
set idPart to third text item of spotifyURI

if playerState is "playing" then
	log currentTrackName & " ~ " & currentTrackArtist
	open location "https://www.chosic.com/music-genre-finder/?track=" & idPart
else if playerState is "paused" then
	log currentTrackName & " ~ " & currentTrackArtist & " (Paused)"
	open location "https://www.chosic.com/music-genre-finder/?track=" & idPart
else
	log "Not playing"
end if

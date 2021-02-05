#!/usr/bin/osascript


# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Genre in Chosic
# @raycast.mode inline

# Optional parameters:
# @raycast.packageName Spotify
# @raycast.icon https://cdn.iconscout.com/icon/free/png-512/spotify-11-432546.png

# Documentation:
# @raycast.description Find the genre of the current Spotify track 
# @raycast.author quelhasu
# @raycast.authorURL https://github.com/quelhasu

tell application "Spotify"
	try
		set spotifyURI to spotify url of the current track
		set trackName to name of the current track
		set trackArtist to artist of the current track
	end try
end tell

set AppleScript's text item delimiters to ":"
set trackID to third text item of spotifyURI

log trackName & " ~ " & trackArtist
open location "https://www.chosic.com/music-genre-finder/?track=" & trackID

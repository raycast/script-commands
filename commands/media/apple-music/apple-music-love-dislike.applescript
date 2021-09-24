#!/usr/bin/osascript

# @raycast.title Love or Hate
# @raycast.author Bryan Schuetz
# @raycast.authorURL https://github.com/bryanschuetz
# @raycast.description Let the algorithm know how you feel about the currently playing track. Love it or hate it.
# @raycast.argument1 { "type": "text", "placeholder": "Love or Hate", "percentEncoded": false }
# @raycast.icon images/apple-music-logo.png
# @raycast.placeholder 😍 or 🤬
# @raycast.mode silent
# @raycast.packageName Apple Music
# @raycast.schemaVersion 1

on run argv
	if ({item 1 of argv} as text) = "Love" then
		tell application "Music"
			set loved of current track to true
      log "😍 Yeah, that song is the best."
		end tell
	else if ({item 1 of argv} as text) = "Hate" then
		tell application "Music"
			set disliked of current track to true
      log "🤬 Yeah, that song is absolutely the worst."
		end tell
	end if
end run


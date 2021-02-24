#!/usr/bin/osascript

## Contributions welcome to also play TV shows.

# @raycast.title Play Movie
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Play specified movie from library in TV.

# @raycast.icon images/apple-tv-logo.png
# @raycast.mode silent
# @raycast.packageName TV
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Movie" }

on run argv
	tell application "TV"
		try
			activate
			play track (item 1 of argv)
		on error
			log "Unable to play \"" & (item 1 of argv) & "\""
		end try	
	end tell
end run
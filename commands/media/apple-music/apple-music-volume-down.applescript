#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Apple Music Volume Down
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/apple-music-logo.png

# Documentation:
# @raycast.author Juan I. Serra
# @raycast.authorURL https://github.com/jiserra
# @raycast.packageName Music

try
	tell application "Music"
		set sound volume to sound volume - 5
		do shell script "echo '⬇'"
	end tell
end try
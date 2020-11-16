#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Upload
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Upload path or URL in clipboard to Cloudup
# @raycast.packageName Cloudup
# @raycast.icon images/cloudup-logo.png

set variable to (do shell script "pbpaste")

tell application "Cloudup"
	upload variable
end tell
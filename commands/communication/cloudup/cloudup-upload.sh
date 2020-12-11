#!/usr/bin/osascript

# @raycast.title Upload
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Upload path or URL in clipboard to [Cloudup](https://cloudup.com/).

# @raycast.icon images/cloudup-logo.png
# @raycast.mode silent
# @raycast.packageName Cloudup
# @raycast.schemaVersion 1

set variable to (do shell script "pbpaste")

tell application "Cloudup"
	upload variable
end tell
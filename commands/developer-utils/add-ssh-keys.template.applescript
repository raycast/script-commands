#!/usr/bin/osascript

#######################################################
## Set keyPaths array with paths to SSH keys to add. ##
#######################################################

# Array of paths to SSH keys.
# Example: set keyPaths to { "~/.ssh/id_ed25519" }
set keyPaths to {}

# @raycast.title Add SSH Keys (with Terminal)
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Add one or multiple SSH keys to your SSH agent (with Terminal).

# @raycast.icon 🔑
# @raycast.mode silent
# @raycast.packageName Developer Utilities
# @raycast.schemaVersion 1

on implode( array, delimiter )
	set AppleScript's text item delimiters to delimiter
	set implodedArray to array as string
	set AppleScript's text item delimiters to ""
	return implodedArray
end implode

set cmd to "clear; ssh-add " & implode( keyPaths,"; clear; ssh-add " )

tell application "Terminal"
	do script cmd
	activate
end tell
#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Finder Selection to Clipboard
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon ??
#
# Documentation:
# @raycast.description Copy contents of selected items in Finder to the clipboard. If there's more than one file selected, they will be combined and added to the clipboard.
# @raycast.author Felipe Turcheti
# @raycast.authorURL https://felipeturcheti.com

on run
	log "Copying contents of the selected items to the clipboard..."

	tell application "Finder"
		-- get Finder selected items
		set theItems to selection
	end tell

	-- create a list to store contents of all selected items
	set allContents to ""

	-- for each item in the Finder selection
	repeat with itemRef in theItems
		-- get the item path
		set theItem to POSIX path of (itemRef as string)
		-- read the content of the item
		set fileDescriptor to open for access (POSIX file theItem)
		set fileContent to read fileDescriptor for (get eof fileDescriptor)
		close access fileDescriptor
		-- add the content to the list
		set allContents to allContents & fileContent & "
"
	end repeat

	-- set the clipboard to the combined contents
	set the clipboard to allContents
end run

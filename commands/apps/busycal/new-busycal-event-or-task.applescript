#!/usr/bin/osascript

# Dependency: This script requires `Python3` installed: https://www.python.org/downloads/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New BusyCal Event/Task
# @raycast.mode compact
# @raycast.packageName BusyCal

# Optional parameters:
# @raycast.icon images/busycal.png
# @raycast.argument1 { "type": "text", "placeholder": "event", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "task", "optional": true }

# Documentation:
# @raycast.description This script creates a new event or task in BusyCal.
# @raycast.author Annie Ma
# @raycast.authorURL www.anniema.co

on run argv
	if (length of item 1 of argv > 0) then set query1 to encode((item 1 of argv))
	if (length of item 2 of argv > 0) then set query2 to encode((item 2 of argv))
	tell application "BusyCal"
		activate
		if (length of item 1 of argv > 0) then open location "busycalevent://new/" & query1
		if (length of item 2 of argv > 0) then open location "busycalevent://new/-" & query2
	end tell
end run

on encode(msg)
    set theText to do shell script "/usr/bin/python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))' " & quoted form of msg
    set AppleScript's text item delimiters to "/"
    set theTextItems to text items of theText
    set AppleScript's text item delimiters to "%2F"
    set theText to theTextItems as string
    set AppleScript's text item delimiters to {""}
    return theText
end encode
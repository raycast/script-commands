#!/usr/bin/osascript

# Dependency: This script requires `BusyCal` installed: https://www.busymac.com/busycal/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Event/Task
# @raycast.mode compact
# @raycast.packageName BusyCal

# Optional parameters:
# @raycast.icon images/busycal.png
# @raycast.argument1 { "type": "text", "placeholder": "entry", "percentEncoded": true}
# @raycast.argument2 { "type": "dropdown", "placeholder": "type", "data" : [{"title" : "event", "value": "event"}, {"title" : "task", "value": "task"}], "optional": true}

# Documentation:
# @raycast.description Creates new events or tasks in BusyCal.
# @raycast.author Annie Ma
# @raycast.authorURL www.anniema.co

on run argv
	set query1 to (item 1 of argv)
	tell application "BusyCal"
		activate
		if (item 2 of argv = "event") then open location "busycalevent://new/" & query1
		if (item 2 of argv = "task") then open location "busycalevent://new/-" & query1
	end tell
end run
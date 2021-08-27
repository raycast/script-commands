#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Note By Name
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/notes.png
# @raycast.argument1 { "type": "text", "placeholder": "Exact Note Name or a Substring" }
# @raycast.packageName Notes

# Documentation:
# @raycast.description This script searches for a note, given its exact name, or a substring, the search does not consider case
# if two notes or more have the same given substring the script will always show the first one
# @raycast.author Ayoub Gharbi
# @raycast.authorURL github.com/ayoub-g

on run argv

	set note_to_search to (item 1 of argv)
	tell application "Notes"
		activate
		set search_complete to false
		set note_found to false

		set folder_index to 1
		set folders_count to (count of folders)
		repeat while search_complete is false
			
			set note_index to 1
			set end_list to false
			set leave_list to false
			
			set note_names to (name of notes of folder folder_index)

			repeat while leave_list is false
				
				set note_name to item note_index of note_names

				if note_to_search is in note_name then
					
					show note note_name
					set note_found to true
					set search_complete to true
				end if
				
				set note_index to (note_index + 1)

				if note_index > (count of note_names) then
					set end_list to true
				end if

				set leave_list to end_list or note_found

			end repeat
			
			set folder_index to (folder_index + 1)
			
			if folder_index > folders_count then
				set search_complete to true
			end if
		end repeat
	end tell
end run
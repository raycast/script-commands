#!/usr/bin/osascript

# Dependency: Requires SideNotes (https://apptorium.com/sidenotes)

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SideNotes create
# @raycast.mode silent
# @raycast.packageName SideNotes

# Optional parameters:
# @raycast.packageName SideNotes
# @raycast.icon images/sidenotes.png
# @raycast.argument1 { "type": "text", "placeholder": "Note", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Folder", "optional": true }

# Documentation:
# @raycast.description Create a new note within the selected or the first SideNotes folder.
# @raycast.author Marcel Bochtler
# @raycast.authorURL https://github.com/MarcelBochtler

on run argv
	if application "SideNotes" is not running then
		log "SideNotes is not running"
		return
	end if

	tell application "SideNotes"
		set note_content to item 1 of argv
		set folder_name to item 2 of argv

		# Create a folder if none exist
		if (count of folders) is 0 then
			if folder_name is "" then
				make new folder with properties {name:note_content}
			else
				make new folder with properties {name:folder_name}
			end if
		end if

		set folder_index to my index_of_folder(folder_name, folders)

		if folder_index is -1 then
			# Folder not found. Create one if the name is given.
			# Otherwise create the note in the current or the first folder.
			if folder_name is not "" then
				set target_folder to make new folder with properties {name:folder_name}
			else
				if current folder is missing value then
					set target_folder to first folder
				else
					set target_folder to current folder
				end if
			end if
		else
			set target_folder to item folder_index of folders
		end if

		set created_note to make new note in target_folder at 1 with properties {text:note_content}

		open folder target_folder note created_note

		log "Note created in folder " & (name of target_folder)
	end tell
end run

on index_of_folder(folder_name, folder_list)
	repeat with i from 1 to the count of folder_list
		if name of item i of folder_list is folder_name then return i
	end repeat

	return -1
end index_of_folder

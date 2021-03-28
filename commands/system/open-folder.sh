#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Folder
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 📁
# @raycast.currentDirectoryPath /
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "folder_Path", "optional": false }
#
# Documentation:
# @raycast.description Open a folder on macOS 
# @raycast.author Bin Hua
# @raycast.authorURL https://github.com/hzb

if [[ ${1} =~ "~" ]]
then
	open $(sed -r 's#~#'$HOME'#' <<< "$1")
else
	open ${1}
fi
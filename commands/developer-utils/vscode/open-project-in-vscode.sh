#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Project
# @raycast.mode compact
# @raycast.packageName VS Code

# Optional parameters:
# @raycast.icon images/vscode.png
# @raycast.argument1 { "type": "text", "placeholder": "Directory Name", "optional": false }

# Documentation
# @raycast.description Finds path to the given directory which must be a VS Code or Git project and opens it with VS Code
# @raycast.author Maksim Zemlyanikin
# @raycast.authorURL https://github.com/Maksimka101

directory=$1
foundDirectory=''
if [ -z $directory ]; then
  echo "Empty directory is not allowed"
  exit 1
fi

set +e
directories=$(find $HOME -name $directory -type d -maxdepth 5)
for dir in $directories; do
  if [[ -n "$(find $dir -name .vscode -maxdepth 1)" || -n "$(find $dir -name .git -maxdepth 1)" ]]; then
    foundDirectory=$dir
  fi
done

if [ -n $foundDirectory ]; then
  echo "Project directory is $foundDirectory"
  if [ -n $(which code) ]; then
    code -n $foundDirectory
  else
    open -n -b \"com.microsoft.VSCode\" --args $foundDirectory
  fi
else
  echo "No such directory in '$HOME' with name $1"
fi
exit 0

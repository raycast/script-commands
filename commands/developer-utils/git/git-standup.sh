#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Standup
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.argument1 { "type": "text", "placeholder": "Since", "optional": true }
# @raycast.currentDirectoryPath ~/Developer/script-commands

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Lists your commits from the last 24 hours. Optionally specify since when, e.g. "1 week".

if [ -n "$1" ]; then
  SINCE="$1"
else
  SINCE="yesterday.midnight"
fi

USER_NAME=$(git config user.name)
git log --author="$USER_NAME" --since="$SINCE" --oneline --pretty=format:"%s %Cblue(%ar)%Creset" --color

#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Standup
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.argument1 { "type": "text", "placeholder": "Project name"}
# @raycast.argument2 { "type": "text", "placeholder": "Since (optional; eg. 1 week)", "optional": true }


# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Lists your commits from the last 24 hours. Optionally specify since when, e.g. "1 week".

if [ -n "$1" ]; then
  PROJECT="$1"
else
  echo "Please given project name in ~/code"
  exit 1
fi

if [ -n "$2" ]; then
  SINCE="$2"
else
  SINCE="yesterday.midnight"
fi
cd ~/code/"$PROJECT"

USER_NAME=$(git config user.name)
git log --author="$USER_NAME" --since="$SINCE" --oneline --pretty=format:"%s %Cblue(%ar)%Creset" --color

#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Standup
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.argument1 { "type": "text", "placeholder": "Project Path"}
# @raycast.argument2 { "type": "text", "placeholder": "Since (e.g: 1 week)", "optional": true }

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Lists your commits from the last 24 hours. Optionally specify since when, e.g. "1 week".

if [ -n "$1" ]; then
  PROJECT_PATH="$1"
else
  echo "Please give project path"
  exit 1
fi

if [ -n "$2" ]; then
  SINCE="$2"
else
  SINCE="yesterday.midnight"
fi
cd "$PROJECT_PATH" || exit 1

USER_NAME=$(git config user.name)
git log --author="$USER_NAME" --since="$SINCE" --oneline --pretty=format:"%s %Cblue(%ar)%Creset" --color

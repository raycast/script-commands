#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Save Changes
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.argument1 { "type": "text", "placeholder": "Message", "optional": true }
# @raycast.currentDirectoryPath ~/Developer/script-commands

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Commit all pending changes. If no commit message is provided, it will amend the changes.

STATUS=$(git status --short)

if [ -z "$STATUS" ]; then
  echo "No changes to save"
  exit 1
fi

if [ -n "$1" ]; then
  git commit --all --message "$1"
  echo "Committed changes"
else
  git commit -all --amend --no-edit
  echo "Amended changes"
fi
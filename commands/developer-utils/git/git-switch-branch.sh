#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch Branch
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.argument1 { "type": "text", "placeholder": "Name", "optional": true }
# @raycast.currentDirectoryPath ~/Developer/script-commands

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Switch to a new branch. If not name was provided, it checks out the default branch.

if [ -n "$1" ]; then
  BRANCH_NAME="$1"
else
  BRANCH_NAME=$(git symbolic-ref --short HEAD)
fi

git checkout --branch $BRANCH_NAME
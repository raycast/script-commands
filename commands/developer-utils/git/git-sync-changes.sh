#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sync Changes
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.currentDirectoryPath ~/Developer/script-commands

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Pulls, rebases and pushes your changes.

git pull --rebase
git push

echo "Synced changes"
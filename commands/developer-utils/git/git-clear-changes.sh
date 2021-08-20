#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Changes
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.needsConfirmation true
# @raycast.currentDirectoryPath ~/Developer/script-commands

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Clear all changes

git clean -d -x --force
git reset --hard

echo "Cleared changes"
#!/bin/bash

# Note: Set currentDirectoryPath to your local repository.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Status
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 5m

# Optional parameters:
# @raycast.icon ./images/git.png
# @raycast.packageName Git
# @raycast.currentDirectoryPath ~/Developer/script-commands

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Shows the status of your Git repository.

MESSAGE=""

ADDED=$(git status --short | grep -c " A")
if [ $ADDED -gt 0 ]; then
  MESSAGE="$MESSAGE \\033[32m$ADDED Added\\033[0m"
fi

MODIFIED=$(git status --short | grep -c " M")
if [ $MODIFIED -gt 0 ]; then
  MESSAGE="$MESSAGE \\033[33m$MODIFIED Modified\\033[0m"
fi

DELETED=$(git status --short | grep -c " D")
if [ $DELETED -gt 0 ]; then
  MESSAGE="$MESSAGE \\033[31m$DELETED Deleted\\033[0m"
fi

UNTRACKED=$(git status --short | grep -c "??")
if [ $UNTRACKED -gt 0 ]; then
  MESSAGE="$MESSAGE \\033[34m$UNTRACKED Untracked\\033[0m"
fi

if [ -z "$MESSAGE" ]; then
  MESSAGE="No pending changes"
fi

echo -e $MESSAGE
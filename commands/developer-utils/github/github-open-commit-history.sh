#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Commit History
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/github-logo.png
# @raycast.iconDark ./images/github-logo-iconDark.png
# @raycast.packageName GitHub

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Opens the commit history of the filepath in the clipboard or the frontmost window. Alternatively can open the file view on GitHub.

# Configuration:

# Set the branch to open on GitHub.
BRANCH="master"
# Set the page to open for the file. Available values: commits, blob, blame
PAGE="commits"
# Enable to get verbose output.
DEBUG=false

# Utils:

get_current_filepath_of_frontmost_application() {
  osascript -e '
    tell application "System Events" to set frontmostApplication to name of first process whose frontmost is true

    if (frontmostApplication is "Finder") then
      tell application "Finder" 
        get POSIX path of (selection as alias)
      end tell
    else if (frontmostApplication is "iTerm2") then
      tell application "iTerm"
        tell current session of current window
          get variable named "session.path"
        end tell
      end tell
    else
      tell application "System Events"
        tell (first process where frontmost is true)
          get value of attribute "AXDocument" of first window
        end tell
      end tell
    end if
  '
}

# Main:

CLIPBOARD_CONTENTS=$(pbpaste)
if [[ -d $CLIPBOARD_CONTENTS || -f $CLIPBOARD_CONTENTS ]]; then
  FILEPATH=$CLIPBOARD_CONTENTS
else
  FRONTMOST_FILEPATH=$(get_current_filepath_of_frontmost_application)
  FILEPATH=${FRONTMOST_FILEPATH#"file://"}
fi

if [ "$DEBUG" = true ] ; then
  echo "Extracted filepath: $FILEPATH"
fi

if [[ -d $FILEPATH || -f $FILEPATH ]]; then
  cd `dirname $FILEPATH`

  if git rev-parse > /dev/null 2>&1; then
    GIT_REPOSITORY_ROOT_PATH=$(git rev-parse --show-toplevel)
    RELATIVE_FILEPATH=${FILEPATH#"$GIT_REPOSITORY_ROOT_PATH/"}

    BASE=$(git config --get remote.origin.url | sed s/\\.git// | sed 's/:/\//' | sed 's/.*github.com/https:\/\/github.com/')
    URL="$BASE/$PAGE/$BRANCH/$RELATIVE_FILEPATH"

    open $URL
  else
    echo "Not a Git repostiory"
    exit 1
  fi
else
  echo "Not a valid filepath"
  exit 1
fi
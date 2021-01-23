#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Visit a Repository, Pull Request, or Issue
# @raycast.mode compact
#
# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
# @raycast.argument1 { "type": "text", "placeholder": "Organization/Repository" }
# @raycast.argument2 { "type": "text", "placeholder": "Pull Request #", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Issue #", "optional": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Open a repository, pull request, or issue on GitHub

path=""
if [[ -n "$2" && -n "$3" ]]; then
  echo "Do not pass both a pull request and an issue."
  exit 1
elif [[ -n "$2" ]]; then
  path="/pull/$2"
elif [[ -n "$3" ]]; then
  path="/issues/$3"
fi

echo "Opening $1$path on GitHub..."
open "https://github.com/$1$path"
exit 0

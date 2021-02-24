#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Visit a Repository, Pull Request, or Issue
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName GitHub
# @raycast.icon images/github-logo.png
# @raycast.iconDark images/github-logo-iconDark.png
# @raycast.argument1 { "type": "text", "placeholder": "Organization/Repository" }
# @raycast.argument2 { "type": "text", "placeholder": "Pull Request or Issue #", "optional": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Open a repository, pull request, or issue on GitHub

path=""
if [ -n "$2" ]; then
  path="/pull/$2"
fi

open "https://github.com/$1$path"

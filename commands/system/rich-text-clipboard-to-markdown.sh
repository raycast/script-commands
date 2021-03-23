#!/bin/bash

# @raycast.title Rich Text to Markdown
# @raycast.author Adam Zethraeus
# @raycast.authorURL https://github.com/adam-zethraeus
# @raycast.description Convert rich text clipboard data to GitHub Flavoured Markdown using Pandoc
#
# @raycast.icon 📝
#
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

# Dependency: This script requires the `pandoc` cli to be installed: https://pandoc.org/
# Install via homebrew: `brew install pandoc`

if ! command -v pandoc &> /dev/null; then
      echo "pandoc is required (https://pandoc.org/).";
      exit 1;
fi

export LC_CTYPE=UTF-8
osascript -e 'the clipboard as "HTML"'| perl -ne 'print chr foreach unpack("C*",pack("H*",substr($_,11,-3)))' | pandoc --from=html --to=gfm | pbcopy

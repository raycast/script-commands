#!/bin/bash

# Dependency: This script requires the `pandoc` cli to be installed: https://pandoc.org/
# Install via homebrew: `brew install pandoc`

# @raycast.title Rich Text to Markdown
# @raycast.author Adam Zethraeus
# @raycast.authorURL https://github.com/adam-zethraeus
# @raycast.description Convert rich text clipboard data to GitHub Flavored Markdown using Pandoc
#
# @raycast.icon 📝
#
# @raycast.mode silent
# @raycast.packageName Conversions
# @raycast.schemaVersion 1

if ! command -v pandoc &> /dev/null; then
      echo "pandoc is required (https://pandoc.org/).";
      exit 1;
fi

export LC_CTYPE=UTF-8
osascript -e 'the clipboard as «class RTF »' | perl -ne 'print chr foreach unpack("C*",pack("H*",substr($_,11,-3)))' | pandoc --from=rtf --to=gfm | pbcopy

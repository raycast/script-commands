#!/bin/bash

# Dependency: This script requires the `pandoc` cli to be installed: https://pandoc.org/
# Install via homebrew: `brew install pandoc`

# @raycast.title Rich Text to Markdown
# @raycast.author Adam Zethraeus
# @raycast.authorURL https://github.com/adam-zethraeus
# @raycast.description Convert rich text clipboard data (preserving hyperlinked text as [label](url)) to GitHub Flavored Markdown using Pandoc. Tries the HTML pasteboard flavor first, falls back to RTF.
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

# Prefer HTML: most modern web sources (browsers, Gmail, Google Docs, Notion,
# Linear, etc.) place higher-fidelity HTML on the pasteboard than RTF, and it
# preserves hyperlinked text as real anchor tags that pandoc renders as
# [label](url) in markdown.
html=$(osascript -e 'try' -e 'the clipboard as «class HTML»' -e 'on error' -e 'return ""' -e 'end try' 2>/dev/null \
  | perl -ne 'chomp; next unless s/^«data HTML//; s/»$//; print pack("H*", $_)')

if [ -n "$html" ]; then
    printf '%s' "$html" | pandoc --from=html --to=gfm | pbcopy
    exit 0
fi

# Fall back to RTF for sources that only expose rich text (some native apps,
# older editors). This is the original behavior of the script.
osascript -e 'the clipboard as «class RTF »' | perl -ne 'print chr foreach unpack("C*",pack("H*",substr($_,11,-3)))' | pandoc --from=rtf --to=gfm | pbcopy

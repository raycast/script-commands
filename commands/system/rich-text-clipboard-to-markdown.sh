#!/bin/bash

# @raycast.title rtf2md
# @raycast.author Adam Zethraeus
# @raycast.authorURL https://github.com/adam-zethraeus
# @raycast.description Convert rich text clipboard data to github flavoured markdown using pandoc
#
# @raycast.icon 📝
#
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

export LC_CTYPE=UTF-8
osascript -e 'the clipboard as "HTML"'| perl -ne 'print chr foreach unpack("C*",pack("H*",substr($_,11,-3)))' | pandoc --from=html --to=gfm | pbcopy

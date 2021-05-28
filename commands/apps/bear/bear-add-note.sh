#!/bin/bash

# Install Bear via Mac App Store: https://apps.apple.com/us/app/bear/id1091189122

# @raycast.title Add Note
# @raycast.author Tanay Nistala
# @raycast.authorURL https://github.com/tanaynistala
# @raycast.description Add a new note to Bear.
#
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
#
# @raycast.mode silent
# @raycast.packageName Bear
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true}
# @raycast.argument2 { "type": "text", "placeholder": "Content", "optional": true, "percentEncoded": true}
# @raycast.argument3 { "type": "text", "placeholder": "Use Clipboard?", "optional": true, "percentEncoded": true}

open "bear://x-callback-url/create?title=${1}&clipboard=${3}&text=${2}"

echo "Note created!"

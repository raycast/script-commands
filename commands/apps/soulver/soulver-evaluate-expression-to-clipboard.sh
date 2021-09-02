#!/bin/bash

# Install Soulver from website: https://www.soulver.app

# @raycast.title Evaluate Expression to Clipboard
# @raycast.author Dave Lehman
# @raycast.authorURL https://github.com/dlehman
# @raycast.description Evaluate expression in new Soulver document and copy to clipboard.
#
# @raycast.icon images/soulver.png
#
# @raycast.mode silent
# @raycast.packageName Soulver
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Expression", "percentEncoded": true}

open "x-soulver://x-callback-url/calculate?&expression=${1}&to_clipboard=true"

echo "Document created!"

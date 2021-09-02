#!/bin/bash

# Install Soulver from website: https://www.soulver.app

# @raycast.title Evaluate Expression
# @raycast.author Dave Lehman
# @raycast.authorURL https://github.com/dlehman
# @raycast.description Evaluate expression in new Soulver document.
#
# @raycast.icon images/soulver.png
#
# @raycast.mode silent
# @raycast.packageName Soulver
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Expression", "percentEncoded": true}

open "x-soulver://x-callback-url/create?&expression=${1}"

echo "Document created!"

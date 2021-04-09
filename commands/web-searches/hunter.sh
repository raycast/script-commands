#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Find Email Address With Hunter
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/hunter.png
# @raycast.argument1 { "type": "text", "placeholder": "First Name", "percentEncoded": true, "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "Last Name", "percentEncoded": true, "optional": false }
# @raycast.argument3 { "type": "text", "placeholder": "Domain", "percentEncoded": true, "optional": false }
# @raycast.packageName Web Searches

# Documentation:
# @raycast.description Find emails using hunter.io
# @raycast.author Tanguy Le Stradic
# @raycast.authorURL https://github.com/tanguyls

first_name=$1
last_name=$2
domain=$3

open https://hunter.io/find/$domain/$first_name%20$last_name

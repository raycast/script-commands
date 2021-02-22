#!/bin/bash

# @raycast.title WordPress Functions Reference
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open [WordPress functions reference](https://developer.wordpress.org/reference/functions/) for specified function.

# @raycast.icon images/wordpress-logo.png
# @raycast.iconDark images/wordpress-logo-iconDark.png
# @raycast.mode silent
# @raycast.packageName WordPress
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Function name", "percentEncoded": true }

open "https://developer.wordpress.org/reference/functions/${1}/"
#!/bin/bash

# @raycast.title WordPress Function Reference
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open WordPress function reference.

# @raycast.icon images/wordpress-logo.png
# @raycast.mode silent
# @raycast.packageName WordPress
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Function name" }

open "https://developer.wordpress.org/reference/functions//${1// /%20}/"
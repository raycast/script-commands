#!/bin/bash

# @raycast.title WordPress Classes Reference
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open [WordPress classes reference](https://developer.wordpress.org/reference/classes/) for specified class.

# @raycast.icon images/wordpress-logo.png
# @raycast.mode silent
# @raycast.packageName WordPress
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Class name" }

open "https://developer.wordpress.org/reference/classes//${1// /%20}/"
#!/bin/bash

# @raycast.title WordPress Class Reference
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open WordPress class reference.

# @raycast.icon images/wordpress-logo.png
# @raycast.mode silent
# @raycast.packageName WordPress
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Class name" }

open "https://developer.wordpress.org/reference/classes//${1// /%20}/"
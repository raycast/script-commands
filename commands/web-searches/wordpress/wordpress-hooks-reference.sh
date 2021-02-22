#!/bin/bash

# @raycast.title WordPress Hooks Reference
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open [WordPress hooks reference](https://developer.wordpress.org/reference/hooks/) for specified hook.

# @raycast.icon images/wordpress-logo.png
# @raycast.iconDark images/wordpress-logo-iconDark.png
# @raycast.mode silent
# @raycast.packageName WordPress
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Hook name", "percentEncoded": true }

open "https://developer.wordpress.org/reference/hooks/${1}/"
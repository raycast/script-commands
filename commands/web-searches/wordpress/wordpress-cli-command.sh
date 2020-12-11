#!/bin/bash

# @raycast.title WordPress CLI Command
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open [WordPress CLI command reference](https://developer.wordpress.org/cli/commands/) for specified command.

# @raycast.icon images/wordpress-logo.png
# @raycast.iconDark images/wordpress-logo-iconDark.png
# @raycast.mode silent
# @raycast.packageName WordPress
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Command" }

open "https://developer.wordpress.org/cli/commands/${1// //}/"
#!/bin/bash

# @raycast.title Open WP Engine Install
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open specified [WP Engine](https://wpengine.com) install.

# @raycast.icon images/wpengine-logo.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Install" }

open "https://my.wpengine.com/installs/${1// /}"

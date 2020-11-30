#!/bin/bash

# @raycast.title Search WordPress Docs
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search [WordPress Developer documentation](https://developer.wordpress.org/reference/).

# @raycast.icon images/wordpress-logo.png
# @raycast.mode silent
# @raycast.packageName WordPress
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Query" }

open "https://wordpress.org/search/${1// /%20}?in=developer_documentation"
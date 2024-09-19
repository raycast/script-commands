#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Rust Documentation
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Web Searches
# @raycast.icon images/rust.png
# @raycast.argument1 { "type": "text", "placeholder": "Name", "percentEncoded": true }
# 
# Example query:  
#   Searching for `expect` will open this link in your browser:  
#     `https://doc.rust-lang.org/std/?search=expect`.
# 
# Documentation:
# @raycast.author lemorage
# @raycast.authorURL https://raycast.com/lemorage
# @raycast.description Search Rust documentation

query=$(echo "$1" | sed 's/ /%20/g')

open "https://doc.rust-lang.org/std/?search=$query"

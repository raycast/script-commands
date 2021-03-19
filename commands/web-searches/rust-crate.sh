#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search for Crate
# @raycast.mode silent
# @raycast.packageName Web Search
# @raycast.argument1 { "type": "text", "placeholder": "Name", "percentEncoded": true }
#
# Optional parameters:
# @raycast.icon ./images/cargo-logo.png
#
# Documentation:
# @raycast.description Search for a rust crate on crates.io
# @raycast.author Matthew Gleich
# @raycast.authorURL https://mattglei.ch

open "https://crates.io/search?q=$1"

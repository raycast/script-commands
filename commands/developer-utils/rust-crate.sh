#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search for Crate
# @raycast.mode silent
# @raycast.packageName Rust
# @raycast.argument1 { "type": "text", "placeholder": "name", "percentEncoded": true }
#
# Optional parameters:
# @raycast.icon ./images/cargo-logo.png
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Search for a rust crate on cargos.io
# @raycast.author Matthew Gleich
# @raycast.authorURL https://mattglei.ch

open "https://crates.io/search?q=$1"

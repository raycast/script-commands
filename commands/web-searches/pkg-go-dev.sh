#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Go Package Documentation
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Web Searches
# @raycast.icon images/go.png
# @raycast.argument1 { "type": "text", "placeholder": "Package", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Version (default: latest)", "optional": true }
#   Note: For standard library packages, prefix the version with 'go'. For others, prefix with 'v'.
#   Ex: To search for documentation on the 'time' package from Go version 1.12.3, pass 'go1.12.3'.
#       To search for documentation on the 'github.com/gorilla/mux' package from version 1.7.0, pass 'v1.7.0'.
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Search pkg.go.dev for package documentation

version=""
if [ -n "$2" ]; then
  version="@$2"
fi

open "https://pkg.go.dev/$1$version"

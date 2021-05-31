#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pub.dev Search
# @raycast.description Search [pub.dev](https://pub.dev/) for packages to build Dart and Flutter apps.
# @raycast.mode silent
# @raycast.author Wade Garrett
# @raycast.authorURL https://wadegarrett.com

# Optional parameters:
# @raycast.icon images/dart-logo.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "search", "percentEncoded": true }

open "https://pub.dev/packages?q=${1}"

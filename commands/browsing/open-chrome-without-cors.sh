#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open without CORS
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/chrome-icon.png
# @raycast.packageName Chrome
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Open chrome with web security option disabled.
# @raycast.author Tahsin Yazkan
# @raycast.authorURL https://github.com/thsnyzkn

open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security


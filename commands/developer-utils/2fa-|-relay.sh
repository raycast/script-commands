#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title 2FA | relay
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Develop Utils

# Documentation:
# @raycast.author 张扬
# @raycast.authorURL https://github.com/dreamkidd

code=`/usr/local/bin/oathtool --totp --base32 'DYAUNKAD63SUY634'`
echo "$code"
pin_token="911120$code"
echo "$pin_token" | pbcopy
exit
#!/bin/bash

# @raycast.title QR Code Generation
# @raycast.description QR Code Generation
# @raycast.author wyhaya
# @raycast.authorURL https://github.com/wyhaya

# @raycast.icon images/qrcode.png
# @raycast.mode fullOutput
# @raycast.packageName Conversions
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Content" }

echo $1 | curl -s qrcode.show -d @-

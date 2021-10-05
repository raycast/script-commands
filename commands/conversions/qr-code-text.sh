#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title QR Code to clipboard
# @raycast.mode silent
# @raycast.packageName Conversions
#
# Optional parameters:
# @raycast.icon images/qrcode.icns
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Decode QR Code from screenshot to clipboard using https://qrserver.com/
# @raycast.author Diego Lopes
# @raycast.authorURL https://github.com/Dihgg


TEMP_DIR=$(mktemp -d)
screencapture -i "$TEMP_DIR/screenshot.png"

curl --location --request POST 'https://api.qrserver.com/v1/read-qr-code/' --form file=@$TEMP_DIR/screenshot.png >> $TEMP_DIR/qr-code.json

cat $TEMP_DIR/qr-code.json | awk -v tgt='data' '{
    while ( match($0,/"[^"]*"/) ) {
        hit = substr($0,RSTART+1,RLENGTH-2)
        if ( ++cnt % 2 ) {
            tag = hit
        }
        else {
            val = hit
            f[tag] = val
        }
        $0 = substr($0,RSTART+RLENGTH)
    }
    print f[tgt]
}' >> "$TEMP_DIR/data.txt"

if ! [[ "$(cat $TEMP_DIR/data.txt)" -eq "error" ]]; then
    pbcopy < $TEMP_DIR/data.txt
    echo 'Gathered text from QR Code'
    exit 0;
fi

echo 'Error while gathering the QR Code!'
exit 0;


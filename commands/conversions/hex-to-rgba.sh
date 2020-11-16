#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Hex to RGBA
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Convert HEX color values in your Clipboard to RGBA values.
# @raycast.icon 🎨

hex=$(pbpaste)
first="${hex:0:1}"

if [ "#" = "$first" ]; then
	hex="${hex:1:6}"
fi

hex_r="${hex:0:2}"
hex_g="${hex:2:2}"
hex_b="${hex:4:2}"

rgba_r=`echo "obase=10; ibase=16; $hex_r" | bc`
rgba_g=`echo "obase=10; ibase=16; $hex_g" | bc`
rgba_b=`echo "obase=10; ibase=16; $hex_b" | bc`

rgba="rgba( $rgba_r, $rgba_g, $rgba_b, 1 )"

echo $rgba | pbcopy

echo "Converted #$hex to $rgba"
#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Trim Newlines and Tabs
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Trim newlines and tabs from clipboard content.
# @raycast.icon ✂️
# @raycast.packageName Conversions

file=$( mktemp )
pbpaste > $file

output=$( tr '\n' ' ' < $file )
echo "$output" > $file

output=$( tr '\r' ' ' < $file )
echo "$output" > $file

output=$( tr '\t' ' ' < $file )
rm $file

echo -n $output

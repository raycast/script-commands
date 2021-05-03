#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Modify File Extension
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌵
# @raycast.argument1 { "type": "text", "placeholder": "Before" }
# @raycast.argument2 { "type": "text", "placeholder": "After" }

# @Documentation:
# @raycast.description Batch modify the file in the current directory or the specified extension of the selected file
# @raycast.author LokHsu
# @raycast.authorURL https://github.com/lokhsu

finder=$(
    osascript <<EOF
        tell application "Finder"
            try
                set finderPath to (POSIX path of (the selection as alias))
            on error
                set finderPath to (POSIX path of (folder of the front window as alias))
            end try
        end tell
        return finderPath
    EOF
)

count=0

if [ -d $finder ]; then
    for file in `ls ${finder}`
        do
            if [[ $file =~ \.$1$ ]]; then
                count=$[$count+1]
                convert=${finder}${file}
                mv "${convert}" "${convert%.$1}.$2";
            fi
    done
elif [[ $finder =~ \.$1$ ]]; then
    mv "${finder}" "${finder%.$1}.$2";
    count=$[$count+1]
fi

if  [ $count -gt 0 ]; then
    echo "$count files modified successfully"
else
    echo "no files to convert"
fi

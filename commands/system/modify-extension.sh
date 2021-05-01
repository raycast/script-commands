#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌵
# @raycast.argument1 { "type": "text", "placeholder": "Before" }
# @raycast.argument2 { "type": "text", "placeholder": "After" }

# @Documentation:
# @raycast.description 修改文件扩展名
# @raycast.author LokHsu

finder=$(
    osascript <<EOF
        tell application "Finder"
            try   #获取当前finder目录
                set finderPath to (POSIX path of (folder of the front window as alias))
            on error   #获取当前桌面目录
                set finderPath to (POSIX path of (path to Desktop folder as alias))
            end try
        end tell
        return finderPath
    EOF
)

count=0

for file in `ls ${finder}`
    do
        if [[ $file =~ \.$1$ ]]; then
            count=$[$count+1]
            convert=${finder}${file}
            mv "${convert}" "${convert%.$1}.$2";
        fi
done

if  [ $count -gt 0 ]; then
    echo "$count files modified successfully"
else
    echo "no files to convert"
fi
#!/bin/bash

# @raycast.title Search Stack Overflow
# @raycast.author Federico Miraglia | Edoardo Sera
# @raycast.authorURL https://github.com/Mitra98t | https://github.com/Edoardo995
# @raycast.description Search on [Stack Overflow](https://stackoverflow.com), can also use tags.

# @raycast.mode silent
# @raycast.icon 💻
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Tag (language)", "optional":true, "percentEncoded": true }

if [ -n "${2}" ]
then
    open "https://stackoverflow.com/search?q=%5B${2}%5D+${1}"
else
    open "https://stackoverflow.com/search?q=${1}"
fi
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in MenubarX
# @raycast.mode silent
# Optional parameters:
# @raycast.icon images/menubarx_logo.png
# @raycast.packageName MenubarX

# Documentation:
# @raycast.description Open Pasteboard link in MenubarX
# @raycast.author Clu Soh
# @raycast.authorURL https://twitter.com/designedbyclu

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
pasteboard=$(pbpaste)

if [[ $pasteboard =~ $regex ]]
then 
    open "menubarx://open/?xurl=$pasteboard"
    echo "Opened in MenubarX"
else
    echo "Seem like is not a URL you copied"
fi
    




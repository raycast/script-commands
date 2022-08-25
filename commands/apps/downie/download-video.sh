#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Download Video
# @raycast.mode silent
# Optional parameters:
# @raycast.icon images/downie.png
# @raycast.packageName Downie

# Documentation:
# @raycast.description Download video from Pasteboard link
# @raycast.author Clu Soh
# @raycast.authorURL https://twitter.com/designedbyclu

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
pasteboard=$(pbpaste)

if [[ $pasteboard =~ $regex ]]
then 
    open "downie://XUOpenLink?url=$pasteboard"
    echo "Downloading in Downie"
else
    echo "Seem like is not a URL you copied"
fi
    




#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Countdown to Christmas
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon 🎅🏻

# Documentation:
# @raycast.author Valentin Chrétien
# @raycast.authorURL https://github.com/valentinchrt
# @raycast.description See how many days until Christmas.

XMAS=`gdate -d "Dec 25" +%j`
TODAY=`gdate +%j`
DAYS=$(($XMAS - $TODAY))
if [[  $DAYS > 0 ]]; then
        echo There are $DAYS days left until Xmas.
else
        echo Merry Xmas and Happy New year\!
fi

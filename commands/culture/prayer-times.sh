#!/bin/bash

# You may need to install coreutils via homebrew to make this script work (gdate function).
#
# Homebrew: https://brew.sh/
# Coreutils: https://formulae.brew.sh/formula/coreutils

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Prayer Times
# @raycast.mode inline
# @raycast.packageName Culture

# Optional parameters:
# @raycast.icon 🕌

# Documentation
# @raycast.author Emircan Erkul
# @raycast.authorURL https://emircanerkul.com
# @raycast.description Prayer Times grabbed from the aladhan.com.

data=$(curl -s -L 'http://api.aladhan.com/v1/timingsByCity?city=derince&country=turkey&method=13')

imsak=$(echo "$data" | jq --raw-output '.data.timings.Imsak')
gunes=$(echo $data | jq --raw-output '.data.timings.Sunrise')
ogle=$(echo "$data" | jq --raw-output '.data.timings.Dhuhr')
ikindi=$(echo "$data" | jq --raw-output '.data.timings.Asr')
aksam=$(echo "$data" | jq --raw-output '.data.timings.Maghrib')
yatsi=$(echo "$data" | jq --raw-output '.data.timings.Isha')

NOW=$(gdate +%s)

if [ $(($(gdate -d "$imsak" +%s) - $NOW)) -gt 0 ]; then
    REMANINING=$(($(gdate -d "$imsak" +%s) - $NOW))
elif [ $(($(gdate -d "$gunes" +%s) - $NOW)) -gt 0 ]; then
    REMANINING=$(($(gdate -d "$gunes" +%s) - $NOW))
elif [ $(($(gdate -d "$ogle" +%s) - $NOW)) -gt 0 ]; then
    REMANINING=$(($(gdate -d "$ogle" +%s) - $NOW))
elif [ $(($(gdate -d "$ikindi" +%s) - $NOW)) -gt 0 ]; then
    REMANINING=$(($(gdate -d "$ikindi" +%s) - $NOW))
elif [ $(($(gdate -d "$aksam" +%s) - $NOW)) -gt 0 ]; then
    REMANINING=$(($(gdate -d "$aksam" +%s) - $NOW))
else
    REMANINING=$(($(gdate -d "$yatsi" +%s) - $NOW))
fi

if [ $REMANINING -gt 0 ]; then
    if [ $(($REMANINING / 3600)) -gt 0 ]; then
        REMANINING="$(($REMANINING / 3600))h $(($REMANINING / 60 % 60))m $(($REMANINING % 60))s"
    elif [ $(($REMANINING / 60 % 60)) -gt 0 ]; then
        REMANINING="$(($REMANINING / 60 % 60))m $(($REMANINING % 60))s"
    else
        REMANINING="$(($REMANINING % 60))s"
    fi
    REMANINING="☾ $REMANINING ☽"
else
    REMANINING=""
fi

output="$REMANINING $imsak ⚙︎ $gunes ⚙︎ $ogle ⚙︎ $ikindi ⚙︎ $aksam ⚙︎ $yatsi"

echo $output

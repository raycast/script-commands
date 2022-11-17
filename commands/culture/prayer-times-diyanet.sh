#!/bin/bash

# You may need to install coreutils via homebrew to make this script work (gdate function).
#
# Homebrew: https://brew.sh/
# Coreutils: https://formulae.brew.sh/formula/coreutils

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Prayer Times (Diyanet)
# @raycast.mode inline
# @raycast.packageName Culture

# Optional parameters:
# @raycast.icon 🕌

# Documentation
# @raycast.author Emircan Erkul
# @raycast.authorURL https://emircanerkul.com
# @raycast.description Prayer Times grabbed from the Diyanet's Official Website for people located in Türkiye.

data=$(curl -s https://namazvakitleri.diyanet.gov.tr/tr-TR/9654/kocaeli-icin-namaz-vakti)
 
imsak=$(echo "$data" | pcregrep -o1 '_imsakTime = "(.*)"')
gunes=$(echo "$data" | pcregrep -o1 '_gunesTime = "(.*)"')
ogle=$(echo "$data" | pcregrep -o1 '_ogleTime = "(.*)"')
ikindi=$(echo "$data" | pcregrep -o1 '_ikindiTime = "(.*)"')
aksam=$(echo "$data" | pcregrep -o1 '_aksamTime = "(.*)"')
yatsi=$(echo "$data" | pcregrep -o1 '_yatsiTime = "(.*)"')

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

echo $output | tr -d '\n' | LANG=tr_TR.UTF-8 pbcopy
echo $output

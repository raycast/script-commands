#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Prayer Times
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🕌
# @raycast.packageName Culture

# Documentation:
# @raycast.author Mortada Sarheed
# @raycast.authorURL https://github.com/mSarheed
# @raycast.description Shows islamic prayer times for you local city

#### Enter your own location to the variable 'location' location on line 19.
#### Go to the website https://prayertimes.date/ and see what location you can use on the website.

location='london'

data=$(curl -s https://prayertimes.date/$location | grep -E -o '.{0,10}Prayer times list for today.{0,200}')

imsak=$(echo "$data" | grep -E -o '.{6,7}Imsak{0,0}' | grep -o '^[^ ]*')
fajr=$(echo "$data" | grep -E -o '.{6,7}Fajr{0,0}' | grep -o '^[^ ]*')
dhuhr=$(echo "$data" | grep -E -o '.{6,7}Dhuhr{0,0}' | grep -o '^[^ ]*')
asr=$(echo "$data" | grep -E -o '.{6,7}Asr{0,0}' | grep -o '^[^ ]*')
maghrib=$(echo "$data" | grep -E -o '.{6,7}Maghrib{0,0}' | grep -o '^[^ ]*')
isha=$(echo "$data" | grep -E -o '.{6,7}Isha{0,0}' | grep -o '^[^ ]*')

location="$(tr '[:lower:]' '[:upper:]' <<< ${location:0:1})${location:1}"

echo '🕌 Prayer times for today in ' $location '🌎'
echo ''

echo '# Imsak #  # Fajr #  # Dhuhr #  # Asr #  # Maghrib #  # Isha #'
echo '  '$imsak '   ' $fajr '    ' $dhuhr '   ' $asr '    ' $maghrib '     ' $isha

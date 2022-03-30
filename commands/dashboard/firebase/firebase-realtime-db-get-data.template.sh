#!/bin/bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# !!! This script is only template, you can use it to write own script to get your data from Firebase Realtime Database !!!
# I'm using an Arduino ESP-32 as outside weather station and I'm storing the temperature, humidity and barometric pressure into Firebase Realtime Database.
# I wrote this script to see those values directly in Raycast. This script is changing the text color based on the Light/Dark mode.
# Check example folder to see the result of my script and my Firebase Realtime Database structure.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get data from Firebase
# @raycast.mode inline
# @raycast.refreshTime 10m
# @raycast.packageName Firebase

# Optional parameters:
# @raycast.icon images/firebase.png
#
# Documentation:
# @raycast.description Get values from Firebase Realtime Database
# @raycast.author Marek Mašek
# @raycast.authorURL https://github.com/marekmasek


# you can find API_KEY on "Project settings -> General" page in Firebase
WEB_API_KEY=""
# you need to create an user with email and password on "Authentication -> Users" page in Firebase
EMAIL=""
PASSWORD=""
# This is URL to your Realtime Database in Firebase, example of DB_URL: "https://${database-name}.${database-location}.firebasedatabase.app"
DB_URL=""

if ! jq --version download &> /dev/null; then
      echo "download jq is required (https://stedolan.github.io/jq/).";
      exit 1;
fi

# Generate access token
TOKEN=$(curl -s -H "Content-Type: application/json" -d '{"email": "'$EMAIL'", "password": "'$PASSWORD'", "returnSecureToken": true}' 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key='$WEB_API_KEY | jq -r '.idToken')

# Get data from Firebase Realtime Database
RESPONSE=$(curl -s $DB_URL'/.json?auth='$TOKEN)

# This script is changing color of the output text based on the light/dark mode activated in macOS
COLOR_MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
MAIN_COLOR="\u001b[97m"

if [ ${COLOR_MODE:-"Light"} == "Light" ]; then
MAIN_COLOR="\u001b[30m"
fi

# Get specific field values, round them and print the output
echo $RESPONSE | jq -r 'def colors:
 {
 "main": "'$MAIN_COLOR'",
 "reset": "\u001b[0m",
}; colors.reset + "Temp: " + colors.main + (.outside.temp*10.0|round/10.0|tostring) + " °C" + colors.reset +" Hum: " + colors.main + (.outside.humidity|round|tostring) + " %" + colors.reset + " BP: " + colors.main + (.outside.airPressure*10.0|round/10.0|tostring) + " hPa" + colors.reset + "     Room Temp: " + colors.main + (.inside.temp*10.0|round/10.0|tostring) + " °C"'

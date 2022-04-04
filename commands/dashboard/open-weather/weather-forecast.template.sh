#!/bin/bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Weather Forecast
# @raycast.mode inline
# @raycast.refreshTime 30m
# @raycast.packageName OpenWeather

# Optional parameters:
# @raycast.icon ⛅️
#
# Documentation:
# @raycast.description Get weather forecast from OpenWeather
# @raycast.author Marek Mašek
# @raycast.authorURL https://github.com/marekmasek

# you can generate API KEY here: https://home.openweathermap.org/api_keys
API_KEY=""
# city which will be used
CITY="prague"

if ! jq --version download &> /dev/null; then
      echo "download jq is required (https://stedolan.github.io/jq/).";
      exit 1;
fi

# Get location coordinates
LOCATION_INFO=$(curl -s 'https://photon.komoot.io/api/?lang=en&limit=1&q='$CITY)

LAT=$( jq -r  '.features[0].geometry.coordinates[1]' <<< "${LOCATION_INFO}" )
LON=$( jq -r  '.features[0].geometry.coordinates[0]' <<< "${LOCATION_INFO}" )

# Get weather forecast from OpenWeather
RESPONSE=$(curl -s 'https://api.openweathermap.org/data/2.5/onecall?lat='$LAT'&lon='$LON'&units=metric&appid='$API_KEY)

# This script is changing color of the output text based on the light/dark mode activated in macOS
COLOR_MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
MAIN_COLOR="\e[97m"
RESET_COLOR="\e[0m"

if [ ${COLOR_MODE:-"Light"} == "Light" ]; then
    MAIN_COLOR="\e[30m"
fi

# Build output string
OUTPUT_STRING=

for i in {0..3}
do
    WORKDAY=$( date -r $( jq -r  '.daily['$i'].dt' <<< "${RESPONSE}") +%a)
    TEMP_DAY=$( jq -r  '.daily['$i'].temp.day*10.0|round/10.0|tostring' <<< "${RESPONSE}" )
    TEMP_NIGHT=$( jq -r  '.daily['$i'].temp.night*10.0|round/10.0|tostring' <<< "${RESPONSE}" )
    
    OUTPUT_STRING="$OUTPUT_STRING $WORKDAY: $MAIN_COLOR$TEMP_DAY°$RESET_COLOR / $MAIN_COLOR$TEMP_NIGHT°$RESET_COLOR"
done

# Print output string
printf "$OUTPUT_STRING C"

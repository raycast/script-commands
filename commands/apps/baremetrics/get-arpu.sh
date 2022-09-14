#!/bin/bash

# You may need to install coreutils via homebrew to make this script work (gdate function below).

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Average Revenue Per User
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon images/baremetrics.png
# @raycast.packageName Baremetrics

# Documentation:
# @raycast.description Display Average revenue per user (ARPU)
# @raycast.author Valentin Chrétien
# @raycast.authorURL https://github.com/valentinchrt


# Configuration

# To create a new API token, do the following:
# 1. Go to Settings > API (https://app.baremetrics.com/settings/api)
# 2. Copy your Live API Key
# 3. Insert your API token below

API_TOKEN=''

DATE=`gdate -d yesterday '+%Y-%m-%d'`


# Main program

if [[ -z "$API_TOKEN" ]]
then 
  echo "No API token provided"
  exit 1
fi

ARPU_BEFORE=$(curl -s GET \
     --header 'Accept: application/json' \
     --header "Authorization: Bearer ${API_TOKEN}" \
     --url "https://api.baremetrics.com/v1/metrics/arpu?start_date=${DATE}&end_date=${DATE}" \
     | jq '.metrics[0].value')

ARPU=$(echo "$ARPU_BEFORE * 0.01" | bc -l)
printf "€%'.0f\n" $ARPU
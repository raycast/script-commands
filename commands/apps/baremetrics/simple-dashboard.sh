#!/bin/bash

# You may need to install coreutils via homebrew to make this script work (gdate function below).

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Revenue
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon images/baremetrics.png
# @raycast.packageName Baremetrics

# Documentation:
# @raycast.description Display Revenue Dashboard
# @raycast.author Valentin Chrétien
# @raycast.authorURL https://github.com/valentinchrt


# Configuration

# To create a new API token, do the following:
# 1. Go to Settings > API (https://app.baremetrics.com/settings/api)
# 2. Copy your Live API Key
# 3. Insert your API token below

API_TOKEN=''

DATE=`gdate -d today '+%Y-%m-%d'`


# Main program

if [[ -z "$API_TOKEN" ]]
then 
  echo "No API token provided"
  exit 1
fi

ROUGH_MRR=$(curl -s GET \
     --header 'Accept: application/json' \
     --header "Authorization: Bearer ${API_TOKEN}" \
     --url "https://api.baremetrics.com/v1/metrics/mrr?start_date=${DATE}&end_date=${DATE}" \
     | jq '.metrics[0].value')

CLEANED_MRR=$(echo "$ROUGH_MRR * 0.01" | bc -l)
MRR=$(printf "€%'.0f\n" $CLEANED_MRR)

ROUGH_ARR=$(curl -s GET \
     --header 'Accept: application/json' \
     --header "Authorization: Bearer ${API_TOKEN}" \
     --url "https://api.baremetrics.com/v1/metrics/arr?start_date=${DATE}&end_date=${DATE}" \
     | jq '.metrics[0].value')

CLEANED_ARR=$(echo "$ROUGH_ARR * 0.01" | bc -l)
ARR=$(printf "€%'.0f\n" $CLEANED_ARR)

ROUGH_LTV=$(curl -s GET \
     --header 'Accept: application/json' \
     --header "Authorization: Bearer ${API_TOKEN}" \
     --url "https://api.baremetrics.com/v1/metrics/ltv?start_date=${DATE}&end_date=${DATE}" \
     | jq '.metrics[0].value')

CLEANED_LTV=$(echo "$ROUGH_LTV * 0.01" | bc -l)
LTV=$(printf "€%'.0f\n" $CLEANED_LTV)

ROUGH_ARPU=$(curl -s GET \
     --header 'Accept: application/json' \
     --header "Authorization: Bearer ${API_TOKEN}" \
     --url "https://api.baremetrics.com/v1/metrics/arpu?start_date=${DATE}&end_date=${DATE}" \
     | jq '.metrics[0].value')

CLEANED_ARPU=$(echo "$ROUGH_ARPU * 0.01" | bc -l)
ARPU=$(printf "€%'.0f\n" $CLEANED_ARPU)

# Display Revenue Dashboard
echo "MRR: $MRR | ARR: $ARR | LTV: $LTV | ARPU: $ARPU"
#!/bin/bash

# Dependency: requires jq (https://stedolan.github.io/jq/)
# Install via Homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Metals Price
# @raycast.mode inline
# @raycast.refreshTime 1h
# @raycast.packageName Dashboard
#
# Documentation:
# @raycast.description Retrieves the value of precious metals per 1 oz
# @raycast.author Stefan de Graaf
# @raycast.authorURL https://github.com/DBZFYAM
# @raycast.icon images/precious-metals.png

if ! command -v jq &> /dev/null; then
	echo "jq is not installed. To install, run 'brew install jq' or visit https://stedolan.github.io/jq/";
	exit 1;
fi

# Configure the values below if needed. Specify the metals to retrieve and set the desired output currency
# NOTE: Not all metals/currencies are available in all output-currencies (For example: XPT and XPD are only available in USD)
metals=("XAG" "XAU" "XPT" "XPD")
metalsLabels=("Silver" "Gold" "Platinum" "Palladium")
currency="USD"

# Leave as is
endpoint="https://forex-data-feed.swissquote.com/public-quotes/bboquotes/instrument"
metalsLength=${#metals[@]}
output=""

for (( i=1; i<${metalsLength}+1; i++ ));
do
	url="${endpoint}/${metals[$i-1]}/$currency"
	data=$(curl --silent $url)
	response=$(echo "$data" | jq '.[0].spreadProfilePrices[] | select(.spreadProfile=="Standard") | .ask')
    
	if [[ $i -gt 1 ]]
	then
		output+=" - "
	fi
	output+="${metalsLabels[$i-1]}: $response"
done

echo $output
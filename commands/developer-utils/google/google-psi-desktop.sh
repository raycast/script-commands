#!/bin/bash

# Dependency: requires psi (https://github.com/GoogleChromeLabs/psi)
# Install via npm: `npm install -g psi`

# @raycast.schemaVersion 1
# @raycast.title PageSpeed Insights - Desktop
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Run a PageSpeed Insights analysis on desktop of URL.
# @raycast.packageName Google
# @raycast.icon images/google-psi-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "URL" }

if ! command -v psi &> /dev/null; then
	echo "psi is required (https://github.com/GoogleChromeLabs/psi).";
	exit 1;
fi

url=$1
regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $url =~ $regex ]]; then 
	analysis=$(psi $url --strategy=desktop 2>&1)
	
	if [ ${?} -eq 1 ]; then
		echo ""
		echo "There was an error; please try again later."
	else
		echo "$analysis"
	fi
	
	analysis_url="https://developers.google.com/speed/pagespeed/insights/?url=${url}&tab=desktop"
	
	echo ""
	echo "Desktop analysis URL:"
	echo "$analysis_url"
	
	exit 0
fi

echo "Input is not a valid URL."
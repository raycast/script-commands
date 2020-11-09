#!/bin/bash -l

# @raycast.schemaVersion 1
# @raycast.title PageSpeed Insights - Desktop
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Run a PageSpeed Insights analysis on desktop of URL in clipboard.
# @raycast.packageName Google
# @raycast.needsConfirmation true
# @raycast.icon images/google-psi-logo.png

if ! command -v psi &> /dev/null; then
	echo "psi is required (https://github.com/GoogleChromeLabs/psi).";
	exit 1;
fi

clipboard=$(pbpaste)
regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $clipboard =~ $regex ]]; then 
	psi $clipboard --strategy=desktop
	analysis_url="https://developers.google.com/speed/pagespeed/insights/?url=${clipboard}&tab=desktop"
	echo $analysis_url | pbcopy
	echo ""
	echo "Desktop analysis URL copied:"
	echo "$analysis_url"
	exit 0
fi

echo "Clipboard does not contain a URL."
#!/bin/bash

# How to use this script
# It's a template which needs some setup.
# 1. Duplicate the file,
# 2. remove `.template.` from the filename, and
# 3. replace <token> with your API token.
# Optionally, customize the script title, icon, and output.
#
# API docs:
# https://vercel.com/docs/api#endpoints/domains/check-a-domain-availability

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Check Domain
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "example.com" }
# @raycast.packageName Developer Utils

# @Documentation:
# @raycast.description Check the availability of a domain with the Vercel API.
# @raycast.author Ted Spare
# @raycast.authorURL https://y.at/🤘🐊🗿🚀


# Setup

# Indicate that the script has started
echo "Checking domain "$1"..."

# Vercel API base URL
API_URL="https://api.vercel.com/v4/domains/"

# Authorization header required for making requests
# <token> should be replaced with your token: https://vercel.com/account/tokens
AUTH_HEADER="Authorization: Bearer <token>"


# Main program

# Query the Vercel API for the availability of the domain
available=$(curl -s $API_URL"status?name="$1 -H "${AUTH_HEADER}")

# If the domain is available, check its price. If unavailable, tell the user.
# If there is an auth or other error, alert the user and throw an error.
case $available in
	*"true"*)
		price=$(curl -s $API_URL"price?name="$1 -H "${AUTH_HEADER}")
		# Alert the user if the TLD is invalid
		if [[ $price = *"tld"* ]]; then
			tld=$(echo $1 | cut -d '.' -f2)
			echo "Invalid TLD ."$tld
			exit 1
		fi
		# Extract the price from the JSON-formatted result
		price=${price%,*}
		price=${price##*:}
		echo $1" is available for $"$price"! 🤑"
		exit 0
		;;
	*"false"*)
		echo $1" is not available 😢"
		exit 0
		;;
	*"auth"*)
		echo "Please provide a valid API token"
		exit 1
		;;
	*)
		echo "Something went wrong"
		exit 1
		;;
esac

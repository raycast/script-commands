#!/usr/bin/env python3

# Raycast Script Command Template
#
# Dependency: This script requires Python 3
# Install Python 3: https://www.python.org/downloads/release
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title OctoPrint
# @raycast.mode fullOutput
# @raycast.packageName OctoPrint
#
# Optional parameters:
# @raycast.icon 🖨️
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation fals
#
# Documentation:
# @raycast.description Raycast script commands which returns the status of your OctoPrint intance
# @raycast.author Mortada Sarheed
# @raycast.authorURL https://github.com/mSarheed

try:
    import requests
except ImportError:
    print("requests package is required. Please install it using 'pip install requests'")
    exit(1)

# Define the OctoPrint server URL and API key
base_url = 'http://octopi.local/api/'
api_key = '[INSERT YOUR API KEY HERE]'

# Define the API endpoint for printer information
endpoint = 'printer'

# Build the full URL with API endpoint
url = f'{base_url}{endpoint}'

# Set the API headers with the provided API key
headers = {'X-Api-Key': api_key}

# Send a GET request to retrieve printer information
response = requests.get(url, headers=headers)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Extract the printer information from the response
    printer_info = response.json()
    # Print the retrieved printer information
    print(printer_info)
else:
    print('Error retrieving printer information!')
    print(response.text)
    print(response.status_code)

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

### SETUP INSTRUCTIONS ###
# 1. Install the requests package using 'pip install requests'
# 2. Go to your OctoPrint instance and generate an API key. Octoprint -> Settings -> Application Keys
# 3. Copy the generated API key and paste it in the api_key variable below.

try:
    import requests
except ImportError:
    print("The 'requests' package is required. Install it using 'pip install requests'")
    exit(1)

base_url = 'http://octopi.local/api/'
api_key = 'AFDF7D11A5C049EABB08ABF71BE5C252'

endpoint = 'printer'

url = f'{base_url}{endpoint}'

headers = {'X-Api-Key': api_key}

response = requests.get(url, headers=headers)

# Define some colors for the output
colors = {
  'green': '\033[92m',
  'yellow': '\033[93m',
  'red': '\033[91m',
  'grey': '\033[90m',
  'white': '\033[97m',
  'end': '\033[0m',
}

def green(declare, message):
    return f"{colors['white']}{declare}:{colors['end']} {colors['green']}{message}{colors['end']}"

def yellow(declare, message):
    return f"{colors['white']}{declare}:{colors['end']} {colors['yellow']}{message}{colors['end']}"

def red(declare, message):
    return f"{colors['white']}{declare}:{colors['end']} {colors['red']}{message}{colors['end']}"

def grey(declare, message):
    return f"{colors['white']}{declare}:{colors['end']} {colors['grey']}{message}{colors['end']}"

def white(declare, message):
    return f"{colors['white']}{declare}:{colors['end']} {colors['white']}{message}{colors['end']}"

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Extract the printer information from the response
    printer_info = response.json()
    state = printer_info['state']['text']
    a_tool_temp = printer_info['temperature']['tool0']['actual']
    a_tool_temp = str(a_tool_temp) + " °C"
    t_tool_temp = printer_info['temperature']['tool0']['target']
    t_tool_temp = str(t_tool_temp) + " °C"
    a_bed_temp = printer_info['temperature']['bed']['actual']
    a_bed_temp = str(a_bed_temp) + " °C"
    t_bed_temp = printer_info['temperature']['bed']['target']
    t_bed_temp = str(t_bed_temp) + " °C"

    if state == 'Printing':
        # Retrieve the job information
        endpoint = 'job'
        url = f'{base_url}{endpoint}'
        response = requests.get(url, headers=headers)
        job_info = response.json()
        job_name = job_info['job']['file']['name']
        job_progress = int(job_info['progress']['completion'])
        job_progress = str(job_progress) + "%"
        time_left = job_info['progress']['printTimeLeft'] // 60
        time_left = str(time_left) + " minutes left"

        print("OctoPrint Status 🖨️")
        print(20 * "-")
        print(green("➡️ " + "State", state) + " 💪")
        print(green("➡️ " + "Job Name", job_name) + " 📝")
        print(green("➡️ " + "Job Progress", job_progress) + " 📈")
        print(green("➡️ " + "Time Left", time_left) + " ⏳")
        print(green("➡️ " + "Tool Temp", a_tool_temp) + " -> " + red("Target Temp", t_tool_temp) + " 🔥")
        print(green("➡️ " + "Bed Temp", a_bed_temp)+ " -> " + red("Target Temp", t_bed_temp) + " 🔥")
        print(20 * "-")

    else:
        print("OctoPrint Status 🖨️")
        print(20 * "-")
        print(green("➡️ " + "State", state) + " 😴")
        print(green("➡️ " + "Tool Temp", a_tool_temp) + " -> " + red("Target Temp", t_tool_temp) + " 🔥")
        print(green("➡️ " + "Bed Temp", a_bed_temp)+ " -> " + red("Target Temp", t_bed_temp) + " 🔥")
        print(20 * "-")

elif response.status_code == 403:
    print('Your API key is invalid! Check your API key and try again.')
else:
    print('Error retrieving printer information! Check your OctoPrint instance url and try again.')

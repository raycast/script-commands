#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Light Bulb
# @raycast.mode compact
# @raycast.packageName Philips Hue

# Optional parameters:
# @raycast.icon 💡
# @raycast.argument1 { "type": "text", "placeholder": "preset", "optional": true}
# @raycast.argument2 { "type": "text", "placeholder": "value (hsb or brightness)", "optional": true}
# @raycast.argument3 { "type": "text", "placeholder": "bulb", "optional": true}

# Documentation:
# @raycast.description Set a chosen or default individual bulb to a preset, hsb or brightness value.
# @raycast.author Jono Hewitt
# @raycast.authorURL https://github.com/jonohewitt

# This script requires:

# Your Hue Bridge local IP address, e.g 192.168.1.2
# An authorised username, e.g 1028d66426293e821ecfd9ef1a0731df
# A light bulb ID, e.g 5

# Follow the steps here for the bridge IP and how to create a username:
# https://developers.meethue.com/develop/get-started-2/

# Then go to https://<bridge ip address>/api/<username>/lights to see the number ID associated with each hue bulb you've set up. Assign one of these numbers as the $defaultBulbID below, then add each other bulb to the bulb section down towards the end of the script.

# The script uses comma separated HSB, a.k.a HSV, (Hue: 0-360, Saturation: 0-100, Brightness: 0-100) for inputting colour information. If only one number is provided, it is assumed to be brightness (0-100)

# Remember to remove .template from the file name after you have add your details to the script.

hueBridgeIP="<enter bridge IP here>"
userID="<enter username here>"
defaultBulbID="<enter your chosen default bulb id here>"

declare on
declare hue
declare sat
declare bri
declare bulbID

### ASSIGN PRESETS HERE
### Some examples are included already

if [[ $1 ]]; then
    if [[ $1 == "on" ]]; then
        on=true

        # Decide if you'd like the "on" preset to return to their most recently set colour
        # or overwrite the last set colour and return to a default colour, e.g:

        # hue=45
        # sat=25
        # bri=100

    elif [[ $1 == "off" ]]; then
        on=false

    elif [[ $1 == "sunset" ]]; then
        on=true
        hue=15
        sat=100
        bri=20

    elif [[ $1 == "bright" ]]; then
        on=true
        hue=45
        sat=25
        bri=100

        # Add more presets here with additional elif statements, e.g:

    # elif [[ $1 == "<your arbitrary preset name>" ]]; then

        # on=true
        # hue=<your hue value: 0-360>
        # sat=<your saturation value: 0-100>
        # bri=<your brightness value: 0-100>

    else
        echo "Preset not found!"
        exit 1

    fi
fi

# --- End of Preset section --- #



# If an HSB argument is provided, this section tests and assigns the values from it
# This section doesn't require any additional configuration

if [[ $2 ]]; then

    # Test for HEX values mistakenly entered
    re='[a-z]|#'
    if [[ $2 =~ $re ]]; then
        echo "HEX values aren't supported!"
        exit 1
    fi

    # Test for decimal values
    re='\.'
    if [[ $2 =~ $re ]]; then
        echo "Decimals aren't supported!"
        exit 1
    fi

    # Split the comma separated HSB string into an array
    IFS=',' read -ra hsbArray <<<"$2"

    # Remove any non-numeric characters, e.g degree or percentage symbols
    index=0
    for i in "${hsbArray[@]}"; do
        hsbArray[index]=${i//[!0-9]/}
        ((index++))
    done

    # Test for out of bounds colour values
    testValue() {
        if [[ $1 -gt $2 ]]; then
            echo "Bad value input!"
            exit 1
        else
            echo $1
        fi
    }

    # If the array only has one entry, assign it to brightness
    if [[ ${#hsbArray[@]} == 1 ]]; then
        testValue ${hsbArray[0]} 100
        bri=${hsbArray[0]}
        on=true

    # Otherwise assign each entry as HSB values
    else
        testValue ${hsbArray[0]} 360
        testValue ${hsbArray[1]} 100
        testValue ${hsbArray[2]} 100
        hue=${hsbArray[0]}
        sat=${hsbArray[1]}
        bri=${hsbArray[2]}
        on=true
    fi
fi

# --- End of colour value section --- #



### CHOOSE BULB NAMES AND ASSIGN BULB IDs HERE 
### The $defaultBulbID will be used if no bulb argument is included in the Raycast command

bulbID=$defaultBulbID

if [[ $3 ]]; then

    if [[ $3 == "<enter chosen bulb name here>" ]]; then
        bulbID="<ID number from the hue API>"

    elif [[ $3 == "<another chosen bulb name>" ]]; then
        bulbID="<ID number from the hue API>"

    # Add more bulbs here with additional elif statements, e.g:

    # elif [[ $3 == "main" ]]; then
        #bulbID="5"

    else
        echo "Bulb not found!"
        exit 1
    fi
fi

# --- End of bulb section --- #



generateData() {
    # If there is colour information, convert the colour model and include it in the data
    if [[ $hue ]]; then
        cat <<EOF
{
	"on":$on,
    "hue":$(($hue * 65535 / 360 | bc)),
    "sat":$(($sat * 254 / 100 | bc)),
    "bri":$(($bri * 254 / 100 | bc))
}
EOF
    # If there is only brightness information, update it without overwriting the existing colour data
    elif [[ $bri ]]; then
        cat <<EOF
{
	"on":$on,
    "bri":$(($bri * 254 / 100 | bc))
}
EOF
    # Otherwise only change the "on" state without overwriting the existing colour data
    else
        cat <<EOF
{
	"on":$on
}
EOF
    fi
}

curl --show-error --silent --output /dev/null $hueBridgeIP/api/$userID/lights/$bulbID/state \
    --request PUT \
    --header "Content-Type: application/json" \
    --data "$(generateData)"

echo "Light bulb changed!"

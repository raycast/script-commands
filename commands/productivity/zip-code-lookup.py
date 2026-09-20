#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Zip Code Lookup
# @raycast.mode fullOutput
# @raycast.description Looks up ZIP codes in the USA

# Optional parameters:
# @raycast.icon 📍

# Documentation:
# @raycast.author Kailash Yellareddy
# @raycast.authorURL https://github.com/kyellareddy
# @raycast.argument1 { "type": "text", "placeholder": "ZIP code", "optional": false }

from uszipcode import SearchEngine
import sys
import us


engine = SearchEngine()
zipcode = engine.by_zipcode(sys.argv[1])

input = sys.argv[1]

military_states = {
    "AE": "Armed Forces Europe",
    "AP": "Armed Forces Pacific",
    "AA": "Armed Forces Americas"
}
military_cities = {
    "APO": "Army/Air Force Post Office",
    "FPO": "Fleet Post Office",
    "DPO": "Diplomatic Post Office"
}
if zipcode and zipcode.zipcode:
    state = zipcode.state
    city = zipcode.major_city

    print(f"\033[31m{input}\033[0m")

    print()

    if city in military_cities:
        print(military_cities[city])
    else:
        print("City:", city)

    if zipcode.county:
        print("County:", zipcode.county)

    if state in military_states:
        print(military_states[state])
    else:
        state_name = us.states.lookup(state).name
        print("State:", state_name)
else:
    print("Zip code not found.")

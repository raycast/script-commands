#!/bin/bash

# @raycast.title Domain to IP
# @raycast.author Per Nielsen Tikær
# @raycast.authorURL https://github.com/pernielsentikaer
# @raycast.description Get the IP of a given domain

# @raycast.icon 🌐
# @raycast.mode compact
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Domain" }

json=$(dig +short "$1")
echo "${json}"
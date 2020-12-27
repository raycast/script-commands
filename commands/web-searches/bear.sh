#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @description Replace your owe token:https://bear.app/faq/X-callback-url%20Scheme%20documentation/#token-generation
# @raycast.schemaVersion 1
# @raycast.title Bear
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/bear.png
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder","percentEncoded": true}

open "bear://x-callback-url/search?term=$1&show_window=yes&token=979709-0C37A6-F84D4D"
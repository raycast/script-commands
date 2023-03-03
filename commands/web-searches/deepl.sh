#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DeepL
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/deepl.png
# @raycast.argument1 { "type": "text", "placeholder": "From", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "To", "percentEncoded": true }
# @raycast.argument3 { "type": "text", "placeholder": "Text", "percentEncoded": true }
# @raycast.packageName Translations

# Documentation:
# @raycast.description Open DeepL
# @raycast.author Luka Harambasic
# @raycast.authorURL https://harambasic.de

# From & to are the typical language codes, like en, de, da etc.
open "https://www.deepl.com/translator#/$1/$2/$3"

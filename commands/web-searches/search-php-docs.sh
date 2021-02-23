#!/bin/bash

# @raycast.title Search PHP Docs
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search [PHP official documentation](https://www.php.net/docs.php).

# @raycast.icon images/php-logo.png
# @raycast.iconDark images/php-logo-iconDark.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }

open "https://www.php.net/manual-lookup.php?pattern=${1}&scope=quickref"
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title BNF Search
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💊
# @raycast.packageName Medical
# @raycast.argument1 { "type": "dropdown", "placeholder": "Source", "data": [{"title": "BNF (Adults)", "value": "bnf"}, {"title": "BNFC (Children)", "value": "bnfc"}] }
# @raycast.argument2 { "type": "text", "placeholder": "Medication (e.g. Paracetamol)" }

# Documentation:
# @raycast.description Search the British National Formulary (BNF) or BNFC directly.
# @raycast.author Jack Smith
# @raycast.authorURL https://github.com/myusualonewastaken

SOURCE="$1"
INPUT="$2"

if [ "$SOURCE" == "bnfc" ]; then
    BASE_DOMAIN="bnfc.nice.org.uk"
else
    BASE_DOMAIN="bnf.nice.org.uk"
fi

# Clean up input: Lowercase, replace spaces with dashes
SLUG=$(echo "$INPUT" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

DIRECT_URL="https://$BASE_DOMAIN/drugs/$SLUG/"
SEARCH_URL="https://$BASE_DOMAIN/search?q=$INPUT"

# Check URL with a fake User-Agent to avoid being blocked
# -o /dev/null: Ignore the page content
# --silent: Don't show loading bars
# --head: Only check the headers
# --write-out '%{http_code}': Tell us the status code (e.g., 200 or 404)
STATUS=$(curl -o /dev/null --silent --head --write-out '%{http_code}' -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)" "$DIRECT_URL")

# If the status is 200 (OK), open the direct page. Otherwise, search.
if [ "$STATUS" -eq 200 ]; then
  open "$DIRECT_URL"
else
  open "$SEARCH_URL"
fi

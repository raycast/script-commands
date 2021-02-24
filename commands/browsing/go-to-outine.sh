#!/bin/bash

# @raycast.author Ronan Rodrigo Nunes
# @raycast.authorURL https://ronanrodrigo.dev
# @raycast.packageName Browsing
# @raycast.schemaVersion 1
# @raycast.title Go to Outline
# @raycast.description Open the website at Outline
# @raycast.mode compact
# @raycast.argument1 { "type": "text", "placeholder": "URL" }
# @raycast.icon images/outline.png

address=$1

if ! command -v jq &> /dev/null; then
    echo "Please, install jq: brew install jq"
    exit 1
fi

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if ! [[ $address =~ $regex ]] ; then
  echo "Invalid URL"
  exit 1
fi

function outline_request() {
    curl -s "https://api.outline.com/v3/parse_article?source_url=${address}"\
         -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:84.0) Gecko/20100101 Firefox/84.0'\
         -H 'Accept: */*'\
         -H 'Accept-Language: pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3' --compressed\
         -H 'Origin: https://outline.com'\
         -H 'DNT: 1' -H 'Connection: keep-alive'\
         -H 'Referer: https://outline.com/'\
         -H 'Sec-GPC: 1'
}
short_code=$(outline_request | jq -r '.data.short_code')
open "https://outline.com/${short_code}"

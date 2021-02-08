#!/bin/bash

##################################################
### Enter zone ID, email address, and API key. ###
##################################################

cf_zone_id=''
cf_email_address=''
cf_api_key=''

# @raycast.title Purge Cloudflare cache
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Purge Cloudflare cache for zone.

# @raycast.icon images/cloudflare-logo.png
# @raycast.mode silent
# @raycast.packageName Developer Utilities
# @raycast.schemaVersion 1

if [ -z ${cf_zone_id+x} ]; then
	echo "Zone ID is missing.";
	exit 1;
fi

if [ -z ${cf_email_address+x} ]; then
	echo "Email address is missing.";
	exit 1;
fi

if [ -z ${cf_api_key+x} ]; then
	echo "API key is missing.";
	exit 1;
fi

curl -X POST "https://api.cloudflare.com/client/v4/zones/${cf_zone_id}/purge_cache" \
     -H "X-Auth-Email: $cf_email_address" \
     -H "X-Auth-Key: $cf_api_key" \
     -H "Content-Type: application/json" \
     --data '{"purge_everything":true}'

echo "Purged cache"
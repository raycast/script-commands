#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search OpenSecrets.org
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Web Searches
# @raycast.icon images/opensecrets.png
# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Type (default: donor)", "optional": true, "percentEncoded": true }
# @raycast.author Daniel Sieradski
# @raycast.authorURL https://github.com/selfagency

case $(tr "[:upper:]" "[:lower:]" <<<$2) in
"" | "d" | "donor" | "donors")
  searchtype="donors"
  ;;
"p" | "pol" | "pols" | "politician" | "politicians" | "l" | "lob" | "lobbyist" | "lobbyists")
  searchtype="indiv"
  ;;
"o" | "org" | "orgs" | "organization" | "organizations")
  searchtype="orgs"
  ;;
"n" | "news")
  searchtype="news"
  ;;
"s" | "site")
  searchtype="site"
  ;;
*)
  searchtype=$2
  ;;
esac

open "https://www.opensecrets.org/search?q=$1&type=$searchtype"

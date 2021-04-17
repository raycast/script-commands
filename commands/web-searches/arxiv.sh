#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Search in arXiv
# @raycast.mode silent
#
# @raycast.packageName Web Searches
# @raycast.icon images/arxiv.png
#
# @raycast.author Marco Varisco
# @raycast.authorURL https://github.com/mava
#
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "all/title/auth… (default: all)", "optional": true, "percentEncoded": true }

archive="" # Leave empty to search in all archives, or use one of the available archives:
#   physics astro-ph cond-mat gr-qc hep-ex hep-lat hep-ph hep-th math-ph nlin nucl-ex nucl-th quant-ph
#   cs econ eess math q-bio q-fin stat
# For example, uncomment the following line to search only in archive math:
# archive="math"

case $(tr "[:upper:]" "[:lower:]" <<< $2) in
  ""|"al"|"all")
    searchtype="all"
    ;;
  "ti"|"tit"|"titl"|"title"|"titles")
    searchtype="title"
    ;;
  "au"|"aut"|"auth"|"autho"|"author"|"authors")
    searchtype="author"
    ;;
  "ab"|"abs"|"abst"|"abstr"|"abstra"|"abstrac"|"abstract"|"abstracts")
    searchtype="abstract"
    ;;
  "co"|"com"|"comm"|"comme"|"commen"|"comment"|"comments")
    searchtype="comments"
    ;;
  *)
    searchtype=$2
    ;;
esac

open "https://arxiv.org/search/$archive?query=$1&searchtype=$searchtype"

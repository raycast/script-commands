#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Find Paper
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📖
# @raycast.packageName DOI

# Documentation:
# @raycast.description Scans clipboard and opens DOI links in your browser
# @raycast.author Razvan Azamfirei
# @raycast.authorURL https://github.com/razvanazamfirei
LINK="$(pbpaste)"
REGEX="^doi: 10."
if [[ "$LINK" =~ ^doi:10. ]]; then
    IN="$LINK"
    arrIN=("${IN//doi:/}")
    URL="https://doi.org/${arrIN[0]}"
    open "$URL"
elif [[ "$LINK" =~ ^doi/10. ]]; then
    IN="$LINK"
    arrIN=("${IN//doi///}")
    URL="https://doi.org/${arrIN[0]}"
    open "$URL"
elif [[ "$LINK" =~ ${REGEX} ]]; then
    IN="$LINK"
    arrIN=("${IN//doi: //}")
    URL="https://doi.org/${arrIN[0]}"
    open "$URL"
elif [[ "$LINK" =~ ^10. ]]; then
    URL="https://doi.org/${LINK}"
    open "$URL"
else
    echo "Please specify a DOI"
    exit 1
fi

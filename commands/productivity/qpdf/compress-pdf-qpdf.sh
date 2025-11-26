#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Komprimer PDF (Kvalitet i navn)
# @raycast.mode compact
# @raycast.packageName PDF Tools

# Optional parameters:
# @raycast.icon 📉
# @raycast.argument1 { "type": "text", "placeholder": "Kvalitet (0-100, default: 50)", "optional": true }

# Documentation:
# @raycast.description Komprimerer og skriver valgt kvalitet i filnavnet
# @raycast.author DitNavn

# 1. Konfiguration
QUALITY="${1:-50}"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Tjek for qpdf
if ! command -v qpdf &> /dev/null; then
    echo "Fejl: qpdf kan ikke findes."
    exit 1
fi

# 2. Hent filer
SELECTED_FILES=$(osascript <<EOD
tell application "Finder"
    set theSelection to selection
    if theSelection is {} then
        return ""
    end if
    set output to ""
    repeat with theItem in theSelection
        set output to output & POSIX path of (theItem as alias) & "\n"
    end repeat
    return output
end tell
EOD
)

if [ -z "$SELECTED_FILES" ]; then
    echo "Ingen filer valgt i Finder"
    exit 1
fi

IFS=$'\n'
count=0
last_output=""

# 3. Loop og komprimer
for f in $SELECTED_FILES; do
    if [[ "$f" != *.pdf && "$f" != *.PDF ]]; then
        continue
    fi

    filename=$(basename "$f")
    echo "Behandler: $filename ($QUALITY%)..."

    dir=$(dirname "$f")
    base_filename=$(basename "$f" .pdf)
    
    # HER ER ÆNDRINGEN:
    # Filnavnet bruger nu din valgte QUALITY-værdi
    # F.eks.: MinFil_10%.pdf
    output="$dir/${base_filename}_${QUALITY}%.pdf"

    # Kør qpdf
    qpdf --compress-streams=y \
         --recompress-flate \
         --decode-level=generalized \
         --compression-level=9 \
         --optimize-images \
         --jpeg-quality="$QUALITY" \
         --object-streams=generate \
         "$f" "$output"
    
    if [ $? -eq 0 ]; then
        ((count++))
        last_output="$output"
    else
        echo "Fejl ved fil: $filename"
        sleep 2
    fi
done

# 4. Vis resultat
if [ $count -eq 0 ]; then
    echo "Ingen filer blev oprettet."
    exit 1
else
    # Vis den sidst oprettede fil i Finder
    if [ -n "$last_output" ]; then
        open -R "$last_output"
    fi
    echo "Færdig! Filen hedder nu ..._${QUALITY}%.pdf"
fi
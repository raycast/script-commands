#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Import Kit Scripts
# @raycast.mode fullOutput
# @raycast.packageName Kit

# Optional parameters:
# @raycast.icon ./img/kit_logo.png

# Documentation:
# @raycast.description Convert all scripts defined in ~/.kenv/scripts to raycast scripts
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

function getMetadata {
    FILE=$1
    FIELD=$2
    grep -E "^// $FIELD" "$FILE" | awk -F': ' '{print $2}'
}

kit=$HOME/.kit/bin/kit
if [ ! -f "$kit" ]; then
    echo "Please install kit from https://simplescripts.dev/" > /dev/stderr
    exit 1
fi

# Create binaries for all kit scripts
$kit create-all-bins

# Clean previously generated scripts
rm kit_scripts/*.sh

for script_path in "$HOME"/.kenv/scripts/*; do
    script_name=$(basename "$script_path" .js)
    output_path=kit_scripts/$script_name.sh
    title=$(getMetadata "$script_path" Menu)
    description=$(getMetadata "$script_path" Description)

    {
        echo "#!/usr/bin/env sh"
        echo "# @raycast.schemaVersion 1"
        echo "# @raycast.mode silent"
        echo "# @raycast.packageName Kit"
        echo "# @raycast.icon ../img/kit_logo.png"
    } > "$output_path"
    if [ -n "$title" ]; then
        echo "# @raycast.title $title" >> "$output_path"
    else
        echo "# @raycast.title $script_name" >> "$output_path"
    fi
    if [ -n "$description" ]; then
        echo "# @raycast.description $description" >> "$output_path"
    fi
    echo "$HOME/.kit/bin/sk $script_name >/dev/null 2>&1" >> "$output_path"

    echo "Script $script_name sucessfully imported"
done

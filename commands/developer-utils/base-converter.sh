#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Base Converter
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utilities
# @raycast.author Saimir S.
# @raycast.authorURL https://www.saimirsulaj.com
# @raycast.description Utility to convert numbers between bases. Can be one number or a list of string-delimited numbers.
# @raycast.argument1 { "type": "text", "placeholder": "from base", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "to base", "optional": false }
# @raycast.argument3 { "type": "text", "placeholder": "value", "optional": false }


num_re='^[0-9]+$'
input_base=$1;
output_base=$2;

if [ -z "$input_base" ]; then
  echo "Error: \"from base\" must be defined";
  exit 1;
fi
if ! [[ $input_base =~ $num_re ]] ; then
   echo "Error: Input base must be a number" >&2;
   exit 1;
fi

if [ -z "$output_base" ]; then
  echo "Error: \"to base\" must be defined";
  exit 1;
fi
if ! [[ $output_base =~ $num_re ]] ; then
   echo "Error: Output base must be a number" >&2;
   exit 1;
fi

if [ -z "$3" ]; then
  echo "Error: \"value\" must be defined";
  exit 1;
fi

# Output base has to be expressed in the base of the input base.
output_base_cov=$(echo "ibase=10; obase=$input_base; $output_base" | bc);

output="";
for num in $3; do
  if ! [[ $num =~ $num_re ]] ; then
     echo "Error: \"$num\" is not a number" >&2;
     exit 1;
  fi
  num_cov=$(echo "ibase=$input_base; obase=$output_base_cov; $num" | bc);
  output="$output $num_cov";
done

# Trim whitespace
output="${output##}";

echo "$output";
echo "$output" | pbcopy;

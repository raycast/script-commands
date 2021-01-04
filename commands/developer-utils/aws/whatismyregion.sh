#!/bin/bash

# Dependency: requires curl (https://curl.se/)
# Install via homebrew: `brew install curl`

# Dependency: requires jq (https://stedolan.github.io/jq/)
# Install via homebrew: `brew install jq`

# Dependency: requires grepcidr (http://www.pc-tools.net/unix/grepcidr/)
# Install via homebrew: `brew install grepcidr`

# @raycast.schemaVersion 1
# @raycast.author Oğuzhan Yılmaz
# @raycast.authorURL https://github.com/c1982
# @raycast.title Find AWS Region by IP
# @raycast.mode fullOutput
# @raycast.packageName Developer Utilities
# @raycast.icon 🤖
# @raycast.description Copies the AWS IPv4 to the clipboard.

IPADDR=$(pbpaste)
IPRANGEFILE="${PWD}/ip-ranges.json"

download_ipranges_file(){
    curl -o $IPRANGEFILE https://ip-ranges.amazonaws.com/ip-ranges.json
}

check_file_existence(){
    if [ ! -f "$IPRANGEFILE" ]; then
        echo "$IPRANGEFILE does not exists. Downloading..."
        download_ipranges_file
    fi
}

check_file_older_than_7days(){
    if test `find "$IPRANGEFILE" -cmin +10080`
    then
        echo "$IPRANGEFILE file too old. Downloading..."
        download_ipranges_file
    fi
}

find_aws_prefix(){
    for range in $AWS_RANGES; do
       prefix=$(grepcidr "$range" <(echo "$IPADDR") >/dev/null && echo "$range")
       if [[ ! -z $prefix ]]; then
            echo $prefix
            exit
        fi
    done
}

check_requirements(){
    if [ -z $(which grepcidr) ]; 
    then
        echo "grepcidr not installed"
        exit
    fi

    if [ -z $(which curl) ]; 
    then
        echo "curl not installed"
        exit
    fi

    if [ -z $(which jq) ]; 
    then
        echo "jq not installed"
        exit
    fi
}

check_valid_ipv4(){
    if [[ ! $IPADDR =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Couldn't read valid IPv4 address from clipboard"
        exit
    fi
}

check_requirements
check_file_existence
check_file_older_than_7days
check_valid_ipv4

AWS_RANGES=$(cat $IPRANGEFILE | jq -r '.prefixes[] | select(.service=="EC2") | select(.ip_prefix) | .ip_prefix')
PREFIX=$(find_aws_prefix)
if [[ -z $PREFIX ]]; then
    echo "$IPADDR is not in AWS range"
    exit
fi

SHOW_RANGE=$(cat $IPRANGEFILE | jq '.prefixes[] | select(.service=="EC2" and .ip_prefix=="'$PREFIX'")')
echo $SHOW_RANGE | jq --arg ip $IPADDR '. + {"ip":"'$IPADDR'"}'

#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title S3 Download
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon images/amazon-s3.png
# @raycast.packageName AWS

# Documentation:
# @raycast.description Download from Amazon S3 via URL
# @raycast.argument1 { "type": "text", "placeholder": "S3 URL" }
# @raycast.author Chris Cook
# @raycast.authorURL https://github.com/zirkelc

URL=$1

# Ensure AWS CLI is installed
if ! command -v aws &> /dev/null; then
	echo "AWS CLI not found. Please install AWS CLI."
	echo "Installation instructions: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html"
	exit 1
fi

# Try matching different S3 URL patterns
# https://dev.to/aws-builders/format-and-parse-amazon-s3-url-5e10
if [[ $URL =~ ^https?://s3\.([a-z0-9-]+)\.amazonaws\.com/([^/]+)/(.*)$ ]]; then
    # Regional hostname with path-style
		BUCKET="${BASH_REMATCH[2]}"
		KEY="${BASH_REMATCH[3]}"
elif [[ $URL =~ ^https?://([^/]+)\.s3\.([a-z0-9-]+)\.amazonaws\.com/(.*)$ ]]; then
    # Regional hostname with virtual-hosted-style
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[3]}"
elif [[ $URL =~ ^https?://s3\.amazonaws\.com/([^/]+)/(.*)$ ]]; then
    # Legacy hostname with path-style
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[2]}"
elif [[ $URL =~ ^https?://([^/]+)\.s3\.amazonaws\.com/(.*)$ ]]; then
    # Legacy hostname with virtual-hosted-style
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[2]}"
elif [[ $URL =~ ^s3://([^/]+)/(.*)$ ]]; then
    # S3 URI
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[2]}"		
else
    echo "Invalid URL: $URL"
    echo "URL must match recognized S3 patterns."
    exit 1
fi

# Check for empty bucket or key
if [[ -z "$BUCKET" || -z "$KEY" ]]; then
    echo "Error extracting bucket and key from URL: $URL"
    exit 1
fi

# Remove trailing slash if present and set recursive download flag
RECURSIVE=""
if [[ "$KEY" =~ .*/$ ]]; then
	KEY="${KEY%/}"  # Remove trailing slash for directory key
	RECURSIVE="--recursive"
fi

# Set download path
DOWNLOAD_FOLDER="$HOME/Downloads"
DOWNLOAD_PATH="$DOWNLOAD_FOLDER/$KEY"

if [[ -n "$RECURSIVE" ]]; then
	echo "Downloading directory $URL to $DOWNLOAD_PATH..."
else
	echo "Downloading file $URL to $DOWNLOAD_PATH..."
fi

# Print bucket and key
echo "Bucket: $BUCKET"
echo "Key: $KEY"

# Use recursive if necessary
if aws s3 cp "s3://$BUCKET/$KEY" "$DOWNLOAD_PATH" $RECURSIVE; then
	echo "Downloaded successfully."
	open "$DOWNLOAD_FOLDER"
else
	echo "Download failed."
	exit 1
fi

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
# @raycast.argument1 { "type": "text", "placeholder": "s3://bucket/key" }
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
if [[ $URL =~ ^https?://s3\.([a-z0-9-]+)\.amazonaws\.com/([^/]+)(/(.*))?$ ]]; then
    # Regional hostname with path-style
		# Example: https://s3.us-east-1.amazonaws.com/bucket/key
		BUCKET="${BASH_REMATCH[2]}"
		KEY="${BASH_REMATCH[4]}"
elif [[ $URL =~ ^https?://([^/]+)\.s3\.([a-z0-9-]+)\.amazonaws\.com(/(.*))?$ ]]; then
    # Regional hostname with virtual-hosted-style
		# Example: https://bucket.s3.us-east-1.amazonaws.com/key
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[4]}"
elif [[ $URL =~ ^https?://s3\.amazonaws\.com/([^/]+)(/(.*))?$ ]]; then
    # Legacy hostname with path-style
		# Example: https://s3.amazonaws.com/bucket/key
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[3]}"
elif [[ $URL =~ ^https?://([^/]+)\.s3\.amazonaws\.com(/(.*))?$ ]]; then
    # Legacy hostname with virtual-hosted-style
		# Example: https://bucket.s3.amazonaws.com/key
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[3]}"
elif [[ $URL =~ ^s3://([^/]+)(/(.*))?$ ]]; then
    # S3 URI
		# Example: s3://bucket/key
		BUCKET="${BASH_REMATCH[1]}"
		KEY="${BASH_REMATCH[3]}"
else
    echo "Invalid URL: $URL"
    echo "URL must match recognized S3 patterns."
    echo "Patterns:"
    echo "- Global S3 URI: s3://bucket/key"
    echo "- Regional Path-Style URL: https://s3.region.amazonaws.com/bucket/key"
    echo "- Regional Virtual-Hosted-Style URL: https://bucket.s3.region.amazonaws.com/key"
    echo "- Legacy Path-Style URL: https://s3.amazonaws.com/bucket/key"
    echo "- Legacy Virtual-Hosted-Style URL: https://bucket.s3.amazonaws.com/key"
    exit 1
fi

# Trim leading slash from KEY if present
KEY="${KEY#/}"

# Check for empty bucket
if [[ -z "$BUCKET" ]]; then
    echo "Error extracting bucket from URL: $URL"
    exit 1
fi

DOWNLOAD_FOLDER="$HOME/Downloads"

# Ensure download folder exists
if [ ! -d "$DOWNLOAD_FOLDER" ]; then
    echo "Download folder does not exist"
    exit 1
fi

# Print bucket and key
echo "Bucket: $BUCKET"
echo "Key: ${KEY:-<entire bucket>}"
echo "Download: $DOWNLOAD_FOLDER"
echo ""

if [ -z "$KEY" ]; then
    # No key provided, download entire bucket
    DOWNLOAD_PATH="$DOWNLOAD_FOLDER/$BUCKET"
    echo "Downloading entire bucket s3://$BUCKET to $DOWNLOAD_PATH..."
    RECURSIVE="--recursive"
else
    # Check if the key ends with a slash, indicating it's likely a directory
    if [[ "$KEY" == */ ]]; then
        DOWNLOAD_PATH="$DOWNLOAD_FOLDER/$BUCKET/$KEY"
        echo "Downloading directory s3://$BUCKET/$KEY to $DOWNLOAD_PATH..."
        RECURSIVE="--recursive"
    else
        # Check if the object exists as a file
        if aws s3api head-object --bucket "$BUCKET" --key "$KEY" &>/dev/null; then
            # It's a file
            FILENAME=$(basename "$KEY")
            DOWNLOAD_PATH="$DOWNLOAD_FOLDER/$FILENAME"
            echo "Downloading file s3://$BUCKET/$KEY to $DOWNLOAD_PATH..."
            RECURSIVE=""
        else
            # It might be a directory without a trailing slash or it doesn't exist
            # Try to list objects with this prefix
            if aws s3api list-objects-v2 --bucket "$BUCKET" --prefix "$KEY/" --max-items 1 --query 'Contents[0].Key' --output text &>/dev/null; then
                # It's a directory
                DOWNLOAD_PATH="$DOWNLOAD_FOLDER/$BUCKET/$KEY"
                echo "Downloading directory s3://$BUCKET/$KEY to $DOWNLOAD_PATH..."
                RECURSIVE="--recursive"
            else
                echo "Error: No file or directory found at s3://$BUCKET/$KEY"
                exit 1
            fi
        fi
    fi
fi

# Perform the download
if aws s3 cp "s3://$BUCKET/${KEY:+$KEY}" "$DOWNLOAD_PATH" $RECURSIVE; then
    echo "Downloaded successfully."
    if [[ -n "$RECURSIVE" ]]; then
        open "$DOWNLOAD_FOLDER/$BUCKET"
    else
        open "$DOWNLOAD_FOLDER"
    fi
else
    echo "Download failed. Error code: $?"
    exit 1
fi

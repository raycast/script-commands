#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clone Repository with Auto-numbering
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🐙
# @raycast.argument1 { "type": "text", "placeholder": "GitHub URL or org/repo" }
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Clone GitHub repository to ~/git/github.com/(org)/(repo) with automatic numbering for duplicates
# @raycast.author tonkotsuboy
# @raycast.authorURL https://github.com/tonkotsuboy

set -euo pipefail

# Configuration: Base directory for cloning repositories
# Can be overridden by setting GITHUB_CLONE_BASE_DIR environment variable
CLONE_BASE="${GITHUB_CLONE_BASE_DIR:-$HOME/git/github.com}"

# Check for required argument
if [ -z "${1:-}" ]; then
  echo "❌ Error: Repository URL or org/repo required"
  echo ""
  echo "Usage examples:"
  echo "  Clone Repository with Auto-numbering https://github.com/raycast/script-commands"
  echo "  Clone Repository with Auto-numbering raycast/extensions"
  exit 1
fi

REPO_INPUT="$1"

# Extract org/repo from GitHub URL or use direct org/repo format
if [[ "$REPO_INPUT" =~ ^https?://github\.com/([^/]+)/([^/]+)(\.git)?$ ]]; then
  ORG="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
elif [[ "$REPO_INPUT" =~ ^([^/]+)/([^/]+)$ ]]; then
  ORG="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
else
  echo "❌ Error: Invalid repository format"
  echo ""
  echo "Expected formats:"
  echo "  - https://github.com/org/repo"
  echo "  - org/repo"
  exit 1
fi

# Remove .git suffix if present
REPO="${REPO%.git}"

# Determine target directory
BASE_DIR="${CLONE_BASE}/${ORG}"
TARGET_DIR="${BASE_DIR}/${REPO}"

# Check for existing directory and find next available number
if [ -d "$TARGET_DIR" ]; then
  echo "⚠️  Directory already exists: $TARGET_DIR"
  echo "🔍 Finding next available number..."

  COUNTER=2
  while [ -d "${TARGET_DIR}-${COUNTER}" ]; do
    COUNTER=$((COUNTER + 1))
  done

  TARGET_DIR="${TARGET_DIR}-${COUNTER}"
  echo "✅ Using: $TARGET_DIR"
fi

# Create organization directory
echo ""
echo "📁 Creating organization directory..."
mkdir -p "$BASE_DIR"

# Clone repository
echo ""
echo "🚀 Cloning repository..."
echo "   From: https://github.com/${ORG}/${REPO}"
echo "   To:   $TARGET_DIR"
echo ""

if git clone "https://github.com/${ORG}/${REPO}" "$TARGET_DIR"; then
  echo ""
  echo "✅ Clone successful!"
  echo ""
  echo "📂 Location: $TARGET_DIR"
  echo ""
  echo "💡 Next steps:"
  echo "   cd $TARGET_DIR"
else
  echo ""
  echo "❌ Clone failed"
  exit 1
fi

#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "📦 pi-ghostty publish"
echo ""

# Check npm login
if ! npm whoami &>/dev/null; then
  echo "Not logged in to npm. Running npm login..."
  npm login
fi

echo "Logged in as: $(npm whoami)"
echo ""

# Show what will be published
echo "Package contents:"
npm pack --dry-run 2>&1 | grep "npm notice"
echo ""

# Confirm
read -p "Publish pi-ghostty@$(node -p "require('./package.json').version")? [y/N] " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  npm publish --access public
  echo ""
  echo "✅ Published! Install with: pi install npm:pi-ghostty"
else
  echo "Cancelled."
fi

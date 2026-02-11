#!/bin/bash
set -e

# Configure git safe directory for the mounted workspace
git config --global --add safe.directory /workspace

# Check if the user is already logged in to Claude
if ! claude auth status >/dev/null 2>&1; then
    echo "============================================"
    echo "  You are not logged in to Claude."
    echo "  Starting login — a URL will be displayed."
    echo "  Open it in your browser to authenticate."
    echo "============================================"
    echo ""
    claude login
fi

exec "$@"

#!/bin/bash
set -e

# Configure git safe directory for the mounted workspace
git config --global --add safe.directory /workspace

# If ANTHROPIC_API_KEY is not set, remind the user
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "WARNING: ANTHROPIC_API_KEY is not set."
    echo "Set it via: export ANTHROPIC_API_KEY=your-key"
    echo "Or add it to your .env file."
    echo ""
fi

exec "$@"

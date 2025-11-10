#!/bin/bash
set -e

# Set default values if not provided
SERVER_NAME="${SERVER_NAME:-MelbourneVanilla}"
MAP="${MAP:-Washington}"
GSLT="${GSLT:-}"

# Build command
CMD="./Unturned_Headless.x86_64 -nographics -batchmode +InternetServer/$SERVER_NAME +Map:$MAP"

# Add GSLT if provided
if [ -n "$GSLT" ]; then
    CMD="$CMD +GSLT:$GSLT"
fi

# Execute the server
exec $CMD
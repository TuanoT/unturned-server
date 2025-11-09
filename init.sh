#!/bin/bash
set -e

# Set default values if not provided
SERVER_NAME="${SERVER_NAME:-MyServer}"
MAP="${MAP:-PEI}"

echo "Starting Unturned server:"
echo "Server Name: $SERVER_NAME"
echo "Map: $MAP"
echo "Port: $PORT"

CMD="./Unturned_Headless.x86_64 -nographics -batchmode +InternetServer/$SERVER_NAME +Port:$PORT +Map:$MAP"

exec $CMD
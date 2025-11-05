#!/bin/bash
set -e

# Update server on start
/update.sh

cd "$UNTURNED_DIR"
echo "Starting Unturned server..."
mono Unturned.exe -nographics -${MAP} -${MODE} -nosync $( [ "$PVE" = "true" ] && echo "-pve" || echo "-pvp" ) -players:$PLAYERS -sv
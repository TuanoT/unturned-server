#!/bin/bash
set -e

echo "Starting Unturned Server..."

ulimit -n 2048
export TERM=xterm

# If running as root, handle mounts on host machine and switch to unturned user
if [ "$(id -u)" = "0" ]; then
    echo "Checking for mounted /server volume..."
    if mountpoint -q /server; then
        echo "/server is a mount - fixing permissions..."
        chown -R unturned:unturned /server
    fi

    echo "Switching to unturned user..."
    exec su -s /bin/bash unturned -c "/home/unturned/init.sh"
fi

# Server settings
SERVER_NAME="MelbourneVanilla"
MAP="Washington"
GSLT="07577C5CE9C2665B2BFBCB1B063C19A5" # I don't give a fuck about this

echo "Running server: ${SERVER_NAME} on map ${MAP}..."
exec ./Unturned_Headless.x86_64 -batchmode -nographics +InternetServer/${SERVER_NAME} +Map ${MAP} +GSLT ${GSLT}
#!/bin/bash
set -e

echo "Starting Unturned Server..."

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

SERVER_NAME="${SERVER_NAME:-MelbourneVanilla}"
MAP="${MAP:-Washington}"
GSLT="${GSLT:-}"
ARGS=(
    "./Unturned_Headless.x86_64"
    "-nographics"
    "-batchmode"
    "+InternetServer/${SERVER_NAME}"
    "+Map:${MAP}"
)

# Add GSLT if provided
if [ -n "$GSLT" ]; then
    ARGS+=("+GSLT" "$GSLT")
fi

echo "Launching Unturned server: ${SERVER_NAME} (${MAP})"
exec "${ARGS[@]}"
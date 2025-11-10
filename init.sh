#!/bin/bash
set -e

echo "Starting Unturned Server..."

# Give unturned ownership of the server mount on the host system and re-exec as unturned
if [ "$(id -u)" = "0" ]; then
    chown -R unturned:unturned /server
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
    ARGS+=("+GSLT:${GSLT}")
fi

exec "${ARGS[@]}"
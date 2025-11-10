#!/bin/bash
set -e

# Give unturned ownership of the server mount on the host system and re-exec as unturned
if [ "$(id -u)" = "0" ]; then
    chown -R unturned:unturned /server
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

echo "Starting Unturned Server..."
exec "${ARGS[@]}"
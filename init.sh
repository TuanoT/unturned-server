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

SERVER_NAME="${SERVER_NAME:-MelbourneVanilla}"
MAP="${MAP:-Washington}"
GSLT="${GSLT:-}"

ARGS=(
    "-batchmode"
    "-nographics"
    "+InternetServer/$SERVER_NAME"
    "+Map"
    "$MAP"
)

if [ -n "$GSLT" ]; then
    ARGS+=("+GSLT" "$GSLT")
fi

echo "Running: ${SERVER_NAME}..."
exec ./Unturned_Headless.x86_64 "${ARGS[@]}"
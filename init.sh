#!/bin/bash
set -e

echo "Starting Unturned Server..."

ulimit -n 2048
export TERM=xterm

# Handle perms for mount on host machine and switch to unturned user
if [ "$(id -u)" = "0" ]; then
    if mountpoint -q /server; then
        echo "/server is a mount - fixing permissions on host..."
        chown -R unturned:unturned /server
    fi

    echo "Switching to unturned user..."
    exec su -s /bin/bash unturned -c "/home/unturned/init.sh"
fi

# If /server is empty, copy the base installation from /opt/unturned
if [ ! -f /server/Unturned_Headless.x86_64 ]; then
    echo "/server is empty, copying base Unturned install..."
    cp -r /opt/unturned/* /server/
fi
cd /server

# Get aruguments from environment variables
SERVER_NAME="${SERVER_NAME:-MelbourneVanilla}"

echo "Running server: ${SERVER_NAME}..."
exec ./ServerHelper.sh -batchmode -nographics "+InternetServer/${SERVER_NAME}"
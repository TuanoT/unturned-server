#!/bin/bash
set -e

export TERM=xterm

chown -R steam:steam /home/steam/Unturned || true

echo "=== Updating Unturned Dedicated Server ==="
cd "$STEAMCMD_DIR"
./steamcmd.sh +login "$STEAM_USERNAME" +force_install_dir "$GAME_INSTALL_DIR" +app_update "$GAME_ID" validate +quit

cd "$GAME_INSTALL_DIR"

if [ ! -d "Servers/$SERVER_NAME" ]; then
  echo "=== Creating server structure for '$SERVER_NAME' ==="
  mkdir -p "Servers/$SERVER_NAME"
fi

echo "=== Setting up environment ==="
ulimit -n 2048
if [ -d "./Unturned_Headless_Data" ]; then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(pwd)/Unturned_Headless_Data/Plugins/x86_64/"
else
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(pwd)/Unturned_Headless/Plugins/x86_64/"
fi

echo "=== Starting Unturned server '$SERVER_NAME' ==="
exec ./Unturned_Headless.x86_64 -nographics -batchmode +InternetServer/"$SERVER_NAME"

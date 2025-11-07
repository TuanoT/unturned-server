#!/bin/bash
set -e

cd /home/steam/steamcmd

echo "=== Updating Unturned Dedicated Server ==="
./steamcmd.sh +login anonymous +force_install_dir /home/steam/Unturned +app_update 1110390 validate +quit

cd /home/steam/Unturned

if [ ! -d "Servers/MyServer" ]; then
  echo "=== Creating default server structure ==="
  mkdir -p Servers/MyServer
fi

echo "=== Starting Unturned Server ==="
./Unturned_Headless.x86_64 -nographics -batchmode +InternetServer/MyServer

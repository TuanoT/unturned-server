#!/bin/bash
# Ensure persistent host folder exists
HOST_DATA="$HOME/unturned-data"
mkdir -p "$HOST_DATA"

# Start Unturned server
echo "Starting Unturned server..."
cd "$HOST_DATA/Servers/Default" || mkdir -p "$HOST_DATA/Servers/Default" && cd "$HOST_DATA/Servers/Default"
mono /unturned/Unturned.exe -nographics -pei -normal -nosync -pve -players:16 -sv

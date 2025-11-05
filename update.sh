#!/bin/bash
set -e

cd /steamcmd
./steamcmd.sh +force_install_dir "$UNTURNED_DIR" +login anonymous +app_update 304930 validate +quit
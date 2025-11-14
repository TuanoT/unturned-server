#!/bin/bash
set -e

cd "$GAME_INSTALL_DIR" || exit

SERVER_DIR="$GAME_INSTALL_DIR/Servers/$SERVER_NAME"
LOG_DIR="$SERVER_DIR/Logs"
mkdir -p "$LOG_DIR"

ulimit -n 2048
export TERM=xterm
export LD_LIBRARY_PATH=/home/steam/.steam/sdk64:$LD_LIBRARY_PATH

if [ -d "./Unturned_Headless_Data" ]; then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(pwd)/Unturned_Headless_Data/Plugins/x86_64/"
else
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(pwd)/Unturned_Headless/Plugins/x86_64/"
fi

# --- CONFIG ---
AUTOSAVE_INTERVAL=${AUTOSAVE_INTERVAL:-300} # default 5 minutes
# ---------------

send_command() {
    if screen -ls "unturned" > /dev/null 2>&1; then
        screen -S "unturned" -X stuff "$1"$'\n'
        echo "Sent command: $1" >&2
    fi
}

graceful_shutdown() {
    echo "Received shutdown signal at $(date)" >&2
    send_command "say Server restarting in 3 seconds"
    send_command "shutdown 3"

    # Stop autosave loop
    kill "$AUTOSAVE_PID" 2>/dev/null || true

    # Wait until server exits
    while screen -ls "unturned" > /dev/null 2>&1; do
        sleep 1
    done

    echo "Server shutdown completed gracefully"
    exit 0
}

# Trap Docker stop
trap graceful_shutdown SIGTERM SIGINT


echo "Starting Unturned server in screen session..."
screen -dmS "unturned" -L -Logfile "$LOG_DIR/latest.log" \
    ./Unturned_Headless.x86_64 -batchmode -nographics +secureserver/"$SERVER_NAME"


echo "Server started. Log: $LOG_DIR/latest.log"


# ------------------------------
# AUTO-SAVE LOOP
# ------------------------------
(
    while true; do
        sleep "$AUTOSAVE_INTERVAL"
        if screen -ls "unturned" > /dev/null 2>&1; then
            echo "Auto-saving world..."
            send_command "say Saving Server..."
            send_command "save"
        else
            echo "Screen session gone, stopping autosave loop."
            exit 0
        fi
    done
) &
AUTOSAVE_PID=$!
echo "Autosave loop started (PID $AUTOSAVE_PID), interval: $AUTOSAVE_INTERVAL seconds"


# ------------------------------
# Main loop: wait for server exit
# ------------------------------
tail -f "$LOG_DIR/latest.log" &
TAIL_PID=$!

while screen -ls "unturned" > /dev/null 2>&1; do
    sleep 3
done

kill $TAIL_PID 2>/dev/null || true
kill $AUTOSAVE_PID 2>/dev/null || true
wait $TAIL_PID 2>/dev/null || true

echo "Screen session ended"

#!/usr/bin/env bash
#
# Usage: start-server SERVER
#
MINE_SERVER=$1
BASE_DIR=/mnt/minecraft
SERVER_DIR="$BASE_DIR/servers/$MINE_SERVER"

# Various start checks
if [ -z "$MINE_SERVER" ]; then
        echo "Server name required"
        exit 1
fi

if [ ! -d "$SERVER_DIR" ]; then
        echo "Server doesn't exist"
        exit 1
fi

# Check if server may already be running
if [ ! -z "$(screen -ls | grep $MINE_SERVER)" ]; then
        echo "It looks like the server is already running"
        exit 1
fi

# Start server
echo "Starting server..."
screen -S $MINE_SERVER -dm bash -c "$BASE_DIR/scripts/mineserv.sh $MINE_SERVER"
sleep 10

# Check if it started successfully
STARTED="$(tail -1 "$SERVER_DIR/logs/latest.log" | grep "Done")"
if [ -z "$STARTED" ]; then
        if [ ! -z "$(tail "$SERVER_DIR"/logs/latest.log | grep "**** FAILED TO BIND TO PORT!")" ]; then
                echo "ERROR: Server Port in use"
        else
                echo "ERROR: Uknown start error, check logs"
        fi
else
        echo "Server started"
fi

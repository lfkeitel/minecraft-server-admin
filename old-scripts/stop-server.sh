#!/usr/bin/env bash
#
# Usage: start-server SERVER
#
MINE_SERVER=$1
BASE_DIR=/mnt/minecraft

if [ -z "$MINE_SERVER" ]; then
        echo "Server name required"
        exit 1
fi

# Check if it's running now
if [ -z "$(screen -list | grep $MINE_SERVER)" ]; then
        echo "Server not running"
        exit 1
fi

# First try to stop server
echo "Stopping server..."
screen -R $MINE_SERVER -X stuff "stop $NOW $(printf '\r')"
sleep 10

# If the server didn't stop in time, force close the screen session
if [ -z "$(screen -list | grep $MINE_SERVER)" ]; then
        echo "Server stopped"
else
        echo "Force killing screen session"
        screen -S $MINE_SERVER -X quit
fi

# If it still failed, echo a message
if [ ! -z "$(screen -list | grep $MINE_SERVER)" ]; then
        echo "Force killing didn't work"
        exit 1
fi

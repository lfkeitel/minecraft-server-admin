#!/usr/bin/env bash
#
# Usage: say-time SERVER
#
MINE_SERVER=$1
BASE_DIR=/mnt/minecraft
NOW=$(date "+%F %H:%M")

if [ -z "$MINE_SERVER" ]; then
        echo "Server name required"
        exit 1
fi

# Check if it's running now
if [ -n "$(screen -list | grep $MINE_SERVER)" ]; then
        screen -R $MINE_SERVER -X stuff "say Time is now $NOW $(printf '\r')"
fi

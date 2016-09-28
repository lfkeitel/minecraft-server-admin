#!/usr/bin/env bash
#
# Usage: mineserv SERVER
#
MINE_SERVER=$1
BASE_DIR=/mnt/minecraft
SERVER_DIR=$BASE_DIR/servers/$MINE_SERVER

if [ -z "$MINE_SERVER" ]; then
        echo "Server name required"
        exit 1
fi

if [ ! -d "$SERVER_DIR" ]; then
        echo "Server doesn't exist"
        exit 1
fi

cd $SERVER_DIR
java -Xmx2048M -Xms2048M -jar minecraft_server.jar nogui

#!/usr/bin/env bash
#
# Usage: restart-server SERVER
#
MINE_SERVER=$1
BASE_DIR=/mnt/minecraft

$BASE_DIR/scripts/stop-server.sh $MINE_SERVER
if [ $? -ne 0 ]; then
        echo "Error stopping server"
        exit 1
fi

$BASE_DIR/scripts/start-server.sh $MINE_SERVER
if [ $? -ne 0 ]; then
        echo "Error starting server"
        exit 1
fi

#!/bin/sh
#
# Usage: screen_server_start SERVER_DIR
#
SERVER_DIR=$1
JAVA_HEAP=2048M

if [ ! -d "$SERVER_DIR" ]; then
        echo "Server doesn't exist"
        exit 1
fi

cd $SERVER_DIR
java -Xmx$JAVA_HEAP -Xms$JAVA_HEAP -jar minecraft_server.jar nogui

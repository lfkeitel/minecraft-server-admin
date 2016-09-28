#!/usr/bin/env bash
#
# Usage: create-server SERVER
#
MINE_SERVER=$1
FORCE_NEW=$2
BASE_DIR=/mnt/minecraft
JAR_DIR="$BASE_DIR/jars"
SERVER_DIR="$BASE_DIR/servers/$MINE_SERVER"

if [ "$FORCE_NEW" == "y" ]; then
        FORCE_NEW=true
fi

if [ "$FORCE_NEW" != true ]; then
        FORCE_NEW=false
fi

if [ -z "$MINE_SERVER" ]; then
        echo "Server name required"
        exit 1
fi

if [ "$FORCE_NEW" = true ]; then
        rm -rf $SERVER_DIR
        if [ $? -ne 0 ]; then
                echo "Error deleting old server directory"
        fi
fi

if [ -d $SERVER_DIR ]; then
        echo "Server already exists"
        exit 1
fi

echo "Creating server directory..."
mkdir -p $SERVER_DIR
if [ $? -ne 0 ]; then
        echo "Error creating server directory"
fi

echo "Choose a server version:"
VERSIONS=()
I=0
for f in "$JAR_DIR"/*; do
        f="$(basename $f)"
        VERSIONS[$I]="$f"
        echo -e "\t${I}: $f"
        let I+=1
done

read CHOICE

echo "Linking server file ${VERSIONS[$CHOICE]}..."
CURRENT_DIR="$(pwd)"
cd $SERVER_DIR
ln -s "../../jars/${VERSIONS["$CHOICE"]}" minecraft_server.jar
cd $CURRENT_DIR

echo "Populating base server files..."
echo "[]" > $SERVER_DIR/banned-ips.json
echo "[]" > $SERVER_DIR/banned-players.json
echo "[]" > $SERVER_DIR/ops.json
echo "[]" > $SERVER_DIR/whitelist.json

echo "Accepting EULA..."
echo "eula=true" > $SERVER_DIR/eula.txt

echo -n "Port number: "
read PORT
echo "server-port=$PORT" >> $SERVER_DIR/server.properties

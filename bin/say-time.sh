#!/usr/bin/env bash
#
# Usage: say-time SERVER
#
BASE_DIR="$MCCTL_BASE_DIR"
if [ -z "$BASE_DIR" ]; then
    BASE_DIR=/srv/minecraft
fi
NOW=$(date "+%F %H:%M")
$BASE_DIR/bin/minecraftctl send "$1" "say Time is now $NOW"

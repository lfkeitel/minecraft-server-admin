#! /bin/bash
#
# Usage: backup-world TYPE SERVER
# Types: hourly, daily
#
MINE_SERVER=$1
BACKUP_TYPE=$2

BASE_DIR=/mnt/minecraft
BACKUP_DIR=$BASE_DIR/backups/$MINE_SERVER

SERVER_DIR=$BASE_DIR/servers/$MINE_SERVER
WORLD_DIR=$SERVER_DIR/world
NOW=$(date "+%Y-%m-%d")

if [ -z "$MINE_SERVER" ]; then
        echo "Server name required"
        exit 1
fi

if [ ! -d "$SERVER_DIR" ]; then
        echo "Server doesn't exist"
        exit 1
fi

save_off() {
        screen -R $MINE_SERVER -X stuff "say $1 backup starting. World no longer saving... $(printf '\r')"
        screen -R $MINE_SERVER -X stuff "save-off $(printf '\r')"
        screen -R $MINE_SERVER -X stuff "save-all $(printf '\r')"
        sleep 3
}

save_on() {
        screen -R $MINE_SERVER -X stuff "save-on $(printf '\r')"
        screen -R $MINE_SERVER -X stuff "say $1 backup complete. World now saving. $(printf '\r')"
}

if [ ! -d $BACKUP_DIR ]; then
        mkdir -p $BACKUP_DIR
        mkdir -p $BACKUP_DIR/hourly
        mkdir -p $BACKUP_DIR/daily
fi

if [ "$BACKUP_TYPE" == "hourly" ]; then
        save_off $BACKUP_TYPE
        cd $BACKUP_DIR/hourly
        rm -f minecraft-hour24.tar.gz
        mv minecraft-hour23.tar.gz minecraft-hour24.tar.gz
        mv minecraft-hour22.tar.gz minecraft-hour23.tar.gz
        mv minecraft-hour21.tar.gz minecraft-hour22.tar.gz
        mv minecraft-hour20.tar.gz minecraft-hour21.tar.gz
        mv minecraft-hour19.tar.gz minecraft-hour20.tar.gz
        mv minecraft-hour18.tar.gz minecraft-hour19.tar.gz
        mv minecraft-hour17.tar.gz minecraft-hour18.tar.gz
        mv minecraft-hour16.tar.gz minecraft-hour17.tar.gz
        mv minecraft-hour15.tar.gz minecraft-hour16.tar.gz
        mv minecraft-hour14.tar.gz minecraft-hour15.tar.gz
        mv minecraft-hour13.tar.gz minecraft-hour14.tar.gz
        mv minecraft-hour12.tar.gz minecraft-hour13.tar.gz
        mv minecraft-hour11.tar.gz minecraft-hour12.tar.gz
        mv minecraft-hour10.tar.gz minecraft-hour11.tar.gz
        mv minecraft-hour9.tar.gz minecraft-hour10.tar.gz
        mv minecraft-hour8.tar.gz minecraft-hour9.tar.gz
        mv minecraft-hour7.tar.gz minecraft-hour8.tar.gz
        mv minecraft-hour6.tar.gz minecraft-hour7.tar.gz
        mv minecraft-hour5.tar.gz minecraft-hour6.tar.gz
        mv minecraft-hour4.tar.gz minecraft-hour5.tar.gz
        mv minecraft-hour3.tar.gz minecraft-hour4.tar.gz
        mv minecraft-hour2.tar.gz minecraft-hour3.tar.gz
        mv minecraft-hour1.tar.gz minecraft-hour2.tar.gz
        mv minecraft-hour0.tar.gz minecraft-hour1.tar.gz

        cd $WORLD_DIR
        tar -cpvzf $BACKUP_DIR/hourly/minecraft-hour0.tar.gz *
        save_on $BACKUP_TYPE
        echo "Backed up world at $(date "+%F %H:%M:%S")"
elif [ "$BACKUP_TYPE" == "daily" ]; then
        save_off $BACKUP_TYPE
        cd $WORLD_DIR
        tar -cpvzf $BACKUP_DIR/daily/minecraft-${NOW}.tgz *
        save_on $BACKUP_TYPE
        cd $BACKUP_DIR/daily
        # Delete backups older than 2 weeks
        find . -mtime +14 -exec rm {} \;
        echo "Backed up world at $(date "+%F %H:%M:%S")"
else
        echo "No backup made. $BACKUP_TYPE not valid backup type"
fi

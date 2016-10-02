#!/bin/bash

NAME=manager
MANAGER=/usr/recalbox-manager
PM2=/usr/recalbox-manager/node_modules/pm2/bin/pm2
USER=root

export PATH=/usr/bin:$PATH
export PM2_HOME="/root/.pm2"


start() {
    echo "Starting $NAME"
    cd $MANAGER
    $PM2 startOrReload $MANAGER/scripts/pm2-process.json
}

stop() {
    $PM2 dump
    $PM2 delete $NAME
    $PM2 kill
}

restart() {
    echo "Restarting $NAME"
    stop
    start
}

reload() {
    echo "Reloading $NAME"
    $PM2 reload $NAME
}

status() {
    echo "Status for $NAME:"
    $PM2 list
    RETVAL=$?
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart)
        restart
        ;;
    reload)
        reload
        ;;
    force-reload)
        reload
        ;;
    *)
        echo "Usage: {start|stop|status|restart|reload|force-reload}"
        exit 1
        ;;
esac
exit $RETVAL

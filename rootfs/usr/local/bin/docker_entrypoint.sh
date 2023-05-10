#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
# chown -R docker-u:docker-g /config

#=========================================================================================

# Start transmission in console mode
exec gosu docker \
    /usr/bin/transmission-daemon \
    --config-dir /config \
    --pid-file /config/transmission.pid \
    --no-watch-dir \
    --incomplete-dir /downloads/incomplete \
    --download-dir /downloads/complete \
    --foreground

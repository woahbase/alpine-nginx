#!/bin/bash
###
## reload nginx only if configurations valid
###
ROOTDIR="${ROOTDIR:-/config}";
NGINXDIR="${NGINXDIR:-$ROOTDIR/nginx}";

echo "Checking configurations...";
nginx -c ${NGINXDIR}/nginx.conf -t \
&& { \
    echo "Reloading configurations...";
    nginx -c ${NGINXDIR}/nginx.conf -s reload \
        && echo "Done." \
        || echo "Failed.";
} || echo "Test Failed. Won't reload.";

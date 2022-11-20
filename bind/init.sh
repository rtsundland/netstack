#!/bin/sh

#
# start cron
/usr/sbin/cron -f &
echo "*/5 * * * * sh /getRecursiveIPs.sh && rndc reconfig" | crontab

#
# run getRecursiveIPs.sh and then start bind
sh /getRecursiveIPs.sh && exec /usr/sbin/named -u ${BIND_USER:-bind} -g -c ${BIND_CONFIG:-/etc/bind/named.conf}


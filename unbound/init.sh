#!/bin/sh

#
# update root key
/usr/sbin/unbound-anchor 

#
# chown files under... well, there
chown unbound:unbound /var/lib/unbound/*

#
# run unbound
exec /usr/sbin/unbound -c /etc/unbound/unbound.conf -d $*


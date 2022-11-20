#!/bin/sh

BIND_OPTS="-s /dev/null -n -G"
test -n "${MDNS_ENABLE}" && BIND_OPTS="${BIND_OPTS} -m"
test -n "${CONFIG}" && BIND_OPTS="${BIND_OPTS} -c ${CONFIG}" || BIND_OPTS="${BIND_OPTS} -c /etc/ntp.conf"

echo "Executing ntpd with the following options: ${BIND_OPTS}"
#
# run ntpd
exec /usr/sbin/ntpd ${BIND_OPTS} $*


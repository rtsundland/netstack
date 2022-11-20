#!/bin/sh
BINDFILE="/etc/bind/recursive-notify.conf"
# BINDFILE="/tmp/recursive-notify.conf"

#
# make sure docker is properly configured for the container
if [ -z "$(/usr/bin/docker ps -q)" ]
then	echo "Docker not properly configured, make sure to share /var/run/docker.sock into the container" > /dev/stderr
	exit 11
fi

#
# looking for RECURSIVE_SERVICE_NAME env variable for the name of our recursive service
if [ -z "${RECURSIVE_SERVICE_NAME}" ]
then	echo "Must define RECURSIVE_SERVICE_NAME in env variables to properly identify the recusrive devices" > /dev/stderr
	exit 12
fi

#
# use RECURSIVE_SERVICE_NAME to inspect all running containers and grab their virtual IP addresses
_cids=$( docker service ps $RECURSIVE_SERVICE_NAME -q 2>/dev/null )
if [ $? -eq 0 ]
then 	RECURSIVE_IPS="$(
		docker inspect -f "{{range .NetworksAttachments}}{{if ne .Network.Spec.Name \"ingress\"}}{{index .Addresses 0}}{{end}}{{end}}" $_cids | \
		cut -d '/' -f1 | xargs echo | sort
	)"
else	echo "Docker failed to find service '$RECURSIVE_SERVICE_NAME'.  Check your env variables"
	exit 13
fi

if [ -z "${RECURSIVE_IPS}" ]
then	echo "Unable to find any recursive IP addresses.  Check RECURSIVE_SERVICE_NAME env variable."
	exit 13
fi

## echo "Found recursive DNS services at ${RECURSIVE_IPS}"

echo "notify yes;" > ${BINDFILE}
echo "${RECURSIVE_IPS}" | sed 's/[[:blank:]]/; /g' | awk '{print "also-notify { "$0"; };"}' >> ${BINDFILE}


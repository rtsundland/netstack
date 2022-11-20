FROM 	debian:latest
ARG 	DEBIAN_FRONTEND=noninteractive

RUN	apt-get update && \
	apt-get install -y unbound unbound-host net-tools netcat procps dumb-init vim-tiny

COPY	--chown=root:root init.sh /
RUN	chmod u+x /init.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/init.sh" ]


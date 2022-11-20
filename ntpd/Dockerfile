FROM 	debian:latest
ARG 	DEBIAN_FRONTEND=noninteractive

RUN	apt-get update && \
	apt-get install -y ntpsec net-tools netcat procps dumb-init vim-tiny

COPY	--chown=root:root init.sh /
RUN	chmod u+x /init.sh; \
	mkdir -p -m 0700 /var/empty && chown ntpsec:ntpsec /var/empty

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/init.sh" ]


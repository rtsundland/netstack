FROM 	debian:latest
ARG 	DEBIAN_FRONTEND=noninteractive

COPY	--chown=root:root init.sh getRecursiveIPs.sh /

RUN	chmod u+x /init.sh /getRecursiveIPs.sh && \
	apt-get update && \
	apt-get install -y bind9 bind9-dnsutils bind9-utils bind9-host net-tools \
		netcat ca-certificates curl gnupg lsb-release cron procps dumb-init \
		vim-tiny

RUN	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
	echo \
		"deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
		$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
	apt-get update && apt-get install docker-ce-cli


ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/init.sh" ]


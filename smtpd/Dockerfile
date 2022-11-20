FROM debian:latest

# ENV LANG=C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive

COPY --chown=root:root init.sh /
RUN 	chmod u+x "/init.sh" && \
	apt-get update && \
	apt-get upgrade -yqq && \
    	apt-get install -y rsyslog iproute2 dumb-init postfix bash netcat && \
	apt-get clean -yqq && \
	apt-get autoclean -yqq && \
	apt-get autoremove -yqq && \
	rm -rf /var/cache/apt/archives/* /var/cache/apt/*.bin /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/init.sh" ]
CMD [ "tail", "-F", "/var/log/mail.log" ]


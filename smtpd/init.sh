#!/bin/sh

if [ ! -e "/etc/postfix/main.cf" ]
then	echo "initializing fresh postfix config directory"
	cp -prf /etc/postfix.build/* /etc/postfix/
fi

if [ -n "${MAIL_MYHOSTNAME}" ]
then	postconf -e myhostname=${MAIL_MYHOSTNAME}
else	postconf -e myhostname=${HOSTNAME}
fi

if [ -n "${MAIL_MYDOMAIN}" ]
then	postconf -e mydomain=${MAIL_MYDOMAIN}
fi

if [ -n "${MAIL_MYNETWORKS}" ]
then	postconf -e mynetworks=${MAIL_MYNETWORKS}
fi

if [ -n "${MAIL_RELAY_HOST}" ]
then	if [ -z "${MAIL_RELAY_PORT}" ]
	then	MAIL_RELAY_PORT=25
	fi

	postconf -e relayhost=${MAIL_RELAY_HOST}:${MAIL_RELAY_PORT}

	if [ -n "${MAIL_RELAY_USER}" ] && [ -n "${MAIL_RELAY_PASS}" ]
	then	echo "${MAIL_RELAY_HOST}:${MAIL_RELAY_PORT} ${MAIL_RELAY_USER}:${MAIL_RELAY_PASS}" >> /etc/postfix/sasl_passwd
		postconf -e smtp_sasl_auth_enable=yes
		postconf -e smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd
		postmap /etc/postfix/sasl_passwd
	fi
fi

postconf -e mydestination=\$myhostname,localhost.localdomain,localhost
postconf -e smtpd_banner="\$myhostname.\$mydomain ESMTP"
postconf -e smtpd_recipient_restrictions=permit_mynetworks
postconf -e smtp_use_tls=yes
postconf -e smtp_sasl_security_options=noanonymous
# postconf -e smtp_tls_security_level=encrypt
# postconf -e smtp_tls_wrappermode=yes

/etc/init.d/rsyslog start
/etc/init.d/postfix start

$@ & wait ${!}


WWW_DOMAIN=www.examlpe.com
REG_USER=example
REG_PASS=example
CERT_SETTINGS_C=EN
CERT_SETTINGS_ST=CA
CERT_SETTINGS_L=CA

ifneq ("$(wildcard .env)","")
    include .env
endif

init:
	certbot certonly --webroot --agree-tos -d ${CERT_WWW_DOMAIN}

generate-cert:
	openssl req -new -x509 -days 1461 -nodes -out public.pem -keyout private.key -subj "/C=${CERT_SETTINGS_C}/ST=${CERT_SETTINGS_ST}/L=${CERT_SETTINGS_L}/O=Global Security/OU=IT Department/CN=${WWW_DOMAIN}"

generate-pass:
	htpasswd -Bbn ${REG_USER} ${REG_PASS} > /etc/docker/auth/htpasswd

up:
	@docker compose up -d --remove-orphans

down:
	@docker compose down --remove-orphans

restart:
	make down
	make up

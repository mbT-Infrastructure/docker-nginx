#!/usr/bin/env bash
set -e

mkdir --parents /media/nginx/configuration
mkdir --parents /media/nginx/certs
mkdir --parents /media/nginx/letsencrypt

ln --symbolic --force /media/nginx/letsencrypt /etc

for DOMAIN in $CERTBOT_DOMAINS; do
    echo "Getting cert for $DOMAIN"
    CERTBOT_ADDITIONAL_COMMANDS=""
    if [ "$CERTBOT_AGREE_TOS" = true ]; then
        CERTBOT_ADDITIONAL_COMMANDS+=" --agree-tos"
    fi
    if [ "$CERTBOT_STAGING" = true ]; then
        CERTBOT_ADDITIONAL_COMMANDS+=" --staging"
    fi
    certbot certonly --non-interactive --nginx \
        --email "$CERTBOT_EMAIL" \
        --rsa-key-size "$CERTBOT_RSA_KEY_SIZE" \
        --domain "$DOMAIN" $CERTBOT_ADDITIONAL_COMMANDS
done

rm --recursive --force /etc/nginx/conf.d/*
for FILE in /media/nginx/configuration/*; do
    [ -e "$FILE" ] || continue
    cp "$FILE" /etc/nginx/conf.d
done

exec "$@"
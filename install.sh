#!/bin/bash
# takes two paramters, the domain name and the email to be associated with the certificate
DOMAIN=$1
EMAIL=$2

echo DOMAIN=${DOMAIN} >> .env
echo EMAIL=${EMAIL} >> .env

# cp docker/docker-compose.yml docker-compose.yml

# Phase 1 
docker-compose -f ./docker-compose-initiate.yaml up -d nginx
docker-compose -f ./docker-compose-initiate.yaml up certbot
docker-compose -f ./docker-compose-initiate.yaml down

# Phase 2 
# crontab ./etc/crontab
docker-compose -f ./docker-compose.yml -d up

# Some configurations for let's encrypt
# cp docker/options-ssl-nginx.conf .configs/letsencrypt/options-ssl-nginx.conf
openssl dhparam -out etc/letsencrypt/ssl-dhparams.pem 2048
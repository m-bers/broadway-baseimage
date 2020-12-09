#!/bin/bash
set -e
envsubst '$$FAVICON_URL $$APP_TITLE $$CORNER_IMAGE_URL' < /etc/nginx/nginx.tmpl > /etc/nginx/nginx.conf && nginx -g 'daemon off;' &
nohup /usr/bin/broadwayd :5 &> /var/log/broadway.log &

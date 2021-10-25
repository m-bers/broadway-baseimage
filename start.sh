#!/bin/bash
set -e
envsubst '$$FAVICON_URL $$APP_TITLE $$CORNER_IMAGE_URL' < /etc/nginx/nginx.tmpl > /etc/nginx/sites-enabled/default && nginx -g 'daemon off;' &
nohup /usr/bin/broadwayd :5 &> /var/log/broadway.log &
tmux new-session -d -s "ttyd" "tmux set -g status off && /bin/bash"
ttyd tmux a -t ttyd &
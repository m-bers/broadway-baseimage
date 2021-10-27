#!/bin/bash
set -e
if [ $DARK_MODE = true ] ; then
  export BG_GRADIENT="#111, #222"
  export GTK_THEME="Materia:dark"
  export TERM_COLOR="filter: invert(14%) sepia(7%) saturate(14%) hue-rotate(16deg) brightness(102%) contrast(90%);"
  cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Yaru
else 
  cp -r /usr/share/icons/Papirus /usr/share/icons/Yaru
fi
envsubst '$$BG_GRADIENT $$FAVICON_URL $$APP_TITLE $$CORNER_IMAGE_URL $$TERM_COLOR' < /etc/nginx/nginx.tmpl > /etc/nginx/sites-enabled/default && nginx -g 'daemon off;' &
nohup /usr/bin/broadwayd :5 &> /var/log/broadway.log &
tmux new-session -d -s "ttyd" "tmux set -g status off && /bin/bash"
ttyd tmux a -t ttyd &

FROM ubuntu:focal

ENV GDK_BACKEND='broadway'
ENV BROADWAY_DISPLAY=':5'
ENV DARK_MODE='false'
ENV GTK_THEME='Materia'
ENV BG_GRADIENT="#ddd, #999"

RUN apt-get update
RUN apt-get install -y --no-install-recommends libgtk-3-0 libgtk-3-bin nginx gettext-base tmux wget materia-gtk-theme papirus-icon-theme
RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/share/themes/Materia && mv /usr/share/themes/Materia-light /usr/share/themes/Materia

RUN wget --no-check-certificate -O /usr/bin/ttyd "https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.$(uname -m)"
RUN chmod +x /usr/bin/ttyd

COPY start.sh /usr/local/bin/start
COPY nginx.tmpl /etc/nginx/nginx.tmpl
COPY terminal-outline.svg /www/data/images/terminal-outline.svg
EXPOSE 80

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/usr/local/bin/start"]
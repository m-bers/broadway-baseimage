FROM ubuntu:focal

ENV GDK_BACKEND='broadway'
ENV BROADWAY_DISPLAY=':5'
  
RUN apt-get update
RUN apt-get install -y --no-install-recommends libgtk-3-0 libgtk-3-bin nginx gettext-base
RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

COPY start.sh /usr/local/bin/start
COPY nginx.tmpl /etc/nginx/nginx.tmpl

EXPOSE 8185

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/usr/local/bin/start"]

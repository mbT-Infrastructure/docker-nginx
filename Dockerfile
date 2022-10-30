FROM madebytimo/base

RUN apt update && apt install -y certbot nginx python3-certbot-nginx && rm -rf /var/lib/apt/lists/*

RUN rm --recursive /etc/nginx/sites-available
RUN rm --recursive /etc/nginx/sites-enabled
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir --parents /media/nginx

COPY entrypoint.sh /entrypoint.sh

ENV CERTBOT_AGREE_TOS=false
ENV CERTBOT_DOMAINS=""
ENV CERTBOT_EMAIL=""
ENV CERTBOT_RSA_KEY_SIZE=4096
ENV CERTBOT_STAGING=false

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]
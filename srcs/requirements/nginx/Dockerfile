FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl/ /etc/nginx/http.d/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/azaghlou.42.fr.key -out /etc/nginx/ssl/azaghlou.42.fr.crt -subj "/C=ma/ST=Tetouan/L=boue/O=1337/CN=azaghlou.42.fr"

COPY requirements/nginx/conf/nginx.conf /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]
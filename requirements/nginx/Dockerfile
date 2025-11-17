FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache nginx openssl gettext wget

RUN mkdir -p /etc/nginx/ssl/ /etc/nginx/http.d/

COPY conf/nginx.conf /tmp/nginx.conf.template

EXPOSE 443

CMD sh -c "echo '[req]' > /tmp/ssl.conf && \
    echo 'distinguished_name = req_distinguished_name' >> /tmp/ssl.conf && \
    echo 'req_extensions = v3_req' >> /tmp/ssl.conf && \
    echo '[req_distinguished_name]' >> /tmp/ssl.conf && \
    echo '[v3_req]' >> /tmp/ssl.conf && \
    echo 'subjectAltName = @alt_names' >> /tmp/ssl.conf && \
    echo '[alt_names]' >> /tmp/ssl.conf && \
    echo 'DNS.1 = ${DOMAIN_NAME}' >> /tmp/ssl.conf && \
    echo 'DNS.2 = localhost' >> /tmp/ssl.conf && \
    echo 'IP.1 = 127.0.0.1' >> /tmp/ssl.conf && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/${DOMAIN_NAME}.key \
    -out /etc/nginx/ssl/${DOMAIN_NAME}.crt \
    -subj '/C=MA/ST=State/L=City/O=42/CN=${DOMAIN_NAME}' \
    -extensions v3_req -config /tmp/ssl.conf && \
    envsubst '\$DOMAIN_NAME' < /tmp/nginx.conf.template > /etc/nginx/http.d/default.conf && \
    nginx -g 'daemon off;'"
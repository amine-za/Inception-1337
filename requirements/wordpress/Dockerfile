FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y php8.2 php8.2-cli php8.2-mysql curl php8.2-fpm mariadb-client && \
    sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/8.2/fpm/pool.d/www.conf && \
    rm -rf /var/lib/apt/lists/*

# Installing WP command line interface
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

WORKDIR /var/www/html

COPY tools/script.sh /

RUN chmod +x /script.sh

ENTRYPOINT [ "sh", "/script.sh" ]

CMD [ "php-fpm8.2", "-F" ]
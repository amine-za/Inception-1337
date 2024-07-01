FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache php82 php82-fpm php82-mysqli php82-json php82-curl \
    php82-dom php82-exif php82-fileinfo php82-mbstring php82-openssl php82-xml php82-zip wget unzip

# FPM:          FastCGI Process Manager.
# MYSQLI:       A php extension for interactiong with MYSQL database in a secure way,
#               connect to database, fetch and insert data...
# JSON:         Json data format cmnly used for exchanging inf btwn apps, widly usd for APIs.
# php-curl:     php-curl is all about enabling your PHP scripts to make requests to 
#               other servers and services over the internet using http and other prtcls.
# php-dom:      -
# php-exif:     -
# php-fileinfo: Provides functionality to determine file types and properties.
# php-mbstring: Enables multi-byte string handling for character sets beyond basic ASCII.
# php-openssl:  Offers secure communication capabilities using SSL and TLS.
# php-xml:      -
# php-zip:      Allows you to create and work with ZIP archives in your PHP code.
# wget:         A command-line tool for downloading files from the internet.
# unzip:        A command-line tool for extracting ZIP archives.

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g"        /etc/php82/php-fpm.d/www.conf  && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php82/php-fpm.d/www.conf  && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php82/php-fpm.d/www.conf  && \
    rm -f /var/cache/apk/*

WORKDIR /tmp

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar                                                              && \
    mv wp-cli.phar /usr/local/bin/wp                                                  

WORKDIR /var/www

COPY requirements/wordpress/conf/wp-config-create.sh .

RUN sh wp-config-create.sh                  && \
    rm wp-config-create.sh                  && \
    chmod -R 777 wp-content/

CMD ["/usr/sbin/php-fpm82", "-F"]
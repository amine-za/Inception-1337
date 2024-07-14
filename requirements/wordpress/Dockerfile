FROM debian:bookworm

RUN apt update && apt install php8.2 php8.2-cli php8.2-mysql curl php8.2-fpm unzip mariadb-client -y && \
    sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/8.2/fpm/pool.d/www.conf

# Install WordPress CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Expose port 9000 for php-fpm
EXPOSE 9000

# Set up the working directory
WORKDIR /var/www/html

# Copy WordPress files
# RUN curl -o wordpress.zip -SL https://wordpress.org/latest.zip && \
#     unzip wordpress.zip && \
#     rm wordpress.zip


COPY conf/wp-config-create.sh /wp-config-create.sh

RUN chmod +x /wp-config-create.sh

# RUN sh /var/www/html/wp-config-create.sh

# Set the entrypoint script as the container's entrypoint
ENTRYPOINT [ "sh", "/wp-config-create.sh"]
# ENTRYPOINT [ "tail"]

# Command to run on container startup
CMD [ "php-fpm8.2", "-F"]


# ------Brief DESCRIPTION of the packages that i installed------
# FPM:          FastCGI Process Manager.
# php8.2-cli: command-line interface (CLI) tools for the PHP, like letting your terminal understand php files.
# php8.2-mysql: A php extension for interactiong with MYSQL database in a secure way,
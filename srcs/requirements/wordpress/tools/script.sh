#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
    cd /var/www/html/
    rm -rf /var/www/html/*

    wp core download --allow-root
    wp config create --allow-root  --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306

    chmod 600 /var/www/html/wp-config.php

    wp core install --allow-root --url=$URL --title=$TITLE --admin_user=$ADMIN --admin_password=$ROOT_PASS --admin_email=$EMAIL_ROOT

    chown -R www-data:www-data /var/www/html/
    chmod -R 777 /var/www/html/

    wp user create --allow-root root $EMAIL_ROOT --role=administrator --user_pass=$ROOT_PASS --path=/var/www/html/wordpress
    wp user create --allow-root $USER_NAME $EMAIL --role=editor --user_pass=$DB_PASS --path=/var/www/html/wordpress
fi

exec "$@"
echo "wp-config-create.sh >>>";

wp core download --allow-root

wp config create --allow-root --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=${DB_HOST}

wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWD} --admin_email=${WP_ADMIN_EMAIL}

wp user create ${WP_USER}  ${WP_USER_EMAIL} --role=editor --user_pass=${WP_PASSWD} --path=/var/www/html/wordpress --allow-root 

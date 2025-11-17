#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
    cd /var/www/html/
    rm -rf /var/www/html/*

    wp core download --allow-root

    # Wait for MariaDB to be ready
    until mysqladmin ping -h mariadb -u"$DB_USER" -p"$DB_PASS" --silent; do
        echo "Waiting for MariaDB..."
        sleep 2
    done

    wp config create --allow-root  --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306

    # Add dynamic URL detection to work with both domain and localhost
    echo "" >> /var/www/html/wp-config.php
    echo "// Dynamic URL detection for localhost and domain" >> /var/www/html/wp-config.php
    echo "if (!defined('WP_HOME')) {" >> /var/www/html/wp-config.php
    echo "    \$protocol = (!empty(\$_SERVER['HTTPS']) && \$_SERVER['HTTPS'] !== 'off' || \$_SERVER['SERVER_PORT'] == 443) ? 'https' : 'http';" >> /var/www/html/wp-config.php
    echo "    define('WP_HOME', \$protocol . '://' . \$_SERVER['HTTP_HOST']);" >> /var/www/html/wp-config.php
    echo "}" >> /var/www/html/wp-config.php
    echo "if (!defined('WP_SITEURL')) {" >> /var/www/html/wp-config.php
    echo "    define('WP_SITEURL', WP_HOME);" >> /var/www/html/wp-config.php
    echo "}" >> /var/www/html/wp-config.php

    chmod 600 /var/www/html/wp-config.php

    wp core install --allow-root --url=$URL --title=$TITLE --admin_user=$ADMIN --admin_password=$ROOT_PASS --admin_email=$EMAIL_ROOT

    wp theme install twentytwentyone --activate --allow-root
    wp option update blogname "My Custom Homepage" --allow-root
    wp option update blogdescription "Welcome to my simple site!" --allow-root

    chown -R www-data:www-data /var/www/html/
    chmod -R 777 /var/www/html/

    wp user create --allow-root wpuser2 $EMAIL_ROOT --role=administrator --user_pass=$ROOT_PASS
    wp user create --allow-root wpeditor $EMAIL --role=editor --user_pass=$DB_PASS
fi

# Always ensure dynamic URL detection is in wp-config.php (for existing installations too)
if [ -f /var/www/html/wp-config.php ]; then
    if ! grep -q "Dynamic URL detection for localhost and domain" /var/www/html/wp-config.php; then
        echo "" >> /var/www/html/wp-config.php
        echo "// Dynamic URL detection for localhost and domain" >> /var/www/html/wp-config.php
        echo "if (!defined('WP_HOME')) {" >> /var/www/html/wp-config.php
        echo "    \$protocol = (!empty(\$_SERVER['HTTPS']) && \$_SERVER['HTTPS'] !== 'off' || \$_SERVER['SERVER_PORT'] == 443) ? 'https' : 'http';" >> /var/www/html/wp-config.php
        echo "    define('WP_HOME', \$protocol . '://' . \$_SERVER['HTTP_HOST']);" >> /var/www/html/wp-config.php
        echo "}" >> /var/www/html/wp-config.php
        echo "if (!defined('WP_SITEURL')) {" >> /var/www/html/wp-config.php
        echo "    define('WP_SITEURL', WP_HOME);" >> /var/www/html/wp-config.php
        echo "}" >> /var/www/html/wp-config.php
    fi
fi

# Create must-use plugin to override URLs dynamically
mkdir -p /var/www/html/wp-content/mu-plugins
cat > /var/www/html/wp-content/mu-plugins/dynamic-url.php << 'MUPLUGIN_EOF'
<?php
/**
 * Plugin Name: Dynamic URL Override
 * Description: Overrides WordPress URLs to work with both localhost and custom domain
 * Version: 1.0
 */

// Get current protocol and host
function get_dynamic_base_url() {
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || 
                 (!empty($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == 443) ||
                 (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https')) 
                ? 'https' : 'http';
    $host = !empty($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : 'localhost';
    return $protocol . '://' . $host;
}

// Override database options
add_filter('option_siteurl', function($value) {
    return get_dynamic_base_url();
}, 1);

add_filter('option_home', function($value) {
    return get_dynamic_base_url();
}, 1);

// Override site_url() and home_url() functions
add_filter('site_url', function($url, $path, $scheme) {
    $base = get_dynamic_base_url();
    if ($path) {
        $url = $base . '/' . ltrim($path, '/');
    } else {
        $url = $base;
    }
    return $url;
}, 1, 3);

add_filter('home_url', function($url, $path, $scheme) {
    $base = get_dynamic_base_url();
    if ($path) {
        $url = $base . '/' . ltrim($path, '/');
    } else {
        $url = $base;
    }
    return $url;
}, 1, 3);

// Override content URL
add_filter('content_url', function($url, $path = '') {
    $base = get_dynamic_base_url();
    return $base . '/wp-content' . ($path ? '/' . ltrim($path, '/') : '');
}, 1, 2);

// Override plugins URL
add_filter('plugins_url', function($url, $path, $plugin) {
    $base = get_dynamic_base_url();
    return $base . '/wp-content/plugins' . ($path ? '/' . ltrim($path, '/') : '');
}, 1, 3);
MUPLUGIN_EOF

chmod 644 /var/www/html/wp-content/mu-plugins/dynamic-url.php

exec "$@"
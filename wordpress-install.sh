#!/bin/bash
PUB_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
BASE_URL=http://$PUB_IP/
DB_USER="wordpress"
DB_PASS="wp12345678"
DB_HOST="localhost"
WP_NAME="7digital"

cd /var/www/wordpress/
wp --allow-root core download --path=$WP_NAME
wp --allow-root config create --path=$WP_NAME --dbname=$DB_USER --dbuser=$DB_USER --dbpass=$DB_PASS --extra-php <<PHP
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);
define('WP_MEMORY_LIMIT', '256M');
PHP
wp --allow-root core install --path=$WP_NAME --url=$BASE_URL --title=$WP_NAME --admin_user=test --admin_email=test@localhost.com
wp --allow-root post create ~/7digital/mypost --post_title='Samplepost' --post_status=publish

#!/bin/bash

MAX_RETRIES=30
COUNTER=0
# sleep 10000
# Wait for MariaDB to be ready
waitForMariaDB() {
    until echo 'SELECT 1' | mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p "$MYSQL_PASSWORD" &> /dev/null || [ $COUNTER -eq $MAX_RETRIES ]; do
        COUNTER=$((COUNTER+1))
        echo "Waiting for MariaDB to be ready... (Attempt: $COUNTER)"
        sleep 1
    done

    if [ $COUNTER -eq $MAX_RETRIES ]; then
		sleep 999999
        echo "MariaDB not ready after $MAX_RETRIES attempts. Exiting."
        exit 1
    fi
}

setupWordPress() {
    if ! $(wp core is-installed --allow-root); then
        wp core download --allow-root
        echo "DOWNLOADED"
        wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost=127.0.0.1 --allow-root
        echo "CONFIG CREATED"
        wp core install --allow-root --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_EMAIL" --admin_password="$WP_ADMIN_PASSWORD"
        echo "INSTALLED"
        wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PASSWORD" --allow-root
        echo "USER CREATED"
    fi
}

main() {
    # cd /var/www/html
    # waitForMariaDB
    setupWordPress
    echo "going to run "
    /usr/sbin/php-fpm7.3 -F -R
}

main


trouver un moyen que cette image elle run sans rien
depuis le terminal wp, faire la commande mysql pour se connecter 
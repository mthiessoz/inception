#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    echo "Install mariadb done"

    # Start MariaDB in the background to perform initial operations
    mariadbd-safe --datadir='/var/lib/mysql' --no-watch &

    # Wait for MariaDB to start
    for i in {1..30}; do
        if echo 'SELECT 1' | mariadb -u root &> /dev/null; then
            break
        fi
        sleep 1
    done

    # Secure initial MariaDB setup

    mariadb -uroot -h localhost -e "DROP DATABASE test"
    mariadb -uroot -h localhost -e "DROP USER ''@'"localhost"'"
    mariadb -uroot -h localhost -e "DROP USER ''@'"$(hostname)"'"
    mariadb -uroot -h localhost -e "CREATE DATABASE $MYSQL_DATABASE"
    mariadb -uroot -h localhost -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
    mariadb -uroot -h localhost -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%'"
    mariadb -uroot -h localhost -e "FLUSH PRIVILEGES"
    mariadb -uroot -h localhost -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'"

    # Shut down the temporary MariaDB instance
    pkill maria
    sleep 5
fi

# Start MariaDB in the usual way
mariadbd-safe --datadir='/var/lib/mysql'


# mariadbd-safe --datadir='/var/lib/mysql' --no-watch &
# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
# mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"
# mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown;
# exec mysqld_safe;
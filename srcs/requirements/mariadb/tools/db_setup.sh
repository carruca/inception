rc-service mariadb start 2> /dev/null
mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE};"
mysql -u root ${MYSQL_DATABASE} < wp_backup.sql
mysql -u root -e \
"CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;"

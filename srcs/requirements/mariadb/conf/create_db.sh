#!bin/sh

echo "
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE  IF NOT EXISTS  ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER  IF NOT EXISTS  '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;" > init_db.sql

mariadbd --user=mysql --bootstrap < /init_db.sql

exec "$@"
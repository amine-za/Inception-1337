# !bin/sh

echo "FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';
CREATE DATABASE  IF NOT EXISTS  ${DB_NAME};
CREATE USER  IF NOT EXISTS  '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;" > init_db.sql


mariadbd --user=mysql --bootstrap < /init_db.sql

exec "$@"
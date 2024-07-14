# !bin/sh

echo "
FLUSH PRIVILEGES;
ALTER USER 'root'@'%' IDENTIFIED BY '${ROOT_PASS}';
CREATE DATABASE  IF NOT EXISTS  ${DB_NAME};
CREATE USER  IF NOT EXISTS  '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;" > init_db.sql

# echo $(DB_NAME)

mariadbd --user=mysql --bootstrap < /init_db.sql

exec "$@"
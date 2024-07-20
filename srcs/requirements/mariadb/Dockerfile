FROM debian:bookworm

RUN apt-get update && apt-get upgrade

RUN apt-get install -y mariadb-server && mkdir -p /run/mysqld && chmod 777 /run/mysqld

COPY conf/create_db.sh /

EXPOSE 3306

ENTRYPOINT ["sh", "/create_db.sh"]

CMD ["mariadbd", "--user=root", "--bind-address=0.0.0.0"]
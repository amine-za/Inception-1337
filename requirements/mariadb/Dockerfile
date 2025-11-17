FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server && mkdir -p /run/mysqld && chmod 777 /run/mysqld \
    && rm -rf /var/lib/apt/lists/*

COPY conf/create_db.sh /

EXPOSE 3306

ENTRYPOINT ["sh", "/create_db.sh"]

CMD ["mariadbd", "--user=mysql", "--bind-address=0.0.0.0"]
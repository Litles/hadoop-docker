FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD=Litles@mysql00

ADD init.sql /docker-entrypoint-initdb.d/init.sql
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d
RUN chown mysql:mysql /docker-entrypoint-initdb.d/*.sql

#EXPOSE 3306

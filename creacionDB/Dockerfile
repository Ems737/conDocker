FROM mysql:5.7
ENV MYSQL_ROOT_PASSWORD root
ADD dataWarehouse.sql /docker-entrypoint-initdb.d
RUN rm /etc/mysql/mysql.conf.d/mysqld.cnf
COPY mysqld.cnf /etc/mysql/mysql.conf.d/
EXPOSE 3306

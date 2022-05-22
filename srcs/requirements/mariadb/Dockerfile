FROM alpine:3.15

ARG MYSQL_ROOT_USER
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DATABASE

RUN apk update \
	&& apk add --no-cache \
	mariadb \
	mariadb-client \
	openrc \
	vim \
	gettext \
	&& rm -f /var/cache/apk/*

WORKDIR /run/openrc
RUN touch softlevel \
	&& openrc 2> /dev/null

WORKDIR /etc
RUN sed -i 's/skip-networking/#skip-networking/' my.cnf.d/mariadb-server.cnf \
	&& init.d/mariadb setup 2> /dev/null

WORKDIR /run/mysqld
RUN chown -R mysql:mysql .

COPY tools/db_setup.sh .
COPY tools/wp_backup.sql .
RUN sh db_setup.sh \
	&& rm db_setup.sh wp_backup.sql

CMD ["mariadbd", "--user=mysql"]

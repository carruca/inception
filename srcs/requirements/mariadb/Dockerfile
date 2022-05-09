FROM alpine:3.15

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

COPY tools/db-setup.sql .
RUN rc-service mariadb start 2> /dev/null \
	&& mysql < db-setup.sql \
	&& rm db-setup.sql

CMD ["mariadbd", "--user=mysql"]

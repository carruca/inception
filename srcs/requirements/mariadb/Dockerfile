FROM alpine:3.15.4

RUN apk update \
	&& apk add --no-cache \
	mariadb \
	openrc \
	&& rm -f /var/cache/apk/*

WORKDIR /run/openrc
RUN touch softlevel \
	&& openrc 2> /dev/null

WORKDIR /etc
RUN sed -i 's/skip-networking/#skip-networking/' my.cnf.d/mariadb-server.cnf \
	&& init.d/mariadb setup 2> /dev/null

WORKDIR /run/mysqld
RUN chown -R mysql:mysql .

CMD ["mariadbd", "--user=mysql"]

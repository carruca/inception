FROM alpine:3.15.4

RUN apk update && apk add \
	mariadb \
	openrc

WORKDIR /run/openrc
RUN touch softlevel \
	&& openrc 2> /dev/null

WORKDIR /etc
RUN sed -i 's/skip-networking/#skip-networking/' my.cnf.d/mariadb-server.cnf \
	&& init.d/mariadb setup 2> /dev/null

EXPOSE 3306

CMD ["mysqld"]
#CMD ["/bin/sh"]

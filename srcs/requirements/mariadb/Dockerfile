FROM alpine:3.15.4

RUN apk update && apk add \
	mariadb \
	openrc \
	vim

WORKDIR /run/openrc
RUN touch softlevel \
	&& openrc

WORKDIR /etc
RUN sed -i 's/skip-networking/#skip-networking/' my.cnf.d/mariadb-server.cnf \
	&& init.d/mariadb setup 2> /dev/null

EXPOSE 3306

CMD ["mysqld_safe"]
#CMD ["/bin/sh"]

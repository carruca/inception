FROM alpine:3.15.4

RUN apk update \
	&& apk add mariadb-client php8-fpm wget openrc \
	&& rm -f /var/cache/apk/*

WORKDIR /run/openrc
RUN touch softlevel \
	&& openrc 2> /dev/null

WORKDIR /var/www/html
RUN wget https://wordpress.org/wordpress-5.9.3.tar.gz 2> /dev/null \
	&& tar -xzvf wordpress-5.9.3.tar.gz \
	&& rm wordpress-5.9.3.tar.gz

CMD ["/bin/sh"]

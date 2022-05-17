FROM alpine:3.15

ARG WORDPRESS_DB_NAME
ARG WORDPRESS_DB_USER
ARG WORDPRESS_DB_PASSWORD
ARG WORDPRESS_DB_HOST

RUN apk update \
	&& apk add --no-cache \
	php8 \
	php8-fpm \
	php8-mysqli \
	wget \
	vim \
	gettext \
	&& rm -f /var/cache/apk/*

WORKDIR /var/www
RUN wget https://wordpress.org/wordpress-5.9.3.tar.gz 2> /dev/null \
	&& tar -xzvf wordpress-5.9.3.tar.gz \
	&& rm wordpress-5.9.3.tar.gz

COPY conf/wp-config.php.template wordpress
RUN envsubst \
	'$WORDPRESS_DB_NAME $WORDPRESS_DB_USER $WORDPRESS_DB_PASSWORD $WORDPRESS_DB_HOST' \
	< wordpress/wp-config.php.template > wordpress/wp-config.php

WORKDIR /etc/php8/php-fpm.d
COPY conf/www.conf.template .
RUN envsubst '$WORDPRESS_DB_NAME' < www.conf.template > www.conf

#RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 2> /dev/null

CMD ["php-fpm8", "-F"]

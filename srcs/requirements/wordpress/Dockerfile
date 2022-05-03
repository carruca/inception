FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache \
	php8 \
	php8-fpm \
	php8-mysqli \
	wget \
	vim \
	&& rm -f /var/cache/apk/*

WORKDIR /var/www
RUN wget https://wordpress.org/wordpress-5.9.3.tar.gz 2> /dev/null \
	&& tar -xzvf wordpress-5.9.3.tar.gz \
	&& rm wordpress-5.9.3.tar.gz

COPY conf/wp-config.php wordpress
COPY conf/www.conf /etc/php8/php-fpm.d

CMD ["php-fpm8", "-F"]

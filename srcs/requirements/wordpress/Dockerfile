FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache \
	php8 \
	php8-fpm \
	php8-mysqli \
	wget \
	&& rm -f /var/cache/apk/*

WORKDIR /var/www
RUN wget https://wordpress.org/wordpress-5.9.3.tar.gz 2> /dev/null \
	&& tar -xzvf wordpress-5.9.3.tar.gz \
	&& rm wordpress-5.9.3.tar.gz

CMD ["php-fpm8", "-F"]
#CMD ["/bin/sh"]

FROM alpine:3.15

ARG WORDPRESS_HOST

RUN apk update \
	&& apk add --no-cache \
	nginx \
	gettext \
	vim \
	&& rm -f /var/cache/apk/*

WORKDIR /var/www
RUN adduser -D -g 'www' www \
	&& chown -R www:www . \
	&& chown -R www:www /var/lib/nginx

#RUN wget https://wordpress.org/wordpress-5.9.3.tar.gz 2> /dev/null \
#	&& tar -xzvf wordpress-5.9.3.tar.gz \
#	&& rm wordpress-5.9.3.tar.gz

WORKDIR /etc/nginx
RUN mv nginx.conf nginx.conf.orig
COPY conf/nginx.conf .
COPY conf/default.conf.template http.d
RUN envsubst \
	'$WORDPRESS_HOST' \
	< http.d/default.conf.template > http.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

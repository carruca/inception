FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache \
	nginx \
	gettext \
	vim \
	&& rm -f /var/cache/apk/*

WORKDIR /var/www
RUN adduser -D -g 'www' www \
	&& chown -R www:www . \
	&& chown -R www:www /var/lib/nginx \
	&& mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

#RUN wget https://wordpress.org/wordpress-5.9.3.tar.gz 2> /dev/null \
#	&& tar -xzvf wordpress-5.9.3.tar.gz \
#	&& rm wordpress-5.9.3.tar.gz

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/http.d/default.conf
COPY conf/index.html /var/www/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM alpine:3.15

RUN apk update \
	&& apk add --no-cache \
	nginx \
	&& rm -f /var/cache/apk/*

WORKDIR /var/www
RUN adduser -D -g 'www' www \
	&& chown -R www:www . \
	&& chown -R www:www /var/lib/nginx \
	&& mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/index.html /var/www/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

FROM alpine:3.15.4

RUN apk update \
	&& apk add nginx \
	&& rm -f /var/cache/apk/*

WORKDIR /www
RUN adduser -D -g 'www' www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www . \
	&& mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/index.html /www/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

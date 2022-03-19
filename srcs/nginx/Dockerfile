FROM alpine:latest

# install nginx server
RUN apk update \
	&& apk add nginx

# new user and group 'www' for nginx
RUN adduser -D -g 'www' www

# create directory for html files
RUN mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

# backup default nginx config file
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

# add new nginx config file
COPY nginx.conf /etc/nginx/nginx.conf

# add dafault index html page
COPY index.hmtl /www/index.hmtl

# install openrc init system
RUN apk update \
	&& apk add openrc

# start nginx
RUN rc-service nginx start

CMD ["sh"]

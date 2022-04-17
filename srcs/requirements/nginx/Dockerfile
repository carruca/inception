FROM alpine:3.15.4

# install nginx server
RUN apk update	\
	&& apk add nginx

# new user and group 'www' for nginx
RUN adduser -D -g 'www' www

# create directory and change owner for html files
RUN mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

# backup default nginx config file
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

# add new nginx config file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# add default index html page
COPY conf/index.html /www/index.html

# publish port
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

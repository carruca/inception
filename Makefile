SRCS_PATH			= srcs/
REQS_PATH			= $(SRCS_PATH)requirements/
IMG_TAG				= dev

NGINX_PATH			= $(REQS_PATH)nginx/
NGINX_CONTAINER		= webserv_service

MARIADB_PATH		= $(REQS_PATH)mariadb/
MARIADB_CONTAINER	= db_service

WORDPRESS_PATH		= $(REQS_PATH)wordpress/

DOCKER				= sudo docker

BUILD				= $(DOCKER) build
RUN					= $(DOCKER) run
RM					= $(DOCKER) rm
RMI					= $(DOCKER) rmi

all:	mariadbbuild nginxbuild

nginxbuild:
	$(BUILD) $(NGINX_PATH) -t nginx:$(IMG_TAG)

#nginxrun:
#	$(RUN) --name $(NGINX_CONTAINER) -p 443:443 -d nginx:$(IMG_TAG)

#nginxrm:
#	$(RM) $(NGINX_CONTAINER)

#nginxrmi:
#	$(RMI) nginx:$(IMG_TAG)


mariadbbuild:
	$(BUILD) $(MARIADB_PATH) -t mariadb:$(IMG_TAG)

mariadbrun:
	$(RUN) --name $(MARIADB_CONTAINER) -it mariadb:$(IMG_TAG)

mariadbrm:
	$(RM) $(MARIADB_CONTAINER)

mariadbrmi:
	$(RMI) mariadb:$(IMG_TAG)


rm:
	$(DOCKER) ps --filter status=exited -aq | xargs $(DOCKER) rm

rmi:
	$(DOCKER) images -q | xargs $(DOCKER) rmi

images:
	$(DOCKER) images

.PHONY: all mariadbbuild nginxbuild
.SILENT: nginxbuild nginxrun nginxrm nginxrmi mariadbbuild mariadbrun mariadbrm mariadbrmi rm rmi images 

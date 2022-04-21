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
STOP				= $(DOCKER) stop
RM					= $(DOCKER) rm
RMI					= $(DOCKER) rmi
PS					= $(DOCKER) ps
IMAGES				= $(DOCKER) images
EXEC				= $(DOCKER) exec

all: build

build:	mariadbbuild nginxbuild

rm:
	$(PS) --filter status=exited -aq | xargs $(RM)

rmi:
	$(IMAGES) -q | xargs $(RMI)

ps:
	$(PS) -a

stop:
	$(PS) -q | xargs $(STOP)

images:
	$(IMAGES)

# webserv
nginxbuild:
	$(BUILD) $(NGINX_PATH) -t nginx:$(IMG_TAG)

nginxrun:
	$(RUN) --name $(NGINX_CONTAINER) -p 443:443 -d nginx:$(IMG_TAG)

nginxstop:
	$(STOP) $(NGINX_CONTAINER)

nginxrm:
	$(RM) $(NGINX_CONTAINER)

nginxrmi:
	$(RMI) nginx:$(IMG_TAG)

nginxattach:
	$(EXEC) -it $(NGINX_CONTAINER) /bin/sh

# db
mariadbbuild:
	$(BUILD) $(MARIADB_PATH) -t mariadb:$(IMG_TAG)

mariadbrun:
	$(RUN) --name $(MARIADB_CONTAINER) -it mariadb:$(IMG_TAG)

mariadbstop:
	$(STOP) $(MARIADB_CONTAINER)

mariadbrm:
	$(RM) $(MARIADB_CONTAINER)

mariadbrmi:
	$(RMI) mariadb:$(IMG_TAG)

.PHONY: all mariadbbuild nginxbuild
.SILENT: nginxbuild nginxrun nginxstop nginxrm nginxrmi nginxattach mariadbbuild mariadbrun mariadbstop mariadbrm mariadbrmi rm rmi images ps stop

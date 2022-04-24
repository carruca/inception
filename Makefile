SRCS_PATH			= srcs/
REQS_PATH			= $(SRCS_PATH)requirements/
IMG_TAG				= dev

NGINX_PATH			= $(REQS_PATH)nginx/
NGINX_CONTAINER		= web_service

MARIADB_PATH		= $(REQS_PATH)mariadb/
MARIADB_CONTAINER	= db_service

WORDPRESS_PATH		= $(REQS_PATH)wordpress/
WORDPRESS_CONTAINER	= wordpress_service

DOCKER				= sudo docker

BUILD				= $(DOCKER) build
RUN					= $(DOCKER) run
STOP				= $(DOCKER) stop
RM					= $(DOCKER) rm
RMI					= $(DOCKER) rmi
PS					= $(DOCKER) ps
IMAGES				= $(DOCKER) images
EXEC				= $(DOCKER) exec
SYSTEM				= $(DOCKER) system

all: build

build:	mariadbbuild nginxbuild

prune:
	$(SYSTEM) prune

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

# web
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
	$(RUN) --name $(MARIADB_CONTAINER) -p 3306:3306 -d mariadb:$(IMG_TAG)

mariadbstop:
	$(STOP) $(MARIADB_CONTAINER)

mariadbrm:
	$(RM) $(MARIADB_CONTAINER)

mariadbrmi:
	$(RMI) mariadb:$(IMG_TAG)

mariadbattach:
	$(EXEC) -it $(MARIADB_CONTAINER) /bin/sh

# wordpress
wordpressbuild:
	$(BUILD) $(WORDPRESS_PATH) -t wordpress:$(IMG_TAG)

wordpressrun:
	$(RUN) --name $(WORDPRESS_CONTAINER) -p 3306:3306 -it wordpress:$(IMG_TAG)

wordpressstop:
	$(STOP) $(WORDPRESS_CONTAINER)

wordpressrm:
	$(RM) $(WORDPRESS_CONTAINER)

wordpressrmi:
	$(RMI) wordpress:$(IMG_TAG)

.PHONY: all mariadbbuild nginxbuild
.SILENT: nginxbuild nginxrun nginxstop nginxrm nginxrmi nginxattach mariadbbuild mariadbrun mariadbstop mariadbrm mariadbrmi wordpressbuild wordpressrun wordpressstop wordpressrm wordpressrmi rm rmi images ps stop prune

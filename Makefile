SRCS_PATH				= srcs/
REQS_PATH				= $(SRCS_PATH)requirements/
IMG_TAG					= dev

NGINX_PATH				= $(REQS_PATH)nginx/
NGINX_CONTAINER			= nginx

MARIADB_PATH			= $(REQS_PATH)mariadb/
MARIADB_CONTAINER		= mariadb
MARIADB_VOLUME_DIR		= mariadb_volume
MARIADB_VOLUME			= source=$(MARIADB_VOLUME_DIR),target=/var/lib/mysql

WORDPRESS_PATH			= $(REQS_PATH)wordpress/
WORDPRESS_CONTAINER		= wordpress
WORDPRESS_VOLUME_DIR	= wordpress_volume
WORDPRESS_VOLUME		= source=$(WORDPRESS_VOLUME_DIR),target=/var/www

DOCKER					= docker

BUILD					= $(DOCKER) build
RUN						= $(DOCKER) run
STOP					= $(DOCKER) stop
RM						= $(DOCKER) rm
RMI						= $(DOCKER) rmi
PS						= $(DOCKER) ps
IMAGES					= $(DOCKER) images
EXEC					= $(DOCKER) exec
SYSTEM					= $(DOCKER) system

CREATE					= $(DOCKER) network create
NETWORK_NAME			= inception-net

COMPOSE					= docker-compose
COMPOSE_PATH			= $(SRCS_PATH)$(COMPOSE).yml

all: build

up:
	$(COMPOSE) -f $(COMPOSE_PATH) up

re: stop rm build

build:	mariadbbuild wordpressbuild nginxbuild

run:	mariadbrun wordpressrun nginxrun

prune:
	$(SYSTEM) prune -a

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

net:
	$(CREATE) $(NETWORK_NAME)

volumerm:
	$(DOCKER) volume rm $(MARIADB_VOLUME_DIR) $(WORDPRESS_VOLUME_DIR)

# web
nginxbuild:
	$(BUILD) $(NGINX_PATH) -t nginx:$(IMG_TAG)

nginxrun:
	$(RUN) --name $(NGINX_CONTAINER) -p 80:80 -dit --network=$(NETWORK_NAME) --mount $(WORDPRESS_VOLUME) nginx:$(IMG_TAG)

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
	$(RUN) --name $(MARIADB_CONTAINER) -dit --network=$(NETWORK_NAME) --mount $(MARIADB_VOLUME) mariadb:$(IMG_TAG)

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
	$(RUN) --name $(WORDPRESS_CONTAINER) -dit --network=$(NETWORK_NAME) --mount $(WORDPRESS_VOLUME) wordpress:$(IMG_TAG)

wordpressstop:
	$(STOP) $(WORDPRESS_CONTAINER)

wordpressrm:
	$(RM) $(WORDPRESS_CONTAINER)

wordpressrmi:
	$(RMI) wordpress:$(IMG_TAG)

wordpressattach:
	$(EXEC) -it $(WORDPRESS_CONTAINER) /bin/sh

.PHONY: all mariadbbuild nginxbuild net
.SILENT: nginxbuild nginxrun nginxstop nginxrm nginxrmi nginxattach mariadbbuild mariadbrun mariadbstop mariadbrm mariadbrmi mariadbattach wordpressbuild wordpressrun wordpressstop wordpressrm wordpressrmi wordpressattach rm rmi images ps stop prune net volumerm

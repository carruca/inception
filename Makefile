SRCS_PATH				= srcs/
REQS_PATH				= $(SRCS_PATH)requirements/
IMG_TAG					= dev

NGINX_PATH				= $(REQS_PATH)nginx/
NGINX_CONTAINER			= nginx

MARIADB_PATH			= $(REQS_PATH)mariadb/
MARIADB_CONTAINER		= mariadb
MARIADB_VOLUME_PATH		= mariadb_volume
MARIADB_VOLUME			= source=$(MARIADB_VOLUME_PATH),target=/var/lib/mysql

WORDPRESS_PATH			= $(REQS_PATH)wordpress/
WORDPRESS_CONTAINER		= wordpress
WORDPRESS_VOLUME_PATH	= wordpress_volume
WORDPRESS_VOLUME		= source=$(WORDPRESS_VOLUME_PATH),target=/var/www

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

EDIT					= vim -O

CREATE					= $(DOCKER) network create
NETWORK_NAME			= inception-net

ENV_PATH				= srcs/.env

COMPOSE					= docker-compose
COMPOSE_PATH			= $(SRCS_PATH)$(COMPOSE).yml

all: build

up:
	$(COMPOSE) -f $(COMPOSE_PATH) --env-file $(ENV_PATH) up -d

build:
	$(COMPOSE) -f $(COMPOSE_PATH) --env-file $(ENV_PATH) up -d --build

down:
	$(COMPOSE) -f $(COMPOSE_PATH) down --rmi all

edit:
	$(EDIT) $(COMPOSE_PATH)

re: stop rm build

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
	$(DOCKER) volume rm $(MARIADB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH)

envedit:
	$(EDIT) $(ENV_PATH)

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

nginxedit:
	$(EDIT) $(NGINX_PATH)Dockerfile $(NGINX_PATH)conf/*

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

mariadbedit:
	$(EDIT) $(MARIADB_PATH)Dockerfile $(MARIADB_PATH)tools/*

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

wordpressedit:
	$(EDIT) $(WORDPRESS_PATH)Dockerfile $(WORDPRESS_PATH)conf/*

.PHONY: all mariadbbuild nginxbuild net
$(V).SILENT:

#.SILENT: nginxbuild nginxrun nginxstop nginxrm nginxrmi nginxattach nginxedit mariadbbuild mariadbrun mariadbstop mariadbrm mariadbrmi mariadbattach mariadbedit wordpressbuild wordpressrun wordpressstop wordpressrm wordpressrmi wordpressattach wordpressedit rm rmi images ps stop prune net volumerm

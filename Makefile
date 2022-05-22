SRCS_PATH				= srcs/
REQS_PATH				= $(SRCS_PATH)requirements/
IMG_TAG					= dev
VOLUME_PATH				= ${HOME}/data

NGINX_PATH				= $(REQS_PATH)nginx/
NGINX_CONTAINER			= nginx
NGINX_IMAGE				= $(NGINX_CONTAINER)

MARIADB_PATH			= $(REQS_PATH)mariadb/
MARIADB_CONTAINER		= mariadb
MARIADB_IMAGE			= $(MARIADB_CONTAINER)
MARIADB_VOLUME			= mariadb-volume
MARIADB_VOLUME_PATH		= $(VOLUME_PATH)/mariadb

WORDPRESS_PATH			= $(REQS_PATH)wordpress/
WORDPRESS_CONTAINER		= wordpress
WORDPRESS_IMAGE			= $(WORDPRESS_CONTAINER)
WORDPRESS_VOLUME		= wordpress-volume
WORDPRESS_VOLUME_PATH	= $(VOLUME_PATH)/wordpress

DOCKER					= docker
STOP					= $(DOCKER) stop
RM						= $(DOCKER) rm
RMI						= $(DOCKER) rmi
IMAGES					= $(DOCKER) images
EXEC					= $(DOCKER) exec
SYSTEM					= $(DOCKER) system
VOLUME					= $(DOCKER) volume

EDIT					= vim -O

ENV_PATH				= srcs/.env

COMPOSE_PATH			= $(SRCS_PATH)docker-compose.yml
COMPOSE					= docker-compose -f $(COMPOSE_PATH)

all: build

build:
	$(COMPOSE) --env-file $(ENV_PATH) up -d --build

up:
	$(COMPOSE) --env-file $(ENV_PATH) up -d

down:
	$(COMPOSE) down

ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs

edit:
	$(EDIT) $(COMPOSE_PATH)

envedit:
	$(EDIT) $(ENV_PATH)

prune:
	$(SYSTEM) prune -a

rm:
	$(PS) --filter status=exited -aq | xargs $(RM)

rmi:
	$(IMAGES) -q | xargs $(RMI)

stop:
	$(PS) -q | xargs $(STOP)

clean: stop rm

re: clean build

volumerm:
	$(VOLUME) rm $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
	sudo rm -r $(MARIADB_VOLUME_PATH)/* $(WORDPRESS_VOLUME_PATH)/*

images:
	$(IMAGES)

# nginx
nginxstop:
	$(STOP) $(NGINX_CONTAINER)

nginxrm:
	$(RM) $(NGINX_CONTAINER)

nginxrmi:
	$(RMI) $(NGINX_IMAGE):$(IMG_TAG)

nginxattach:
	$(EXEC) -it $(NGINX_CONTAINER) /bin/sh

nginxedit:
	$(EDIT) $(NGINX_PATH)Dockerfile $(NGINX_PATH)conf/*

# mariadb
mariadbstop:
	$(STOP) $(MARIADB_CONTAINER)

mariadbrm:
	$(RM) $(MARIADB_CONTAINER)

mariadbrmi:
	$(RMI) $(MARIADB_IMAGE):$(IMG_TAG)

mariadbattach:
	$(EXEC) -it $(MARIADB_CONTAINER) /bin/sh

mariadbedit:
	$(EDIT) $(MARIADB_PATH)Dockerfile $(MARIADB_PATH)tools/*

# wordpress
wordpressstop:
	$(STOP) $(WORDPRESS_CONTAINER)

wordpressrm:
	$(RM) $(WORDPRESS_CONTAINER)

wordpressrmi:
	$(RMI) $(WORDPRESS_IMAGE):$(IMG_TAG)

wordpressattach:
	$(EXEC) -it $(WORDPRESS_CONTAINER) /bin/sh

wordpressedit:
	$(EDIT) $(WORDPRESS_PATH)Dockerfile $(WORDPRESS_PATH)conf/*

$(V).SILENT:
.PHONY:

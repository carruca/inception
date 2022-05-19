#!/bin/bash

if [[ !$(env | grep DISTRO) && "$DISTRO" != ubuntu && "$DISTRO" != debian ]];
then 
	echo "Please export a valid linux distro: < DISTRO=ubuntu > or < DISTRO=debian > ]";
	exit 1;
else
	sudo apt-get remove \
		docker \
		docker-engine \
		docker.io \
		containerd \
		runc;

	sudo apt-get update;

	sudo apt-get install -y \
		ca-certificates \
		curl \
		gnupg \
		lsb-release;

	sudo curl -fsSL https://download.docker.com/linux/${DISTRO}/gpg \
		| sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;

	echo \
		"deb [arch=$(dpkg --print-architecture) \
		signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
		https://download.docker.com/linux/${DISTRO} \
		$(lsb_release -cs) stable" \
		| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

	sudo apt-get update;

	sudo apt-get install -y \
		docker-ce \
		docker-ce-cli \
		containerd.io;

unset DISTRO;
fi

#!/usr/bin/env bash
eval $(docker-machine env swarm-1)

docker network create --driver overlay proxy

docker service create --name proxy \
	-p 80:80 \
	-p 443:443 \
	-p 8080:8080 \
	--network proxy \
	-e MODE=swarm \
	--replicas 3 \
	-e CONSUL_ADDRESS="$(docker-machine ip swarm-1):8500,\
		$(docker-machine ip swarm-2):8500, \
		$(docker-machine ip swarm-3):8500" \
		vfarcic/docker-flow-proxy
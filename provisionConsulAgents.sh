#!/usr/bin/env bash

export CONSUL_SERVER_IP=$(docker-machine ip swarm-1)
for i in 2 3; do
	eval $(docker-machine env swarm-$i)
	export DOCKER_IP=$(docker-machine ip swarm-$i)
		docker-compose -f docker-compose-proxy.yml \
		up -d consul-agent
done

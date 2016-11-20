#!/usr/bin/env bash

export CONSUL_SERVER_IP=$(docker-machine ip swarm-1)

eval $(docker-machine env swarm-1)
export DOCKER_IP=$(docker-machine ip swarm-1)
	docker-compose -f docker-compose-proxy.yml up -d consul-server

#!/usr/bin/env bash
docker network create --driver overlay go-demo

docker service create --name go-demo-db \
	--network go-demo \
	mongo:3.2.10

docker service create --name go-demo \
	-e DB=go-demo-db \
	--network go-demo \
	 --network proxy \
	 vfarcic/go-demo:1.0

#reconfigure HA Proxy
curl "$(docker-machine ip swarm-1):8080/v1/docker-flow-proxy/reconfigure?service\
	Name=go-demo&servicePath=/demo&port=8080&distribute=true"	| jq

# Distribute=true, when specified, the proxy will accept the
# request, reconfigure itself, and resend the request to all other instances.
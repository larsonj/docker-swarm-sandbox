#!/usr/bin/env bash
docker service create --name jenkins \
   -p 8082:8080 \
   -p 50000:50000 \
   -e JENKINS_OPTS="--prefix=/jenkins" \
   --mount "type=bind,source=$PWD/docker/jenkins,target=/var/jenkins_home" \
   --reserve-memory 300m \
   jenkins:2.7.4-alpine
docker service ps jenkins
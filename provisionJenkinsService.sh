#!/usr/bin/env bash
docker service create --name jenkins \
   -p 8082:8080 \
   -p 50000:50000 \
   -e JENKINS_OPTS="--prefix=/jenkins" \
   --mount "type=bind,source=$PWD/docker/jenkins,target=/var/jenkins_home" \
   --reserve-memory 300m \
   jenkins:2.7.4-alpine
docker service ps jenkins


docker service create --name jenkins-agent -e COMMAND_OPTIONS="-master http://192.168.99.100:8082/jenkins -username admin -password admin -labels 'docker' -executors 5" \
   --mode global \
   --constraint 'node.labels.env == jenkins-agent' \
   --mount type=bind,source="/var/run/docker.sock,target=/var/run/docker.sock" \
   --mount type=bind,source="/Users/jcl/.docker/machine/machines,target=/machines" \
   --mount type=bind,source="/workspace,target=/workspace" \
   vfarcic/jenkins-swarm-agent

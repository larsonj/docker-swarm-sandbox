#!/usr/bin/env bash
docker service create --name registry \
   -p 5000:5000 \
   --reserve-memory 100m \
   --mount "type=bind,source=$PWD,target=/var/lib/registry" \
   registry:2.5.0
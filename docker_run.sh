#!/bin/bash
# Sample run script.  Primarly used in build / testing

docker rm ark
docker run -it -p 7777-7778:7777-7778/udp -p 27015:27015/udp -p 27020:27020 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t Island" \
-e MAP="TheIsland" \
-e ADDITIONAL_OPTS="?AltSaveDirectoryName=TheIsland" \
-e ADDITIONAL_ARGS="-clusterid=t3stn3t -ClusterDirOverride=/ark/cluster" \
--name ark \
antimodes201/ark-server:latest

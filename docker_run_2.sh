#!/bin/bash
# Sample run script.  Primarly used in build / testing

docker rm ark2
docker run -it -p 7779-7780:7779-7780/udp -p 27016:27016/udp -p 27021:27021 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t Ragnarok" \
-e TYPE="SLAVE" \
-e MAP="Ragnarok" \
-e ADDITIONAL_OPTS="?AltSaveDirectoryName=Ragnarok" \
-e ADDITIONAL_ARGS="-clusterid=t3stn3t -ClusterDirOverride=/ark/cluster" \
-e GAME_PORT="7779" \
-e GAME_PORT2="7780" \
-e QUERY_PORT="27016" \
-e RCON_PORT="27021" \
--name ark2 \
antimodes201/ark-server:latest

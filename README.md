# ark-server
Docker container for a basic Ark Server

Build to create a containerized version of the dedicated server for Ark
https://store.steampowered.com/app/346110/ARK_Survival_Evolved/
 
 
Build by hand
```
git clone https://github.com/antimodes201/ark-server.git
docker build -t antimodes201/ark-server:latest .
``` 
 
Docker Pull
```
docker pull antimodes201/ark-server
```
 
Docker Run with defaults 
change the volume options to a directory on your node and maybe use a different name then the one in the example
 
```
docker run -it -p 7777-7778:7777-7778/udp -p 27015:27015/udp -p 27020:27020 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t A Fancy Ark Server in a Docker Container" \
--name ark \
antimodes201/ark-server:latest
```
 
If you would like to use a different map besides the default Island then you will need to add the map environment variable.
```
docker run -it -p 7777-7778:7777-7778/udp -p 27015:27015/udp -p 27020:27020 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t A Fancy Ark Server in a Docker Container" \
-e MAP=Ragnarok \
--name ark \
antimodes201/ark-server:latest
```
 
Additional launch arguments can be used to further modify the server at run time.  These are broken into launch arguments that start with - and launch options that start with a ?.
Example to enable Valentine's Even and set an alternative save directory.
```
docker run -it -p 7777-7778:7777-7778/udp -p 27015:27015/udp -p 27020:27020 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t A Fancy Ark Server in a Docker Container" \
-e ADDITIONAL_OPTS="?AltSaveDirectoryName=TheIsland" \
-e ADDITIONAL_ARGS="-activeevent=vday" \
--name ark \
antimodes201/ark-server:latest
```
 
The container supports hosting a cluster from different nodes.  In order to do this you will need to set a clusterid with the ADDITIONAL_ARG and set the AltSaveDir with ADDITIONAL_OPTS.  In order to prevent two containers from overriding each other on update a MASTER node must be selected.  Failure to do so can result in corruption of the install volume.
Example
Node 1
```
docker run -it -p 7777-7778:7777-7778/udp -p 27015:27015/udp -p 27020:27020 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t TheIsland in a Docker Container" \
-e TYPE="MASTER" \
-e MAP="TheIsland" \
-e ADDITIONAL_OPTS="?AltSaveDirectoryName=TheIsland" \
-e ADDITIONAL_ARGS="-clusterid=t3stn3t" \
--name ark \
antimodes201/ark-server:latest
```
 
Node 2
```
docker run -it -p 7779-7780:7779-7780/udp -p 27016:27016/udp -p 27021:27021 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t Ragnarok" \
-e TYPE="SLAVE" \
-e MAP="Ragnarok" \
-e ADDITIONAL_OPTS="?AltSaveDirectoryName=Ragnarok" \
-e ADDITIONAL_ARGS="-clusterid=t3stn3t" \
-e GAME_PORT="7779" \
-e GAME_PORT2="7780" \
-e QUERY_PORT="27016" \
-e RCON_PORT="27021" \
--name ark2 \
antimodes201/ark-server:latest
```
  
Currently exposed environmental variables and their default values
- INSTANCE_NAME default
- TYPE MASTER
- GAME_PORT 7777
- GAME_PORT2 7778
- QUERY_PORT 27015
- RCON_PORT 27020
- MAP TheIsland
- TZ America/New_York

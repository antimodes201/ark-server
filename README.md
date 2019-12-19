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
 
If you would like to use a different map besides the default then you will need to add the map environment variable.
```
docker run -it -p 7777-7778:7777-7778/udp -p 27015:27015/udp -p 27020:27020 -v /app/docker/temp-vol:/ark \
-e INSTANCE_NAME="T3stN3t A Fancy Ark Server in a Docker Container" \
-e MAP=Ragnarok \
--name ark \
antimodes201/ark-server:latest
```
  
Currently exposed environmental variables and their default values
- INSTANCE_NAME default
- GAME_PORT 7777
- GAME_PORT2 7778
- QUERY_PORT 27015
- RCON_PORT 27020
- MAP TheIsland
- TZ America/New_York

#!/bin/bash -ex
# Start script for Ark called from docker

# Move steamcmd install to startup
if [ ! -f /ark/steamcmd/steamcmd.sh ]
then
	# no steamcmd
	printf "SteamCMD not found, installing\n"
	mkdir /ark/steamcmd/
	cd /ark/steamcmd/
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	rm steamcmd_linux.tar.gz
fi
	

#check if master
if [ ${TYPE} == "MASTER" ]
then
	/ark/steamcmd/steamcmd.sh +login anonymous +force_install_dir /ark +app_update 376030 +quit
fi


# -automanagedmods fixes
if [ ! -f  /ark/Engine/Binaries/ThirdParty/SteamCMD/Linux/steamcmd.sh ]
then
	mkdir -p /ark/Engine/Binaries/ThirdParty/SteamCMD/Linux
	cd /ark/Engine/Binaries/ThirdParty/SteamCMD/Linux
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	mkdir /ark/mods
fi

mkdir -p /home/steamuser/Steam/steamapps/
ln -sf /ark/mods /home/steamuser/Steam/steamapps/workshop

# Launch Server
# Variables pulled from Docker environment
cd /ark/ShooterGame/Binaries/Linux
/ark/ShooterGame/Binaries/Linux/ShooterGameServer ${MAP}?listen?Port=${GAME_PORT}?QueryPort=${QUERY_PORT}?RCONPort=${RCON_PORT}?SessionName=\"${INSTANCE_NAME}\"${ADDITIONAL_OPTS} ${ADDITIONAL_ARGS} ${BattleEye} -nosteamclient -server -log -servergamelog

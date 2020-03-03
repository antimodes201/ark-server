#!/bin/bash
# Start script for Ark called from docker

#check if master
if [ ${TYPE} == "MASTER" ]
then
	/steamcmd/steamcmd.sh +login anonymous +force_install_dir /ark +app_update 376030 +quit
fi

# Launch Server
# Variables pulled from Docker environment
/ark/ShooterGame/Binaries/Linux/ShooterGameServer ${MAP}?listen?Port=${GAME_PORT}?QueryPort=${QUERY_PORT}?RCONPort=${RCON_PORT}?SessionName=\"${INSTANCE_NAME}\"${ADDITIONAL_OPTS} ${ADDITIONAL_ARGS} -NoBattlEye -nosteamclient -server -log

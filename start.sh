#!/bin/bash

/steamcmd/steamcmd.sh +login anonymous +force_install_dir /ark +app_update 376030 +quit

# Launch Server
# Variables pulled from Docker environment
/ark/ShooterGame/Binaries/Linux/ShooterGameServer ${MAP}?listen?Port=${GAME_PORT}?QueryPort=${QUERY_PORT}?SessionName=\"${INSTANCE_NAME}\" ${ADDITIONAL_ARGS} -NoBattlEye -nosteamclient -server -log

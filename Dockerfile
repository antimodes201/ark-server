FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

ARG GAME_PORT=7777
ARG GAME_PORT2=7778
ARG QUERY_PORT=27015
ARG RCON_PORT=27020

# Set some Variables
ENV BRANCH "public"
ENV INSTANCE_NAME "default"
ENV GAME_PORT $GAME_PORT
ENV GAME_PORT2 $GAME_PORT2
ENV QUERY_PORT $QUERY_PORT
ENV RCON_PORT $RCON_PORT
ENV MAP "TheIsland"
ENV ADDITIONAL_OPTS ""
ENV ADDITIONAL_ARGS ""
ENV TZ "America/New_York"
ENV TYPE "MASTER"
ENV BattleEye "-NoBattlEye"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		lib32gcc1 \
		wget \
		unzip \
		tzdata \
		ca-certificates && \
		rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /steamcmd \
        && mkdir -p /ark \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /ark \
        && chown steamuser:steamuser /steamcmd \
		&& chown steamuser:steamuser /scripts 

# Install Steamcmd 
# depreciated.  Moved into start script
USER steamuser

# -automanagedmods fixes
RUN mkdir -p ~/.steam/sdk32/

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $GAME_PORT/udp
EXPOSE $GAME_PORT2/udp
EXPOSE $QUERY_PORT/udp
EXPOSE $RCON_PORT/tcp

# Make a volume
# contains configs and world saves
VOLUME /ark

CMD ["/scripts/start.sh"]

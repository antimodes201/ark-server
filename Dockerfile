FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

# Set some Variables
ENV BRANCH "public"
ENV INSTANCE_NAME "default"
ENV GAME_PORT "7777"
ENV GAME_PORT2 "7778"
ENV QUERY_PORT "27015"
ENV RCON_PORT "27020"
ENV MAP "TheIsland"
ENV ADDITIONAL_ARGS ""
ENV TZ "America/New_York"

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
        && mkdir -p /APPDIR \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /APPDIR \
        && chown steamuser:steamuser /steamcmd \
		&& chown steamuser:steamuser /scripts 

# Install Steamcmd
USER steamuser
RUN cd /steamcmd && \
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
	tar -xf steamcmd_linux.tar.gz && \
	rm steamcmd_linux.tar.gz && \
	/steamcmd/steamcmd.sh +quit

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE ${GAME_PORT}/udp
EXPOSE ${GAME_PORT2}/udp
EXPOSE ${QUERY_PORT}/udp
EXPOSE ${RCON_PORT}/tcp

# Make a volume
# contains configs and world saves
VOLUME /APPDIR

CMD ["/scripts/start.sh"]

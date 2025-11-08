FROM ubuntu:bionic

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Expose Unturned ports
EXPOSE 27015
EXPOSE 27016

# Install required packages
RUN apt-get update && \
    apt-get install -y unzip tar curl coreutils lib32gcc1 libgdiplus && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add Steam user
RUN adduser \
    --home /home/steam \
    --disabled-password \
    --shell /bin/bash \
    --gecos "user for running steam" \
    --quiet \
    steam

# Switch to Steam user
USER steam

# Create directories
RUN mkdir -p /home/steam/steamcmd /home/steam/Unturned

WORKDIR /home/steam/steamcmd

# Install Unturned
RUN curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    bash ./steamcmd.sh +force_install_dir $GAME_INSTALL_DIR +login $STEAM_USERNAME $STEAM_PASSWORD $STEAM_GUARD_TOKEN $STEAM_CMD_ARGS +@sSteamCmdForcePlatformBitness 64 +app_update $GAME_ID +quit && \
    mkdir -p /home/steam/.steam/sdk64/ && \
    cp -f linux64/steamclient.so /home/steam/.steam/sdk64/steamclient.so

WORKDIR $STEAMCMD_DIR

COPY init.sh .

ENTRYPOINT ["./init.sh"]

VOLUME ["/home/steam/Unturned"]
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME_DIR=/home/steam
ENV GAME_INSTALL_DIR=$HOME_DIR/Unturned
ENV SERVER_NAME=server
ENV GAME_ID=1110390
ENV STEAMCMD_DIR=$HOME_DIR/steamcmd
ENV AUTOSAVE_INTERVAL=300

# Install required packages
RUN apt-get update && \
    apt-get install -y unzip tar curl coreutils lib32gcc-s1 libgdiplus screen && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add Steam user
RUN adduser \
    --home $HOME_DIR \
    --disabled-password \
    --shell /bin/bash \
    --gecos "user for running steam" \
    --quiet \
    steam

# Create install directory + steamapps subdir + ensure ownership
RUN mkdir -p $GAME_INSTALL_DIR/Servers && \
    chown -R steam:steam $GAME_INSTALL_DIR && \
    ln -s $GAME_INSTALL_DIR/Servers /data && \
    chmod 755 $GAME_INSTALL_DIR/Servers

USER steam

WORKDIR $STEAMCMD_DIR

RUN mkdir -p $GAME_INSTALL_DIR

# Install Unturned
RUN curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    bash ./steamcmd.sh +force_install_dir $GAME_INSTALL_DIR +login anonymous $STEAM_CMD_ARGS +@sSteamCmdForcePlatformBitness 64 +app_update $GAME_ID validate +quit && \
    mkdir -p $HOME_DIR/.steam/sdk64/ && \
    cp -f $GAME_INSTALL_DIR/linux64/steamclient.so $HOME_DIR/.steam/sdk64/steamclient.so

WORKDIR $STEAMCMD_DIR

COPY --chmod=755 init.sh .

ENTRYPOINT ["./init.sh"]

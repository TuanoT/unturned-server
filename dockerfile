# --- Dockerfile for Unturned Dedicated Server ---

FROM ubuntu:22.04
LABEL maintainer="Tom <tom@unturned-server.local>"

ENV STEAMCMD_DIR=/home/steam/steamcmd
ENV GAME_INSTALL_DIR=/home/steam/Unturned

ENV GAME_ID=1110390
ENV DEBIAN_FRONTEND=noninteractive
ENV SERVER_NAME=MelbourneVanilla
ENV STEAM_USERNAME=anonymous

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    wget curl tar ca-certificates lib32gcc-s1 libgdiplus mono-complete screen && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# Create steam user
RUN useradd -m steam
USER steam
WORKDIR /home/steam

# Install SteamCMD
RUN mkdir -p ${STEAMCMD_DIR} && \
    cd ${STEAMCMD_DIR} && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz

# Copy initialization script
COPY --chown=steam:steam init.sh ${STEAMCMD_DIR}/init.sh
RUN chmod +x ${STEAMCMD_DIR}/init.sh

# Create a volume for the game installation
VOLUME ["${GAME_INSTALL_DIR}"]

WORKDIR ${STEAMCMD_DIR}
ENTRYPOINT ["./init.sh"]
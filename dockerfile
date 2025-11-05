FROM ubuntu:22.04

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
    wget unzip screen libmono2.0-cil mono-runtime \
    libstdc++6:i386 libgcc1:i386 libncurses5:i386 zlib1g:i386 \
    libgl1-mesa-glx:i386 libxrandr2:i386 libxcursor1:i386 \
    && rm -rf /var/lib/apt/lists/*

# Create app directories
RUN mkdir -p /steamcmd /unturned
WORKDIR /steamcmd

# Install SteamCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz

# Copy scripts
COPY entrypoint.sh /entrypoint.sh
COPY update.sh /update.sh
RUN chmod +x /entrypoint.sh /update.sh

# Environment defaults
ENV STEAM_APP_ID=304930 \
    UNTURNED_DIR=/unturned \
    PORT=27015 \
    PLAYERS=16 \
    MAP=pei \
    MODE=normal \
    PVE=true

EXPOSE 27015/udp 27016/tcp

ENTRYPOINT ["/entrypoint.sh"]
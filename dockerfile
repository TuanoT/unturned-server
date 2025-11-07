# Unturned Dedicated Server (latest) — Vanilla
FROM ubuntu:22.04

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget curl unzip ca-certificates lib32gcc-s1 libgdiplus libmono-system-data-datasetextensions4.0-cil \
    mono-complete screen libstdc++6:i386 libgcc-s1:i386 zlib1g:i386 && \
    rm -rf /var/lib/apt/lists/*

# Create steam user
RUN useradd -m steam

# Add startup script
COPY init.sh /home/steam/init.sh
RUN chmod +x /home/steam/init.sh && chown steam:steam /home/steam/init.sh

# Switch to steam user
USER steam
WORKDIR /home/steam

# Install SteamCMD
RUN mkdir -p /home/steam/steamcmd && \
    cd /home/steam/steamcmd && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz

# Create Unturned directory
RUN mkdir -p /home/steam/Unturned

# Default working directory
WORKDIR /home/steam/Unturned

# Ports
EXPOSE 27015/udp 27016/udp

# Run script
ENTRYPOINT ["/home/steam/init.sh"]


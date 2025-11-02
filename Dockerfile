# Base image
FROM ubuntu:22.04

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    wget unzip screen htop \
    build-essential gcc-multilib libstdc++6:i386 libgcc1:i386 libncurses5:i386 zlib1g:i386 \
    libmono2.0-cil mono-runtime \
    libc6:i386 libgl1-mesa-glx:i386 libxrandr2:i386 libxcursor1:i386

# Create working directory
WORKDIR /unturned

# Download SteamCMD
RUN mkdir steamcmd && cd steamcmd && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz

# Copy start and update scripts
COPY start.sh update.sh /unturned/
RUN chmod +x start.sh update.sh

# Expose default Unturned port
EXPOSE 27015/udp

# Default command
CMD ["./start.sh"]

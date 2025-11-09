FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    lib32gcc-s1 \
    wget \
    tar \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Set locale 
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create directories and add user
RUN mkdir -p /steamcmd /unturned
RUN useradd -m -d /home/unturned -s /bin/bash unturned
RUN chown -R unturned:unturned /steamcmd /unturned

USER unturned
WORKDIR /home/unturned

# Install SteamCMD and Unturned
RUN wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz -C /steamcmd
RUN /steamcmd/steamcmd.sh +force_install_dir /unturned +login anonymous +app_update 1110390 validate +quit

# Copy Steam client library to users folder so Unturned doesn't complain
RUN mkdir -p /home/unturned/.steam/sdk64
RUN cp /unturned/steamclient.so /home/unturned/.steam/sdk64/steamclient.so
RUN chmod +r /home/unturned/.steam/sdk64/steamclient.so

# Expose ports
EXPOSE 27015-27016/tcp
EXPOSE 27015-27016/udp

# Set working directory and startup command
WORKDIR /unturned
ENTRYPOINT ["./Unturned_Headless.x86_64", "-nographics", "-batchmode", "+InternetServer/MyServer"]
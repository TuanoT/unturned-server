# Unturned Dedicated Server Using Docker

Run an Unturned dedicated server with Docker.

## Build the Docker image
```bash
docker build -t tuano/unturned-server .
```

## Run the container

Use -p to expose TCP and UDP ports, 27015 and 27016 are default.

Use -v to mount Unturned Server files somewhere on the host machine (~/unturned-data in example).

```bash
docker run -it \
  -p 27015-27016:27015-27016/tcp \
  -p 27015-27016:27015-27016/udp \
  -v ~/unturned-data:/server \
  -e SERVER_NAME="MelbourneVanilla" \
  --restart unless-stopped \
  tuanot/unturned-server
```

## Configuring the server

Navigate to /Servers/MyServer in either the mount on your host machine or inside /server in the container depending on whether you mounted Unturned's server files. In /Servers/MyServer, you will find Config.txt and Server/Commands.dat. Inside Config.txt you should put your Steam Game Server Token if you have one, and change any game settings you want. Inside Command.dat you can set server map, name and difficulty.

Bullshit with -it and attach for save
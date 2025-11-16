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
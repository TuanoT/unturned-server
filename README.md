# Unturned Dedicated Server Using Docker

Run an Unturned dedicated server with Docker.

## Build the Docker image
```bash
docker build -t tuanot/unturned-server .
```

## Run the container
```bash
docker run -d \
  -p 27015-27016:27015-27016/tcp \
  -p 27015-27016:27015-27016/udp \
  -v ~/unturned-data:/server \
  tuanot/unturned-server
```
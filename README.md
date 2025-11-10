# Unturned Dedicated Server Using Docker

Run an Unturned dedicated server with Docker, fully persistent and easy to use.

## Build the Docker image
```bash
docker build -t unturned-server .
```

Run the container

docker run -d \
  -p 27015-27016:27015-27016/tcp \
  -p 27015-27016:27015-27016/udp \
  -v ~/unturned-data:/server \
  -e SERVER_NAME="MelbourneVanilla" \
  -e MAP="Washington" \
  -e GSLT="YOUR_GSLT_TOKEN" \
  unturned-server

Environment Variables
Variable	Default	Description
SERVER_NAME	MelbourneVanilla	Name of your Unturned server
MAP	Washington	Map to load (PEI, Washington, Russia, Germany, Yukon)
GSLT	(empty)	Game Server Login Token (required for public servers)
Features

    Persistent server data in ~/unturned-data

    Automatically fixes permissions on host-mounted folders

    Runs as non-root user inside the container

    Easy configuration via environment variables

Notes

    Make sure ports 27015–27016 TCP/UDP are forwarded in your router for external players.

    No manual permission changes are needed — the container handles it automatically.
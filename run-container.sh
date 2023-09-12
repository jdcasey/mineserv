#!/bin/bash

exec podman run -ti --rm "$@" -p 25575:25575/tcp -p 25565:25565/tcp -p 25565:25565/udp -p 19132:19132/udp mineserv:local

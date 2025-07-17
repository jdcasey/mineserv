#!/bin/bash

exec podman run -ti --rm "$@" -p 25565:25565/tcp -p 25565:25565/udp -p 25565:25575/tcp -p 25565:25575/udp -v /home/jdcasey/minecraft:/world:z mineserv:local

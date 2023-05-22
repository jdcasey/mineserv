FROM docker.io/openjdk:17-jdk-slim

#RUN dnf -y update && \
#	dnf -y install java-latest-openjdk-headless && \
RUN	mkdir -p /usr/local/lib/mineserv/mods && \
	mkdir -p /usr/local/lib/mineserv/etc && \
	mkdir -p /usr/local/bin

ARG minecraft_ver=1.19.4
ARG fabric_ver=0.14.19
ARG installer_ver=0.11.2

ADD eula.txt /usr/local/lib/mineserv/etc
ADD https://meta.fabricmc.net/v2/versions/loader/$minecraft_ver/$fabric_ver/$installer_ver/server/jar /usr/local/lib/mineserv/fabric.jar
ADD start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

EXPOSE 25565/tcp
EXPOSE 19132/udp
EXPOSE 19133/udp
EXPOSE 25565/udp

#USER 1000

ENV SERVER_ARGS=nogui
ENV JVM_OPTS="-Xmx8G -Xms8G"

ADD mods /usr/local/lib/mineserv/mods
ADD https://github.com/CaffeineMC/sodium-fabric/releases/download/mc1.19.4-0.4.11/sodium-fabric-mc1.19.4-0.4.11+build.26.jar /usr/local/lib/mineserv/mods
ADD https://github.com/comp500/Indium/releases/download/1.0.15%2Bmc1.19.4/indium-1.0.15+mc1.19.4.jar /usr/local/lib/mineserv/mods
ADD https://github.com/CaffeineMC/lithium-fabric/releases/download/mc1.19.4-0.11.1/lithium-fabric-mc1.19.4-0.11.1.jar /usr/local/lib/mineserv/mods
#ADD https://github.com/CaffeineMC/phosphor-fabric/releases/download/mc1.19.x-0.8.1/phosphor-fabric-mc1.19.x-0.8.1.jar /usr/local/lib/mineserv/mods
ADD https://cdn.modrinth.com/data/H8CaAYZC/versions/1.1.1%2B1.19/starlight-1.1.1%2Bfabric.ae22326.jar /usr/local/lib/mineserv/mods

ENTRYPOINT /usr/local/bin/start.sh
#ENTRYPOINT /bin/bash

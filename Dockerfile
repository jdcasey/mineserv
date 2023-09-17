FROM docker.io/openjdk:17-jdk-slim

#RUN dnf -y update && \
#	dnf -y install java-latest-openjdk-headless && \
RUN	mkdir -p /usr/local/lib/mineserv/mods && \
	mkdir -p /usr/local/lib/mineserv/etc && \
	mkdir -p /usr/local/bin

ARG minecraft_ver=1.20.1
ARG fabric_ver=0.14.22
ARG installer_ver=0.11.2

ADD eula.txt /usr/local/lib/mineserv/etc
ADD https://meta.fabricmc.net/v2/versions/loader/$minecraft_ver/$fabric_ver/$installer_ver/server/jar /usr/local/lib/mineserv/fabric.jar
ADD start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

EXPOSE 25565/tcp
EXPOSE 19132/udp
EXPOSE 25565/udp

#USER 1000

ENV SERVER_ARGS=nogui
ENV JVM_OPTS="-Xmx4G -Xms4G"

ADD mods /usr/local/lib/mineserv/mods
ADD shared-mods /usr/local/lib/mineserv/mods

ADD https://github.com/CaffeineMC/sodium-fabric/releases/download/mc1.20.1-0.5.2/sodium-fabric-mc1.20.1-0.5.2.jar /usr/local/lib/mineserv/mods
ADD https://github.com/comp500/Indium/releases/download/1.0.25%2Bmc1.20.1/indium-1.0.25+mc1.20.1.jar /usr/local/lib/mineserv/mods
ADD https://github.com/CaffeineMC/lithium-fabric/releases/download/mc1.20.1-0.11.2/lithium-fabric-mc1.20.1-0.11.2.jar /usr/local/lib/mineserv/mods

ADD https://github.com/IrisShaders/Iris/releases/download/1.6.8%2B1.20.1/iris-mc1.20.1-1.6.8.jar /usr/local/lib/mineserv/mods

ADD https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot /usr/local/lib/mineserv/mods
ADD https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot /usr/local/lib/mineserv/mods

ENTRYPOINT /usr/local/bin/start.sh
#ENTRYPOINT /bin/bash

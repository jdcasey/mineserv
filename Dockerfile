FROM fedora-minimal:latest
#FROM docker.io/openjdk:21-jdk-slim

RUN microdnf -y update && \
	microdnf -y install java-latest-openjdk-headless

RUN	mkdir -p /usr/local/lib/mineserv/mods && \
	mkdir -p /usr/local/lib/mineserv/init-etc && \
	mkdir -p /usr/local/bin && \
	mkdir /world && \
	mkdir /config

ARG minecraft_ver=1.21.1
ARG fabric_ver=0.16.14
ARG installer_ver=1.1.0

#ADD fabric.jar /usr/local/lib/mineserv/fabric.jar
ADD https://meta.fabricmc.net/v2/versions/loader/$minecraft_ver/$fabric_ver/$installer_ver/server/jar /usr/local/lib/mineserv/fabric.jar

ADD start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

EXPOSE 25565/tcp
EXPOSE 25565/udp
EXPOSE 25575/tcp
EXPOSE 25575/udp

VOLUME /world
VOLUME /config

#USER 1000

ENV SERVER_ARGS=nogui
ENV JVM_OPTS="-Xmx8G -Xms8G -XX:+UseShenandoahGC --enable-native-access=ALL-UNNAMED"

ADD core-mods /usr/local/lib/mineserv/mods

ADD initial-server-config /usr/local/lib/mineserv/init-etc
# ADD server-config /usr/local/lib/mineserv/etc

#ADD https://github.com/CaffeineMC/sodium-fabric/releases/download/mc1.20.1-0.5.2/sodium-fabric-mc1.20.1-0.5.2.jar /usr/local/lib/mineserv/mods
#ADD https://github.com/comp500/Indium/releases/download/1.0.25%2Bmc1.20.1/indium-1.0.25+mc1.20.1.jar /usr/local/lib/mineserv/mods
#ADD https://github.com/CaffeineMC/lithium-fabric/releases/download/mc1.20.1-0.11.2/lithium-fabric-mc1.20.1-0.11.2.jar /usr/local/lib/mineserv/mods

#ADD https://github.com/IrisShaders/Iris/releases/download/1.6.8%2B1.20.1/iris-mc1.20.1-1.6.8.jar /usr/local/lib/mineserv/mods

#ADD https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot /usr/local/lib/mineserv/mods
#ADD https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot /usr/local/lib/mineserv/mods

ENTRYPOINT /usr/local/bin/start.sh
#ENTRYPOINT /bin/bash

FROM fedora:latest

RUN dnf -y update && \
	dnf -y install java-latest-openjdk-headless && \
	mkdir -p /usr/local/lib/mineserv/plugins && \
	mkdir -p /usr/local/bin


ADD plugins /usr/local/lib/mineserv/plugins
ADD paper.jar /usr/local/lib/mineserv/paper.jar
#ADD https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/170/downloads/paper-1.20.1-170.jar /usr/local/lib/mineserv/paper.jar
ADD start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

EXPOSE 25565/tcp
EXPOSE 19132/udp
EXPOSE 19133/udp
EXPOSE 25565/udp

#USER 1000

ENTRYPOINT /bin/bash -l /usr/local/bin/start.sh
#ENTRYPOINT /bin/bash

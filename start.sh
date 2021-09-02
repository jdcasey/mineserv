#!/bin/bash

MS=/usr/local/etc/mineserv

cd /world || exit -1

if [ -d /plugins ]; then
	cp -rf /plugins /world
fi

cp -rf $MS/* /world

exec java $JVM_OPTS -jar /usr/local/lib/mineserv/paper.jar "$PAPER_ARGS"

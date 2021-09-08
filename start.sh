#!/bin/bash

MS=/usr/local/mineserv

cd /world || exit -1

if [ -d $MS/plugins ]; then
	mkdir /world/plugins 2>&1 > /dev/null
	cp -rf /plugins/* /world/plugins
fi

if [ -d $MS/etc ]; then
	cp -rf $MS/etc/* /world
fi

exec java $JVM_OPTS -jar /usr/local/lib/mineserv/paper.jar "$PAPER_ARGS"

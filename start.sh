#!/bin/bash

MS=/usr/local/lib/mineserv
WORLD=/usr/local/mineserv/world

cd $WORLD || exit -1

if [ -d $MS/plugins ]; then
	rm -f $WORLD/plugins/*.jar
	mkdir $WORLD/plugins
	cp -rf $MS/plugins/* $WORLD/plugins
fi

if [ -d $MS/etc ]; then
	cp -rf $MS/etc/* $WORLD
fi

exec java $JVM_OPTS -jar /usr/local/lib/mineserv/paper.jar "$PAPER_ARGS"

#!/bin/bash

MS=/usr/local/mineserv
WORLD=$MS/world

cd $WORLD || exit -1

if [ -d $MS/plugins ]; then
	mkdir $WORLD/plugins 2>&1 > /dev/null
	cp -rf $MS/plugins/* $WORLD/plugins
fi

if [ -d $MS/etc ]; then
	cp -rf $MS/etc/* $WORLD
fi

exec java $JVM_OPTS -jar /usr/local/lib/mineserv/paper.jar "$PAPER_ARGS"

#!/bin/bash

MS=/usr/local/lib/mineserv
WORLD=/usr/local/mineserv/world

cd $WORLD || exit -1

if [ -d $MS/mods ]; then
	rm -f $WORLD/mods/*.jar
	if [ ! -d $WORLD/mods ]; then
		mkdir $WORLD/mods
	fi
	cp -rf $MS/mods/* $WORLD/mods
fi

if [ -d $MS/etc ]; then
	cp -rf $MS/etc/* $WORLD
fi

exec java $JVM_OPTS -jar /usr/local/lib/mineserv/fabric.jar "$SERVER_ARGS"

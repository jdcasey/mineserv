#!/bin/bash

MS=/usr/local/lib/mineserv
CONFIG=/config
WORLD=/world

cd $WORLD || exit -1

if [ ! -d $WORLD/mods ]; then
	mkdir $WORLD/mods
fi

if [ -d $MS/mods ]; then
	rm -f $WORLD/mods/*.jar 2>&1 > /dev/null
	cp -rfv $MS/mods/* $WORLD/mods
fi

for d in $MS/init-etc $CONFIG; do
	for f in $(ls -1 $d); do
		if [ ! -f $WORLD/$f ]; then
			cp -v $d/$f $WORLD/$f
		fi
	done
done

exec java $JVM_OPTS -jar /usr/local/lib/mineserv/fabric.jar "$SERVER_ARGS" $WORLD

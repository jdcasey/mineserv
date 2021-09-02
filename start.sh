#!/bin/bash

MS=/usr/local/lib/mineserv

cd /world
cp -rf /plugins /world

cp -rf $MS/eula.txt /world


exec java -jar /usr/local/lib/mineserv/paper.jar "$@"

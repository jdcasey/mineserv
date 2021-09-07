#!/bin/bash

for f in pvc configmap deployment service loadbalancer-tcp loadbalancer-udp;
do
	kubectl apply -f ${f}.yml || exit $?
done

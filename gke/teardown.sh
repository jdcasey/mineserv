#!/bin/bash

exec kubectl delete service,deployment,configmap,pvc -l app=mineserv

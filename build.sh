#!/bin/bash

exec podman build "$@" --tag=mineserv:local .

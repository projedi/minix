#!/bin/sh

CONTAINER_ROOT=build_container

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

sudo systemd-nspawn -D build_container/ --bind=+/../:/root/src /root/run.sh

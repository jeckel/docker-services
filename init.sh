#!/bin/bash

# Some fancy ansi/unicode variables
readonly RED="\e[0;31m"
readonly BOLD="\e[1m"
readonly ITALIC="\e[3m"
readonly CLEAN="\e[0m"
readonly ERROR="${RED}${BOLD}  \xE2\x9C\x97${ITALIC} error${CLEAN}"

if [ ! -f .env ]; then
    printf "${ERROR} The ${BOLD}.env${CLEAN} file doesn't exists, start by copying the ${BOLD}.env.dist${CLEAN} file into ${BOLD}.env${CLEAN} and update with your configuration.\n"
    exit 1
fi

source .env

if [ `docker network ls | grep -c -w ${NETWORK_NAME}` -eq 0 ]; then
    docker network create ${NETWORK_NAME}
fi

if [ `docker volume ls | grep -c -w ${SYNCTHING_VOLUME_NAME}` -eq 0 ]; then
    docker volume create ${SYNCTHING_VOLUME_NAME}
    # Fix volume owner
    docker run --rm -v ${SYNCTHING_VOLUME_NAME}:/syncthing alpine chown 1000:1000 /syncthing
fi

#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
export IMAGE_TAG="latest"
docker-compose -f vm3-docker-compose.yml down
#dcoker stop $(docker ps -aq)
#docker rm $(docker ps -aq)
docker volume prune
docker network prune

docker-compose -f vm3-docker-compose.yml up -d

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=3
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

docker exec peer0.org2.example.com peer channel fetch newest mychannel.block -o orderer.example.com:7050 -c mychannel
docker exec peer0.org2.example.com peer channel join -b mychannel.block

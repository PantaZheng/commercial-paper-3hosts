#!/bin/bash

set -ev

docker exec cliDigiBank peer chaincode install -n papercontract -v 0 -p /opt/gopath/src/github.com/contract -l node

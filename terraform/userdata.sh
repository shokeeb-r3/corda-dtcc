#!/bin/bash

sudo chown -R 1000:1000 /usr/local/corda/

sudo sysctl -w vm.max_map_count=262144

sudo /usr/local/bin/docker-compose -f /usr/local/corda/mynetwork/docker-compose.yml up -d

sleep 90

sudo /usr/local/bin/docker-compose -f /usr/local/corda/mynetwork/docker-compose.yml up -d



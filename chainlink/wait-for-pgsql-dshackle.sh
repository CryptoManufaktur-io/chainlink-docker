#!/bin/bash
host=$(echo $1 | awk -F/ '{print $3}' | awk -F@ '{print $(NF)}')
target="tcp://$host"
shift
echo "Waiting 30s to allow dShackle to establish all connections"
# This would be better with a JSON-RPC post via dockerize, and, I don't
# think it does that, yet
sleep 30
dockerize -wait $target -wait tcp://dshackle:8545 -timeout 60s "$@"

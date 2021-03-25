#!/bin/bash
host=$(echo $1 | awk -F/ '{print $3}' | awk -F@ '{print $(NF)}')
target="tcp://$host"
shift
dockerize -wait $target -timeout 60s "$@"

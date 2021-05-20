#!/bin/sh
# Fill in port that Chainlink node's web interface runs on
cp /etc/prometheus/prom-with-vars.yml /etc/prometheus/prometheus.yml
sed -i "s/\${CHAIN_TLS_PORT}/${CHAIN_TLS_PORT}/" /etc/prometheus/prometheus.yml


echo "$@"
exec "$@"

#!/bin/bash
# Using ${REDIS_ENABLED} directly in the yaml failed, hence, this
cp /etc/dshackle/dshackle-with-vars.yaml /etc/dshackle/dshackle.yaml
sed -i "s/\${REDIS_PORT}/${REDIS_PORT}/" /etc/dshackle/dshackle.yaml
sed -i "s/\${REDIS_ENABLED}/${REDIS_ENABLED}/" /etc/dshackle/dshackle.yaml

exec "$@"

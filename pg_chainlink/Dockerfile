ARG DOCKER_TAG
# pull official base image
FROM postgres:${DOCKER_TAG} as builder

# run init.sql
ADD init.sql /docker-entrypoint-initdb.d
RUN chmod a+r /docker-entrypoint-initdb.d/*

ENV POSTGRES_PASSWORD=postgres

# Need to change the datadir to something else than /var/lib/postgressql/data because the parent docker file defines it as a volume.
# https://docs.docker.com/engine/reference/builder/#volume :
#       Changing the volume from within the Dockerfile: If any build steps change the data within the volume after
#       it has been declared, those changes will be discarded.
RUN "/usr/local/bin/docker-entrypoint.sh postgres --datadir=/initialized-db"

FROM postgres:${DOCKER_TAG}

COPY --from=builder /initialized-db /var/lib/postgressql/data/

ARG DOCKER_TAG

FROM smartcontract/chainlink:${DOCKER_TAG}

ARG USER

# See https://stackoverflow.com/a/55757473/12429735RUN
RUN adduser \
    --disabled-password \
    --gecos "" \
    --shell "/sbin/nologin" \
    "${USER}"

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/chainlink && chown ${USER}:${USER} /var/lib/chainlink

# Grab dockerize so chainlink can wait for pgsql
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY ./wait-for-pgsql.sh /usr/local/bin/wait-for-pgsql.sh

# Use an unprivileged user.
USER ${USER}

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
  curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/chainlink && chown ${USER}:${USER} /var/lib/chainlink

# Grab dockerize so chainlink can wait for pgsql
RUN curl -sfL $(curl -s https://api.github.com/repos/powerman/dockerize/releases/latest | grep -i /dockerize-$(uname -s)-$(uname -m)\" | cut -d\" -f4) | install /dev/stdin /usr/local/bin/dockerize

COPY ./wait-for-pgsql.sh /usr/local/bin/wait-for-pgsql.sh
COPY ./wait-for-pgsql-dshackle.sh /usr/local/bin/wait-for-pgsql-dshackle.sh

# Use an unprivileged user.
USER ${USER}

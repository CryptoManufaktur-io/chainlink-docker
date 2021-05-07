# link-docker v0.2

docker-compose files for chainlink node

This tool simplifies the installation of a chainlink node with PostgreSQL and
a choice of eth clients.

Supported eth clients:
* 3rd-party such as infura or alchemy
* Geth (geth.yml) 
* OpenEthereum (oe.yml)
* Besu (besu.yml)
* Nethermind (nm.yml) - not usable as of May 2021

Option:
* pgsql.yml - unencrypted PGSQL DB for quick dev environment

# Prerequisites

Some flavor of Linux, and git, docker and docker-compose. Instructions will assume Ubuntu 20.04, adjust as required.

`sudo apt update && sudo apt dist-upgrade` and `sudo apt install -y git docker docker-compose`

`sudo systemctl enable docker` so that docker runs on system start.

You may want to `sudo usermod -aG docker YOURUSERNAME` and then log out and back in to simplify running docker commands,
which will otherwise require `sudo` themselves.

# Clone the tool and configure it

Clone the tool and change into its directory:
`git clone https://github.com/yorickdowne/link-docker.git && cd link-docker`

Set the wallet password and web UI user and password by editing files in the `.secrets` folder, called `wallet-password.txt`
and `apicredentials.txt`. The requirements for the wallet password are 12 characters or longer, 3 uppercase, 3 numbers, 3 symbols.

Move TLS files into `.secrets/tls`: `server.key` and `server.crt` for the node UI, and `pgsqlca.pem` for the CA cert of PGSQL.
If you want to use a self-signed cert for testing purposes for the Web UI, you can create one with `openssl req -newkey rsa:2048 -nodes -keyout .secrets/server.key -x509 -days 365 -out .secrets/server.crt`

Create `.env` from `default.env` and edit it:
`cp default.env .env && nano .env`

Set the `COMPOSE_FILE` to the mix of chainlink and eth node you wish to run. If you are going to use a 3rd-party or off-server, set it
to just `chainlink.yml`. Pay attention to the networks supported by the different eth clients.

Set the `ETH_NODE_1` to the address of the eth service. Leave as-is for local, or use a 3rd-party `wss://` address.
Set `ETH_NODE_2` and `ETH_NODE_3` to failover eth services.

Set the `PGSQL_URL`. If it's local for dev purposes, it can be `postgresql://postgres:postgres@pg_chainlink:5432/chainlink?sslmode=disable`. For an external
DB, TLS should be enabled, and it'll be `postgresql://USER:PASSWORD@HOST:5432/chainlink?sslrootcert=/secrets/tls/pgsqlca.pem`, assuming the DB is called `chainlink`.

Set the `NETWORK_ID` to the id of the network you are going to be on.

Adjust `ETH_NETWORK` to match the network, if you are going to use a local eth node.

Adjust `LINK_CONTRACT_ADDRESS` to match the network.

You can also adjust ports used by local eth and the chainlink web portal, and set the log level and chainlink version.


# Start chainlink

And finally: Start chainlink. `docker-compose up -d chainlink`

Open a browser and connect to `https://SERVERIP:8433`, assuming default web UI TLS port. Log in with the username and password
you specified in `apicredentials.txt`, and continue from there with job creation.

To stop all services, use `docker-compose down`

# A note on eth node stability

In testing, providing the `ETH_SECONDARY_URLS` environment variable destabilized the chainlink node (0.10.5). This tool
uses the fiews eth failover proxy instead.

In testing and by user reports, Fiews and Infura are good 3rd-party providers, while Alchemy has not been consistently stable
for node operators as of May 2021.

# Logging, troubleshooting

You can get the chainlink and eth logs, respectively, via `docker-compose logs -f chainlink` and `docker-compose logs -f eth`

If you need to remove the DB, chainlink directory, or eth DB, take a look at volumes with `docker volume ls` and remove
the volume you wish to clear with `docker volume rm`

LICENSE: MIT

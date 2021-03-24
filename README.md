# link-docker v0.2

docker-compose files for chainlink node

This tool simplifies the installation of a chainlink node with PostgreSQL and
a choice of eth1 clients.

Supported eth1 clients:
* 3rd-party such as infura or alchemy
* Geth (geth.yml) 
* OpenEthereum (oe.yml)
* Besu (besu.yml)
* Nethermind (nm.yml) - won't be usable until it supports eth_subscribe, likely Q1 2021

Option:
* pgsql.yml - unencrypted PGSQL DB for quick dev environment

# Prerequisites

Some flavor of Linux, and git, docker and docker-compose. Instructions will assume Ubuntu 20.04, adjust as required.

`sudo apt update && sudo apt dist-upgrade` and `sudo apt install -y git docker docker-compose`

You may want to `sudo usermod -aG docker YOURUSERNAME` and then log out and back in to simplify running docker commands,
which will otherwise require `sudo` themselves.

# Clone the tool and configure it

Clone the tool and change into its directory:
`git clone https://github.com/yorickdowne/link-docker.git && cd link-docker`

Set the wallet password and web UI user and password by editing files in the `.secrets` folder, called `wallet-password.txt`
and `apicredentials.txt`.

Move TLS files into `.secrets/tls`: `server.key` and `server.crt` for the node UI, and `pgsqlca.pem` for the CA cert of PGSQL

Create `.env` from `default.env` and edit it:
`cp default.env .env && nano .env`

Set the `COMPOSE_FILE` to the mix of chainlink and eth1 you wish to run. If you are going to use a 3rd-party or off-server, set it
to just `chainlink.yml`. Pay attention to the networks supported by the different eth1 clients.

Set the `ETH1_NODE` to the address of the eth1 service. Leave as-is for local, or use a 3rd-party `wss://` address.
Set the `ETH1_FAILOVER_NODE` to the address of the failover eth1 service. This is set to same as the local node by default, and needs to be `https://`
for an external / 3rd-party failover.

Set the `PGSQL_URL`. If it's local for dev purposes, it can be `postgresql://postgres:postgres@pg_chainlink:5432/chainlink?sslmode=disable`. For an external
DB, TLS should be enabled, and it'll be `postgresql://USER:PASSWORD@HOST:5432/chainlink?sslrootcert=/secrets/tls/pgsqlca.pem`, assuming the DB is called `chainlink`.

Set the `NETWORK_ID` to the id of the network you are going to be on.

Adjust `ETH1_NETWORK` to match the network, if you are going to use a local eth1.

Adjust `LINK_CONTRACT_ADDRESS` to match the network.

You can also adjust ports used by local eth1 and the chainlink web portal, and set the log level and chainlink version.

#
# Start chainlink

And finally: Start chainlink. `docker-compose up -d chainlink`

Open a browser and connect to `http://SERVERIP:6688`, assuming default web UI port. Log in with the username and password
you specified in `apicredentials.txt`, and continue from there with job creation.

To stop all services, use `docker-compose down`

# Logging, troubleshooting

You can get the chainlink and eth1 logs, respectively, via `docker-compose logs -f chainlink` and `docker-compose logs -f eth1`

If you need to remove the DB, chainlink directory, or eth1 DB, take a look at volumes with `docker volume ls` and remove
the volume you wish to clear with `docker volume rm`

LICENSE: MIT

# Architecture

## microk8s.io

Simple HA k8s setup for the chainlink node itself. Currently just docker-compose, but this would improve upon that idea with better metrics, rolling upgrades, dev/stage/prod, etc.

Priority: Later.

## PostgreSQL

Via scalegrid BYOC

Cross-region
Cross-AZ 

Todo: Compare responsiveness cross-region and cross-AZ. Cross-region might not be feasible for higher frequency feeds.

Priority: Now.

## Eth1

Currently infura, alchemy failover

Can become OE for Kovan, OE or Geth for mainnet. Definite advantage to running own eth1 for higher frequency feeds.

Metrics desirable - this might live in another cloud via dShackle, reducing AWS costs

Priority: Later

## Chainlink

Currently in docker-compose. microk8s is a good idea, though not necessary to get started

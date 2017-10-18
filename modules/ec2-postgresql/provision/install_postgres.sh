#!/usr/bin/env bash

set -e

DB_NAME=${1}

export DEBIAN_FRONTEND=noninteractive

## Install postgres
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-9.6

## Setup postgres
sudo sed -i.bak -e 's/peer/trust/' /etc/postgresql/9.6/main/pg_hba.conf
sudo systemctl restart postgresql
echo "ALTER USER postgres WITH PASSWORD 'postgres';" | psql -U postgres

## Setup database
echo "CREATE DATABASE hey_mozo ${DB_NAME};" | psql -U postgres

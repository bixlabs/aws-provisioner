#!/usr/bin/env bash

set -e
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install -y build-essential libssl-dev

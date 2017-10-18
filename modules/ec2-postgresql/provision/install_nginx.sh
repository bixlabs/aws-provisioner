#!/usr/bin/env bash

set -e
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install -y nginx
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s $HOME/provision/nginx_app.conf /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
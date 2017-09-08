#!/usr/bin/env bash

# This loads nvm
export NVM_DIR="$HOME/.nvm"
\. "$NVM_DIR/nvm.sh"

cp -r $HOME/provision/app $HOME/
cp -r $HOME/provision/pm2.json $HOME/app-pm2.json
npm i -g pm2

cd $HOME/app
npm i

pm2 start $HOME/app-pm2.json
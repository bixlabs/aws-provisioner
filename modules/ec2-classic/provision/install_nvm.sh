#!/usr/bin/env bash

function latest_version() {
    curl -s https://api.github.com/repos/creationix/nvm/releases/latest \
        | grep 'tag_name' \
        | cut -d '"' -f 4
}

function install_version() {
    curl "https://raw.githubusercontent.com/creationix/nvm/${1}/install.sh" \
        | bash
}

install_version `latest_version`

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install 8.4.0
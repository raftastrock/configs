#!/bin/bash

# checks for java installation

# checks for npm installation
if ! [ -x "$(command -v npm)" ]; then
  echo '✖️ Error: npm is not installed. Installing now' >&2
  curl -L https://git.io/n-install | bash
else
  echo '✔ Node and npm are installed'
fi

# checks for opn package
if ! [ -x "$(command -v opn)" ]; then
  echo '✖️ Error: opn is not installed. Installing now'
  sudo npm i -g opn-cli
else
  echo '✔ Opn (opens links in browser) is installed'
fi

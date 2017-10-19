#!/bin/bash

# checks for npm installation
if ! [ -x "$(command -v npm)" ]; then
  echo '✖️ Error: npm is not installed. Installing now' >&2
  echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc
  . ~/.bashrc
  mkdir ~/local
  mkdir ~/node-latest-install
  cd ~/node-latest-install
  curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
  ./configure --prefix=~/local
  make install # ok, fine, this step probably takes more than 30 seconds...
  curl https://www.npmjs.org/install.sh | sh
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

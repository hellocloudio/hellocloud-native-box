#!/usr/bin/env bash

echo "[Running nodejs-install.sh]"
# https://nodejs.org/en/download/package-manager#debian-and-ubuntu-based-linux-distributions
# https://github.com/nodesource/distributionshttps://github.com/nodesource/distributions
# https://github.com/nodesource/distributions#debinstall
# https://nodejs.org/dist/v18.16.1/

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
node -v
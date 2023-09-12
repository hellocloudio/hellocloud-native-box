#!/usr/bin/env bash

echo "[Running httpie-install.sh]"

# Install httpie https://httpie.io/cli
curl -SsL https://packages.httpie.io/deb/KEY.gpg | apt-key add -
curl -SsL -o /etc/apt/sources.list.d/httpie.list https://packages.httpie.io/deb/httpie.list
sudo apt update -y
sudo apt install httpie -y

# Upgrade httpie
# sudo apt update -y
# sudo apt upgrade httpie -y
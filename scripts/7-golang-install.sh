#!/usr/bin/env bash

echo "[Running golang-install/.sh]"
sudo apt-get update -y
sleep 0.5
# sudo wget https://go.dev/dl/go1.19.linux-amd64.tar.gz
sudo wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
sleep 0.5
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.5.linux-amd64.tar.gz
sleep 0.5
export PATH=$PATH:/usr/local/go/bin # TODO : Add /usr/local/go/bin to the PATH environment variable. adding the following line to your $HOME/.profile or /etc/profile
sleep 0.5
sudo echo 'export PATH="$PATH:/usr/local/go/bin"' >> $HOME/.profile
source ~/.profile
sleep 0.5
sudo rm -rf go1.20*
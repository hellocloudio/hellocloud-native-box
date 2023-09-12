#!/usr/bin/env bash

echo "[Running grpcurl-instal.sh]"
sudo apt-get update -y
# wget https://github.com/fullstorydev/grpcurl/releases/download/v1.7.0/grpcurl_1.7.0_linux_x86_64.tar.gz
# wget https://github.com/fullstorydev/grpcurl/releases/download/v1.8.6/grpcurl_1.8.6_linux_x86_64.tar.gz
wget https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz
sleep 0.5
# tar -xvf grpcurl_1.7.0_linux_x86_64.tar.gz
tar -xvf grpcurl_1.8.7_linux_x86_64.tar.gz
sleep 0.5
sudo chmod +x grpcurl
sudo cp grpcurl /usr/local/bin
sleep 0.5
sudo rm -rf grpcurl*
grpcurl --version
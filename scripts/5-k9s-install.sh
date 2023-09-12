#!/usr/bin/env bash

echo "[Running k9s-install.sh]"

curl -sS https://webinstall.dev/k9s | bash
sleep 1
source ~/.config/envman/PATH.env
sudo cp ~/.local/bin/k9s /usr/local/bin/
k9s version
#!/usr/bin/env bash

echo "[Running terraform-install.sh]"
# https://developer.hashicorp.com/terraform/downloads
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
terraform -help
terraform version

# entable tab completion
# touch ~/.bashrc
# terraform -install-autocomplete
# Prerequisite
# HashiCorp Official Packaging Guide
https://www.hashicorp.com/official-packaging-guide

# Run
sudo apt update && sudo apt install gpg

# Ref
https://developer.hashicorp.com/vault/downloads

# Run
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
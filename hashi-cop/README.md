## Hashi Tools Setup on Mac

#### Install Vault
```
https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install

brew tap hashicorp/tap
brew install hashicorp/tap/vault

# To update latest
brew upgrade hashicorp/tap/vault

```
#### Install Terraform
```
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -install-autocomplete
```
#### Install AWS CLI
```
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

$ which aws
/usr/local/bin/aws

```
#### ~/.bash_profle
```
eval "$(/usr/local/bin/brew shellenv)"

complete -C /usr/local/bin/terraform terraform

# vault
# source ~/.bash_profile
# sample commands: vrd1 | vault1 status | vrd2 | vault2 login root

alias vault1='VAULT_ADDR=http://0.0.0.0:8200 vault $@'
alias vault2='VAULT_ADDR=http://0.0.0.0:8202 vault $@'
alias vault3='VAULT_ADDR=http://0.0.0.0:8204 vault $@'
alias vault4='VAULT_ADDR=http://0.0.0.0:8206 vault $@'
alias vault5='VAULT_ADDR=http://0.0.0.0:8208 vault $@'

alias vrd1='VAULT_UI=true VAULT_REDIRECT_ADDR=http://0.0.0.0:8200 vault server -log-level=trace -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8200 -dev-ha -dev-transactional'
alias vrd2='VAULT_UI=true VAULT_REDIRECT_ADDR=http://0.0.0.0:8202 vault server -log-level=trace -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8202 -dev-ha -dev-transactional'
alias vrd3='VAULT_UI=true VAULT_REDIRECT_ADDR=http://0.0.0.0:8204 vault server -log-level=trace -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8204 -dev-ha -dev-transactional'
alias vrd4='VAULT_UI=true VAULT_REDIRECT_ADDR=http://0.0.0.0:8206 vault server -log-level=trace -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8206 -dev-ha -dev-transactional'
alias vrd5='VAULT_UI=true VAULT_REDIRECT_ADDR=http://0.0.0.0:8208 vault server -log-level=trace -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8208 -dev-ha -dev-transactional'

```
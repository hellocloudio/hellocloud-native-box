#### Install Vault
```
https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install

brew tap hashicorp/tap
brew install hashicorp/tap/vault

# To update latest
brew upgrade hashicorp/tap/vault

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
#### Exploring Vault Helm Chart
```
# Add the HashiCorp Helm repository
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

$ helm search repo hashicorp
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION                                       
hashicorp/consul                        1.2.2           1.16.2          Official HashiCorp Consul Chart                   
hashicorp/terraform                     1.1.2                           Install and configure Terraform Cloud Operator ...
hashicorp/terraform-cloud-operator      0.0.7           2.0.0-beta6     A Helm chart for HashiCorp Terraform Cloud Kube...
hashicorp/terraform-enterprise          1.0.0           1.16.0          Official HashiCorp Terraform-Enterprise Chart     
hashicorp/vault                         0.25.0          1.14.0          Official HashiCorp Vault Chart                    
hashicorp/vault-secrets-operator        0.3.4           0.3.4           Official Vault Secrets Operator Chart             
hashicorp/waypoint                      0.1.21          0.11.3          Official Helm Chart for HashiCorp Waypoint 

# List available releases for Vault
$ helm search repo hashicorp/vault --versions
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION                               
hashicorp/vault                         0.25.0          1.14.0          Official HashiCorp Vault Chart            
hashicorp/vault                         0.24.1          1.13.1          Official HashiCorp Vault Chart            
hashicorp/vault                         0.24.0          1.13.1          Official HashiCorp Vault Chart            
hashicorp/vault                         0.23.0          1.12.1          Official HashiCorp Vault Chart            
hashicorp/vault                         0.22.1          1.12.0          Official HashiCorp Vault Chart            
hashicorp/vault                         0.22.0          1.11.3          Official HashiCorp Vault Chart            
hashicorp/vault                         0.21.0          1.11.2          Official HashiCorp Vault Chart            
hashicorp/vault                         0.20.1          1.10.3          Official HashiCorp Vault Chart            
hashicorp/vault                         0.20.0          1.10.3          Official HashiCorp Vault Chart            
hashicorp/vault                         0.19.0          1.9.2           Official HashiCorp Vault Chart            
hashicorp/vault                         0.18.0          1.9.0           Official HashiCorp Vault Chart            
hashicorp/vault                         0.17.1          1.8.4           Official HashiCorp Vault Chart            
hashicorp/vault                         0.17.0          1.8.4           Official HashiCorp Vault Chart            
hashicorp/vault                         0.16.1          1.8.3           Official HashiCorp Vault Chart            
hashicorp/vault                         0.16.0          1.8.2           Official HashiCorp Vault Chart            
hashicorp/vault                         0.15.0          1.8.1           Official HashiCorp Vault Chart            
hashicorp/vault                         0.14.0          1.8.0           Official HashiCorp Vault Chart            
hashicorp/vault                         0.13.0          1.7.3           Official HashiCorp Vault Chart            
hashicorp/vault                         0.12.0          1.7.2           Official HashiCorp Vault Chart            
hashicorp/vault                         0.11.0          1.7.0           Official HashiCorp Vault Chart            
hashicorp/vault                         0.10.0          1.7.0           Official HashiCorp Vault Chart            
hashicorp/vault                         0.9.1           1.6.2           Official HashiCorp Vault Chart            
hashicorp/vault                         0.9.0           1.6.1           Official HashiCorp Vault Chart            
hashicorp/vault                         0.8.0           1.5.4           Official HashiCorp Vault Chart            
hashicorp/vault                         0.7.0           1.5.2           Official HashiCorp Vault Chart            
hashicorp/vault                         0.6.0           1.4.2           Official HashiCorp Vault Chart            
hashicorp/vault                         0.5.0                           Install and configure Vault on Kubernetes.
hashicorp/vault                         0.4.0                           Install and configure Vault on Kubernetes.
hashicorp/vault-secrets-operator        0.3.4           0.3.4           Official Vault Secrets Operator Chart     
hashicorp/vault-secrets-operator        0.3.3           0.3.3           Official Vault Secrets Operator Chart     
hashicorp/vault-secrets-operator        0.3.2           0.3.2           Official Vault Secrets Operator Chart     
hashicorp/vault-secrets-operator        0.3.1           0.3.1           Official Vault Secrets Operator Chart     
hashicorp/vault-secrets-operator        0.2.0           0.2.0           Official Vault Secrets Operator Chart     
hashicorp/vault-secrets-operator        0.1.0           0.1.0           Official Vault Secrets Operator Chart

# Pull the Helm Chart and Untar
helm pull hashicorp/vault --version 0.25.0 --untar

# How to Dry Run
helm install vault hashicorp/vault --namespace vault --dry-run

```
#### Install Vault
#### Create a file named helm-vault-raft-values.yml with the following contents:
```
cat > helm-vault-raft-values.yml <<EOF
server:
  affinity: ""
  ha:
    enabled: true
    raft: 
      enabled: true
ui:
  enabled: true
  serviceType: "LoadBalancer"
injector:
  enabled: true
EOF
```
#### Install Vault
```
kubectl create ns vault
helm install vault hashicorp/vault --values helm-vault-raft-values.yml -n vault
```
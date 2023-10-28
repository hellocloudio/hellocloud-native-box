#### vault-server pods are running, but none of the containers are up yet. Because Vault is in SEALED state.
```
$ kubectl get pods -n vault
NAME                                    READY   STATUS    RESTARTS   AGE
vault-0                                 0/1     Running   0          30m
vault-1                                 0/1     Running   0          30m
vault-2                                 0/1     Running   0          30m
vault-agent-injector-66dbdbf45d-nj6tw   1/1     Running   0          30m

```
#### Exploring the vault-server PODs metadata
```
kubectl -n vault exec vault-0 -- env
kubectl -n vault exec vault-1 -- env
kubectl -n vault exec vault-2 -- env

# example
$ kubectl -n vault exec vault-0 -- env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=vault-0
NAME=vault
VERSION=
HOST_IP=172.18.0.5
VAULT_K8S_NAMESPACE=vault
VAULT_ADDR=http://127.0.0.1:8200
VAULT_API_ADDR=http://10.243.1.3:8200
SKIP_SETCAP=true
VAULT_CLUSTER_ADDR=https://vault-0.vault-internal:8201
POD_IP=10.243.1.3
VAULT_K8S_POD_NAME=vault-0
SKIP_CHOWN=true
HOME=/home/vault
KUBERNETES_PORT_443_TCP_PROTO=tcp
VAULT_SERVICE_PORT_HTTP=8200
VAULT_UI_PORT=tcp://10.123.78.92:8200
VAULT_AGENT_INJECTOR_SVC_PORT=tcp://10.123.193.160:443
VAULT_STANDBY_SERVICE_HOST=10.123.123.29
VAULT_STANDBY_PORT=tcp://10.123.123.29:8200
VAULT_STANDBY_PORT_8200_TCP=tcp://10.123.123.29:8200
VAULT_STANDBY_PORT_8200_TCP_PROTO=tcp
VAULT_SERVICE_HOST=10.123.235.144
KUBERNETES_PORT_443_TCP_PORT=443
VAULT_UI_SERVICE_PORT=8200
VAULT_ACTIVE_SERVICE_PORT_HTTP=8200
VAULT_ACTIVE_PORT_8201_TCP=tcp://10.123.203.242:8201
VAULT_ACTIVE_PORT_8201_TCP_ADDR=10.123.203.242
KUBERNETES_SERVICE_PORT=443
VAULT_STANDBY_PORT_8201_TCP_PORT=8201
VAULT_SERVICE_PORT=8200
VAULT_PORT_8201_TCP_ADDR=10.123.235.144
VAULT_UI_PORT_8200_TCP_ADDR=10.123.78.92
VAULT_ACTIVE_PORT=tcp://10.123.203.242:8200
VAULT_ACTIVE_PORT_8200_TCP_PROTO=tcp
VAULT_PORT_8200_TCP_ADDR=10.123.235.144
VAULT_STANDBY_SERVICE_PORT_HTTPS_INTERNAL=8201
VAULT_STANDBY_PORT_8200_TCP_PORT=8200
VAULT_PORT=tcp://10.123.235.144:8200
KUBERNETES_PORT_443_TCP=tcp://10.123.0.1:443
KUBERNETES_PORT_443_TCP_ADDR=10.123.0.1
VAULT_UI_SERVICE_PORT_HTTP=8200
VAULT_AGENT_INJECTOR_SVC_SERVICE_PORT_HTTPS=443
VAULT_ACTIVE_PORT_8200_TCP_ADDR=10.123.203.242
VAULT_PORT_8201_TCP_PROTO=tcp
VAULT_PORT_8200_TCP_PORT=8200
VAULT_UI_PORT_8200_TCP=tcp://10.123.78.92:8200
VAULT_ACTIVE_SERVICE_PORT_HTTPS_INTERNAL=8201
VAULT_AGENT_INJECTOR_SVC_PORT_443_TCP=tcp://10.123.193.160:443
VAULT_ACTIVE_PORT_8201_TCP_PORT=8201
VAULT_PORT_8200_TCP=tcp://10.123.235.144:8200
VAULT_UI_PORT_8200_TCP_PROTO=tcp
VAULT_AGENT_INJECTOR_SVC_PORT_443_TCP_ADDR=10.123.193.160
VAULT_STANDBY_PORT_8200_TCP_ADDR=10.123.123.29
KUBERNETES_PORT=tcp://10.123.0.1:443
VAULT_ACTIVE_SERVICE_PORT=8200
VAULT_ACTIVE_PORT_8200_TCP_PORT=8200
VAULT_ACTIVE_PORT_8201_TCP_PROTO=tcp
VAULT_STANDBY_SERVICE_PORT=8200
VAULT_STANDBY_PORT_8201_TCP_PROTO=tcp
KUBERNETES_SERVICE_PORT_HTTPS=443
VAULT_UI_SERVICE_HOST=10.123.78.92
VAULT_AGENT_INJECTOR_SVC_SERVICE_HOST=10.123.193.160
VAULT_AGENT_INJECTOR_SVC_SERVICE_PORT=443
VAULT_AGENT_INJECTOR_SVC_PORT_443_TCP_PORT=443
VAULT_PORT_8201_TCP_PORT=8201
VAULT_ACTIVE_PORT_8200_TCP=tcp://10.123.203.242:8200
VAULT_PORT_8200_TCP_PROTO=tcp
VAULT_PORT_8201_TCP=tcp://10.123.235.144:8201
KUBERNETES_SERVICE_HOST=10.123.0.1
VAULT_AGENT_INJECTOR_SVC_PORT_443_TCP_PROTO=tcp
VAULT_ACTIVE_SERVICE_HOST=10.123.203.242
VAULT_SERVICE_PORT_HTTPS_INTERNAL=8201
VAULT_UI_PORT_8200_TCP_PORT=8200
VAULT_STANDBY_SERVICE_PORT_HTTP=8200
VAULT_STANDBY_PORT_8201_TCP=tcp://10.123.123.29:8201
VAULT_STANDBY_PORT_8201_TCP_ADDR=10.123.123.29
```
#### Exploring the vault-server PODs status using `vault status` command
#### `Initialized` is `false`
#### `Sealed` is `true`
#### `Total Shares` is `0`
#### `Threshold` is `0`
#### `Unseal Progress` is `0/0`
```
kubectl -n vault exec vault-0 -- vault status
kubectl -n vault exec vault-1 -- vault status
kubectl -n vault exec vault-2 -- vault status

# example
$ kubectl -n vault exec vault-0 -- vault status
Key                Value
---                -----
Seal Type          shamir
Initialized        false
Sealed             true
Total Shares       0
Threshold          0
Unseal Progress    0/0
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true
command terminated with exit code 2

$ kubectl -n vault exec vault-1 -- vault status
Key                Value
---                -----
Seal Type          shamir
Initialized        false
Sealed             true
Total Shares       0
Threshold          0
Unseal Progress    0/0
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true
command terminated with exit code 2

$ kubectl -n vault exec vault-2 -- vault status
Key                Value
---                -----
Seal Type          shamir
Initialized        false
Sealed             true
Total Shares       0
Threshold          0
Unseal Progress    0/0
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true
command terminated with exit code 2
```

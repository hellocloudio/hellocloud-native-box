#### Initialize vault-server `vault-0` using `vault operator init` command.
#### Initialization is the process by which Vault's storage backend is prepared to receive data.
#### Since Vault servers share the same storage backend in HA mode, you `only need to initialize one Vault` to initialize the storage backend.
```
$ kubectl -n vault exec vault-0 -- vault operator init
Unseal Key 1: q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
Unseal Key 2: zP2JzuPnM4pyi++p3suFIFxa7ubgijw14xdgS2FxX97z
Unseal Key 3: fgmDyCgWRlYDzTexm7JSTQpnpKFjp+Ao9kb8szURpvi1
Unseal Key 4: H743VzQS8+Vo9BTo+Pjc71KLYXkQixXaN40FvmEa2JRi
Unseal Key 5: lW+6SmS5u/mDhoq0UtvD2i8sNPSbKxqqaroTW89PKvb0

Initial Root Token: hvs.Ob5F8DgbR0WUpnXgR6dy4s2H

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated root key. Without at least 3 keys to
reconstruct the root key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.

```
#### `vault operator init` command cannot be run against already-initialized Vault cluster.
```
$ kubectl -n vault exec vault-0 -- vault operator init
Error initializing: Error making API request.

URL: PUT http://127.0.0.1:8200/v1/sys/init
Code: 400. Errors:

* Vault is already initialized
command terminated with exit code 2
```
#### Exploring the vault-server PODs status using `vault status` command again
#### `Initialized` is `true` now
#### `Sealed` is still `true`
#### `Total Shares` is `5`
#### `Threshold` is `3`
#### `Unseal Progress` is `0/3` now

```
$ kubectl -n vault exec vault-0 -- vault status
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    0/3
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true
command terminated with exit code 2

```
#### 1st Unseal for vault-0
```
$ kubectl -n vault exec vault-0 -- vault operator unseal q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       a1f0fe84-5973-5800-ed17-310e1f281012
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

```
#### 2nd Unseal for vault-0
```
$ kubectl -n vault exec vault-0 -- vault operator unseal zP2JzuPnM4pyi++p3suFIFxa7ubgijw14xdgS2FxX97z
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       a1f0fe84-5973-5800-ed17-310e1f281012
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

```
#### 3rd Unseal for vault-0
```
$ kubectl -n vault exec vault-0 -- vault operator unseal fgmDyCgWRlYDzTexm7JSTQpnpKFjp+Ao9kb8szURpvi1
Key                     Value
---                     -----
Seal Type               shamir
Initialized             true
Sealed                  false
Total Shares            5
Threshold               3
Version                 1.14.0
Build Date              2023-06-19T11:40:23Z
Storage Type            raft
Cluster Name            vault-cluster-dbea6d73
Cluster ID              867e125f-4440-2f19-56a9-f376266df9fb
HA Enabled              true
HA Cluster              https://vault-0.vault-internal:8201
HA Mode                 active
Active Since            2023-10-27T11:24:28.723718674Z
Raft Committed Index    36
Raft Applied Index      36

```
#### Exploring the vault-server PODs status using `vault status` command again
#### `Sealed` is still `false` now
#### Take note of `Cluster Name`, `Cluster ID`, `HA Enabled`, `HA Cluster`, and `HA Mode` now

```
$ kubectl -n vault exec vault-0 -- vault status
Key                     Value
---                     -----
Seal Type               shamir
Initialized             true
Sealed                  false
Total Shares            5
Threshold               3
Version                 1.14.0
Build Date              2023-06-19T11:40:23Z
Storage Type            raft
Cluster Name            vault-cluster-dbea6d73
Cluster ID              867e125f-4440-2f19-56a9-f376266df9fb
HA Enabled              true
HA Cluster              https://vault-0.vault-internal:8201
HA Mode                 active
Active Since            2023-10-27T11:24:28.723718674Z
Raft Committed Index    36
Raft Applied Index      36

```
#### `vault-0` pod is up and running now.
```
$ kubectl get pods -n vault
NAME                                    READY   STATUS    RESTARTS   AGE
vault-0                                 1/1     Running   0          100m
vault-1                                 0/1     Running   0          100m
vault-2                                 0/1     Running   0          100m
vault-agent-injector-66dbdbf45d-nj6tw   1/1     Running   0          100m

```

#### Before Unsealing vault-1, join to the RAFT Clusters `http://vault-0.vault-internal:8200`
```
$ kubectl -n vault exec vault-1 -- vault operator raft join http://vault-0.vault-internal:8200
Key       Value
---       -----
Joined    true

$ kubectl -n vault exec vault-1 -- vault status
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    0/3
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true
command terminated with exit code 2

```
#### 1st, 2nd and 3rd Unseal for vault-1
```
Unseal Key 1: q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
Unseal Key 2: zP2JzuPnM4pyi++p3suFIFxa7ubgijw14xdgS2FxX97z
Unseal Key 3: fgmDyCgWRlYDzTexm7JSTQpnpKFjp+Ao9kb8szURpvi1
Unseal Key 4: H743VzQS8+Vo9BTo+Pjc71KLYXkQixXaN40FvmEa2JRi
Unseal Key 5: lW+6SmS5u/mDhoq0UtvD2i8sNPSbKxqqaroTW89PKvb0

Initial Root Token: hvs.Ob5F8DgbR0WUpnXgR6dy4s2H

kubectl -n vault exec vault-1 -- vault operator unseal q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
kubectl -n vault exec vault-1 -- vault operator unseal zP2JzuPnM4pyi++p3suFIFxa7ubgijw14xdgS2FxX97z
kubectl -n vault exec vault-1 -- vault operator unseal lW+6SmS5u/mDhoq0UtvD2i8sNPSbKxqqaroTW89PKvb0

$ kubectl -n vault exec vault-1 -- vault operator unseal q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       935314ee-c4d2-3cfc-fe80-c9b9cd3fb13e
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

$ kubectl -n vault exec vault-1 -- vault operator unseal zP2JzuPnM4pyi++p3suFIFxa7ubgijw14xdgS2FxX97z
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       935314ee-c4d2-3cfc-fe80-c9b9cd3fb13e
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

$ kubectl -n vault exec vault-1 -- vault operator unseal lW+6SmS5u/mDhoq0UtvD2i8sNPSbKxqqaroTW89PKvb0
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    0/3
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

$ kubectl -n vault exec vault-1 -- vault status
Key                     Value
---                     -----
Seal Type               shamir
Initialized             true
Sealed                  false
Total Shares            5
Threshold               3
Version                 1.14.0
Build Date              2023-06-19T11:40:23Z
Storage Type            raft
Cluster Name            vault-cluster-dbea6d73
Cluster ID              867e125f-4440-2f19-56a9-f376266df9fb
HA Enabled              true
HA Cluster              https://vault-0.vault-internal:8201
HA Mode                 standby
Active Node Address     http://10.243.3.3:8200
Raft Committed Index    40
Raft Applied Index      40

```
#### Verify RAFT list-peers
```
$ kubectl -n vault exec vault-0 -- vault login hvs.Ob5F8DgbR0WUpnXgR6dy4s2H
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                hvs.Ob5F8DgbR0WUpnXgR6dy4s2H
token_accessor       Ytk7ZCEXpeUEjOqmvOmwODAV
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]

$ kubectl -n vault exec vault-0 -- vault operator raft list-peers
Node                                    Address                        State       Voter
----                                    -------                        -----       -----
a5156619-06a9-5255-18a9-9723cec8b6b6    vault-0.vault-internal:8201    leader      true
da6dec74-fe6a-4a63-461d-3eb0280989cf    vault-1.vault-internal:8201    follower    true

```
#### Before Unsealing vault-2, join to the RAFT Clusters `http://vault-0.vault-internal:8200`
```
$ kubectl -n vault exec vault-2 -- vault operator raft join http://vault-0.vault-internal:8200
Key       Value
---       -----
Joined    true

$ kubectl -n vault exec vault-2 -- vault status
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    0/3
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true
command terminated with exit code 2

```

#### 1st, 2nd and 3rd Unseal for vault-2
```
Unseal Key 1: q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
Unseal Key 2: zP2JzuPnM4pyi++p3suFIFxa7ubgijw14xdgS2FxX97z
Unseal Key 3: fgmDyCgWRlYDzTexm7JSTQpnpKFjp+Ao9kb8szURpvi1
Unseal Key 4: H743VzQS8+Vo9BTo+Pjc71KLYXkQixXaN40FvmEa2JRi
Unseal Key 5: lW+6SmS5u/mDhoq0UtvD2i8sNPSbKxqqaroTW89PKvb0

Initial Root Token: hvs.Ob5F8DgbR0WUpnXgR6dy4s2H

kubectl -n vault exec vault-2 -- vault operator unseal q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
kubectl -n vault exec vault-2 -- vault operator unseal fgmDyCgWRlYDzTexm7JSTQpnpKFjp+Ao9kb8szURpvi1
kubectl -n vault exec vault-2 -- vault operator unseal H743VzQS8+Vo9BTo+Pjc71KLYXkQixXaN40FvmEa2JRi

$ kubectl -n vault exec vault-2 -- vault operator unseal q9vqwk2NMBvYCbaFujeBbu1EB8vjBYiZgNcoI4B2LbI3
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       1517216b-5d3f-64b1-25c4-88164c71d389
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

$ kubectl -n vault exec vault-2 -- vault operator unseal fgmDyCgWRlYDzTexm7JSTQpnpKFjp+Ao9kb8szURpvi1
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       1517216b-5d3f-64b1-25c4-88164c71d389
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

$ kubectl -n vault exec vault-2 -- vault operator unseal H743VzQS8+Vo9BTo+Pjc71KLYXkQixXaN40FvmEa2JRi
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    0/3
Unseal Nonce       n/a
Version            1.14.0
Build Date         2023-06-19T11:40:23Z
Storage Type       raft
HA Enabled         true

$ kubectl -n vault exec vault-2 -- vault status
Key                     Value
---                     -----
Seal Type               shamir
Initialized             true
Sealed                  false
Total Shares            5
Threshold               3
Version                 1.14.0
Build Date              2023-06-19T11:40:23Z
Storage Type            raft
Cluster Name            vault-cluster-dbea6d73
Cluster ID              867e125f-4440-2f19-56a9-f376266df9fb
HA Enabled              true
HA Cluster              https://vault-0.vault-internal:8201
HA Mode                 standby
Active Node Address     http://10.243.3.3:8200
Raft Committed Index    42
Raft Applied Index      42
```
#### Verify RAFT list-peers
```
$ kubectl -n vault exec vault-0 -- vault operator raft list-peers
Node                                    Address                        State       Voter
----                                    -------                        -----       -----
a5156619-06a9-5255-18a9-9723cec8b6b6    vault-0.vault-internal:8201    leader      true
da6dec74-fe6a-4a63-461d-3eb0280989cf    vault-1.vault-internal:8201    follower    true
b2e8b321-8295-1e75-0dce-d8632d33dfe8    vault-2.vault-internal:8201    follower    true

```
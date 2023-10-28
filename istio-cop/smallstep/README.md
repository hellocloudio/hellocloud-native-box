### https://smallstep.com/docs/step-cli/installation/#debian

#### Install smallstep
```
cd /home/vagrant/vcs-cop/hellocloud-native-box/istio-cop/smallstep

wget https://dl.smallstep.com/gh-release/cli/docs-cli-install/v0.24.4/step-cli_0.24.4_amd64.deb
sudo dpkg -i step-cli_0.24.4_amd64.deb

$ which step
/usr/bin/step

rm -rf step-cli_0.24.4_amd64.deb
```
#### Create CA
```
cd /home/vagrant/vcs-cop/hellocloud-native-box/istio-cop/
mkdir ca

# Create a root certificate and key - do not encrypt the key when writing to disk

step certificate create grincerlabs-ca ./ca/root-ca.crt ./ca/root-ca.key --profile root-ca --subtle --no-password --kty RSA --insecure --not-after="87600h"

# verify
openssl x509 --text --noout --in ./ca/root-ca.crt

```
#### create leaf certificate which is signed by CA (for rabbit.io)
```
step certificate create rabbit.io rabbit.io.crt rabbit.io.key --profile leaf --subtle --no-password --kty RSA --insecure --not-after="8760h" --ca ./ca/root-ca.crt --ca-key ./ca/root-ca.key

# verify
openssl x509 --text --noout --in ./rabbit.io.crt

```
#### create leaf certificate which is signed by CA (for elephant.io)
```
step certificate create elephant.io elephant.io.crt elephant.io.key --profile leaf --subtle --no-password --kty RSA --insecure --not-after="8760h" --ca ./ca/root-ca.crt --ca-key ./ca/root-ca.key

# verify
openssl x509 --text --noout --in ./elephant.io.crt

```
#### create leaf certificate which is signed by CA (for hellocloud.io)
```
step certificate create hellocloud.io hellocloud.io.crt hellocloud.io.key --profile leaf --subtle --no-password --kty RSA --insecure --not-after="8760h" --ca ./ca/root-ca.crt --ca-key ./ca/root-ca.key

# verify
openssl x509 --text --noout --in ./hellocloud.io.crt

```
#### create as k8s tls secret
```
kubectl create -n istio-system secret tls rabbit-cert --key rabbit.io.key --cert rabbit.io.crt

kubectl create -n istio-system secret tls elephant-cert --key elephant.io.key --cert elephant.io.crt

kubectl create -n istio-system secret tls hellocloud-cert --key hellocloud.io.key --cert hellocloud.io.crt

```
#### update Istio Gateway Resource - igw-https-rabbit.yaml
```
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: web-api-gateway
  namespace: default # take note namespace
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - "rabbit.io"    
    tls:
      mode: SIMPLE
      credentialName: rabbit-cert

```
#### Test
#### http is not working anymore
```
curl -H "Host: rabbit.io" http://$GATEWAY_IP:$INGRESS_PORT

```
#### test with https
```
curl --cacert ./ca/root-ca.crt -H "Host: rabbit.io" https://rabbit.io:443 --resolve rabbit.io:443:172.18.255.170

curl --cacert ./ca/root-ca.crt -H "Host: elephant.io" https://elephant.io:443 --resolve elephant.io:443:172.18.255.170

```
#### update Istio Gateway Resource - igw-https-rabbit-elephant.yaml
```
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: web-api-gateway
  namespace: default # Take note of namespace
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - "rabbit.io"    
    tls:
      mode: SIMPLE
      credentialName: rabbit-cert
  - port:
      number: 443
      name: https-elephant
      protocol: HTTPS
    hosts:
    - "elephant.io"    
    tls:
      mode: SIMPLE
      credentialName: elephant-cert

```
#### update Istio Gateway Resource - igw-https-rabbit-elephant-hellocloud.yaml
```
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: web-api-gateway
  namespace: default # Take note of namespace
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - "rabbit.io"    
    tls:
      mode: SIMPLE
      credentialName: rabbit-cert
  - port:
      number: 443
      name: https-elephant
      protocol: HTTPS
    hosts:
    - "elephant.io"    
    tls:
      mode: SIMPLE
      credentialName: elephant-cert
  - port:
      number: 443
      name: https-hellocloud
      protocol: HTTPS
    hosts:
    - "hellocloud.io"    
    tls:
      mode: SIMPLE
      credentialName: hellocloud-cert

```
#### Note
**the k8s tls secret cert must be in the same namespace as the istio ingress gateway deployment**. 
Even though the `Gateway` resource is in the `rabbit` or `elephant` or `hellocloud` namespace, _the k8s tls secret cert must be where the istio-ingress gateway is actually deployed_.

#### Verify istioctl pc listener 
```
istioctl pc listener deployment.apps/istio-ingressgateway -n istio-system

```
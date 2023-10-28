### https://smallstep.com/docs/step-cli/installation/#debian

#### deploy microservices
```
kubectl create ns hellocloud
kubectl create ns rabbit
kubectl create ns elephant
kubectl -n hellocloud apply -f sample-apps/
kubectl -n rabbit apply -f sample-apps/
kubectl -n elephant apply -f sample-apps/

```
#### deploy GW and VS
```
kubectl -n hellocloud apply -f hellocloud-web-api-gw.yaml
kubectl -n hellocloud apply -f hellocloud-web-api-gw-vs.yaml

kubectl -n rabbit apply -f rabbit-web-api-gw.yaml
kubectl -n rabbit apply -f rabbit-web-api-gw-vs.yaml

kubectl -n elephant apply -f elephant-web-api-gw.yaml
kubectl -n elephant apply -f elephant-web-api-gw-vs.yaml

```
#### HTTP - Test
```
curl -H "Host: hellocloud.io" http://172.18.255.150
curl -H "Host: rabbit.io" http://172.18.255.150
curl -H "Host: elephant.io" http://172.18.255.150

curl -H "Host: hellocloud.io" http://hellocloud.io --resolve hellocloud.io:80:172.18.255.150
curl -H "Host: rabbit.io" http://rabbit.io --resolve rabbit.io:80:172.18.255.150
curl -H "Host: elephant.io" http://elephant.io --resolve elephant.io:80:172.18.255.150

```
#### test with https (should not work)
```
curl --cacert ./ca/root-ca.crt -H "Host: hellocloud.io" https://hellocloud.io:443 --resolve hellocloud.io:443:172.18.255.150

curl --cacert ./ca/root-ca.crt -H "Host: rabbit.io" https://rabbit.io:443 --resolve rabbit.io:443:172.18.255.150

curl --cacert ./ca/root-ca.crt -H "Host: elephant.io" https://elephant.io:443 --resolve elephant.io:443:172.18.255.150

```
#### create as k8s tls secret
```
kubectl create -n istio-system secret tls rabbit-cert --key rabbit.io.key --cert rabbit.io.crt

kubectl create -n istio-system secret tls elephant-cert --key elephant.io.key --cert elephant.io.crt

kubectl create -n istio-system secret tls hellocloud-cert --key hellocloud.io.key --cert hellocloud.io.crt

```
#### update GW (https)
```
kubectl -n hellocloud apply -f hellocloud-web-api-https-gw.yaml
kubectl -n rabbit apply -f rabbit-web-api-https-gw.yaml
kubectl -n elephant apply -f elephant-web-api-https-gw.yaml

```
#### test with https (should work)
```
curl --cacert ./ca/root-ca.crt -H "Host: hellocloud.io" https://hellocloud.io:443 --resolve hellocloud.io:443:172.18.255.150

curl --cacert ./ca/root-ca.crt -H "Host: rabbit.io" https://rabbit.io:443 --resolve rabbit.io:443:172.18.255.150

curl --cacert ./ca/root-ca.crt -H "Host: elephant.io" https://elephant.io:443 --resolve elephant.io:443:172.18.255.150

```
#### Note
**the k8s tls secret cert must be in the same namespace as the istio ingress gateway deployment**. 
Even though the `Gateway` resource is in the `rabbit` or `elephant` or `hellocloud` namespace, _the k8s tls secret cert must be where the istio-ingress gateway is actually deployed_.

#### Verify istioctl pc listener 
```
$ istioctl pc listener deployment.apps/istio-ingressgateway -n istio-system
ADDRESS PORT  MATCH              DESTINATION
0.0.0.0 8443  SNI: rabbit.io     Route: https.443.https.rabbit-web-api-gateway.rabbit
0.0.0.0 8443  SNI: hellocloud.io Route: https.443.https.hellocloud-web-api-gateway.hellocloud
0.0.0.0 8443  SNI: elephant.io   Route: https.443.https.elephant-web-api-gateway.elephant
0.0.0.0 15021 ALL                Inline Route: /healthz/ready*
0.0.0.0 15090 ALL                Inline Route: /stats/prometheus*

```
#### Verify istioctl pc routes 
```
$ istioctl pc routes deployment.apps/istio-ingressgateway -n istio-system
NAME                                                      VHOST NAME            DOMAINS           MATCH                  VIRTUAL SERVICE
https.443.https.rabbit-web-api-gateway.rabbit             rabbit.io:443         rabbit.io         /*                     rabbit-web-api-gw-vs.rabbit
https.443.https.elephant-web-api-gateway.elephant         elephant.io:443       elephant.io       /*                     elephant-web-api-gw-vs.elephant
https.443.https.hellocloud-web-api-gateway.hellocloud     hellocloud.io:443     hellocloud.io     /*                     hellocloud-web-api-gw-vs.hellocloud
                                                          backend               *                 /stats/prometheus*     
                                                          backend               *                 /healthz/ready*  

```
#### Verify istioctl pc secrets
```
$ istioctl pc secret deployment.apps/istio-ingressgateway -n istio-system
RESOURCE NAME                    TYPE           STATUS     VALID CERT     SERIAL NUMBER                        NOT AFTER                NOT BEFORE
default                          Cert Chain     ACTIVE     true           1942190187211bff4f9a72cd22ea0cfb     2023-10-29T06:52:50Z     2023-10-28T06:50:50Z
kubernetes://rabbit-cert         Cert Chain     ACTIVE     true           19acd56e2d30c94113e3a1a783317026     2024-10-27T06:24:20Z     2023-10-28T06:24:20Z
kubernetes://elephant-cert       Cert Chain     ACTIVE     true           43f4f9eec5b030953474bfb1a64ade2f     2024-10-27T06:25:28Z     2023-10-28T06:25:28Z
kubernetes://hellocloud-cert     Cert Chain     ACTIVE     true           f90902c72989c621114b7a5b539d415c     2024-10-27T06:26:29Z     2023-10-28T06:26:30Z
ROOTCA                           CA             ACTIVE     true           8116cbe9314d68b069450c9d57ae3036     2033-10-25T06:52:24Z     2023-10-28T06:52:24Z

```
#### https Redirect
```
kubectl -n rabbit apply -f rabbit-web-api-https-gw-httpsredirect.yaml

```
#### HTTP - Test (include -vvv)
```
# expected 404
curl -H "Host: hellocloud.io" http://hellocloud.io --resolve hellocloud.io:80:172.18.255.150 -vvv

# (instead of 404, it will redirect as 301 to https)
curl -H "Host: rabbit.io" http://rabbit.io --resolve rabbit.io:80:172.18.255.150 -vvv

# expected 404
curl -H "Host: elephant.io" http://elephant.io --resolve elephant.io:80:172.18.255.150 -vvv

```
#### HTTPS - Test (follow through)
```
# expected success
curl -H "Host: rabbit.io" http://rabbit.io --resolve rabbit.io:80:172.18.255.150 -vvv --location --cacert ./ca/root-ca.crt --resolve rabbit.io:443:172.18.255.150

# expected 404
curl -H "Host: hellocloud.io" http://hellocloud.io --resolve hellocloud.io:80:172.18.255.150 -vvv --location --cacert ./ca/root-ca.crt --resolve hellocloud.io:443:172.18.255.150

# expected 404
curl -H "Host: elephant.io" http://elephant.io --resolve elephant.io:80:172.18.255.150 -vvv --location --cacert ./ca/root-ca.crt --resolve elephant.io:443:172.18.255.150

```
#### Verify istioctl pc listener
```
$ istioctl pc listener deployment.apps/istio-ingressgateway -n istio-system
ADDRESS PORT  MATCH              DESTINATION
0.0.0.0 8080  ALL                Route: http.8080
0.0.0.0 8443  SNI: rabbit.io     Route: https.443.https.rabbit-web-api-gateway.rabbit
0.0.0.0 8443  SNI: hellocloud.io Route: https.443.https.hellocloud-web-api-gateway.hellocloud
0.0.0.0 8443  SNI: elephant.io   Route: https.443.https.elephant-web-api-gateway.elephant
0.0.0.0 15021 ALL                Inline Route: /healthz/ready*
0.0.0.0 15090 ALL                Inline Route: /stats/prometheus*

```
#### Verify istioctl pc routes 
```
$ istioctl pc routes deployment.apps/istio-ingressgateway -n istio-system
NAME                                                      VHOST NAME            DOMAINS           MATCH                  VIRTUAL SERVICE
http.8080                                                 rabbit.io:80          rabbit.io         /*                     rabbit-web-api-gw-vs.rabbit
https.443.https.rabbit-web-api-gateway.rabbit             rabbit.io:443         rabbit.io         /*                     rabbit-web-api-gw-vs.rabbit
https.443.https.elephant-web-api-gateway.elephant         elephant.io:443       elephant.io       /*                     elephant-web-api-gw-vs.elephant
https.443.https.hellocloud-web-api-gateway.hellocloud     hellocloud.io:443     hellocloud.io     /*                     hellocloud-web-api-gw-vs.hellocloud
                                                          backend               *                 /stats/prometheus*     
                                                          backend               *                 /healthz/ready*
                                                          
```
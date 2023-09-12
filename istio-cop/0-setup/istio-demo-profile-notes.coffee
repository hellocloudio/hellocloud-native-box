istioctl x precheck

# istio profiles
istioctl profile list

# install demo profile
istioctl install --set profile=demo -y

# https://istio.io/latest/docs/tasks/observability/logs/access-log/
istioctl install --set profile=demo -y --set meshConfig.accessLogFile=/dev/stdout --set meshConfig.accessLogEncoding=JSON --set meshConfig.accessLogFormat='{"start_time":"%START_TIME%","remote_address":"%DOWNSTREAM_DIRECT_REMOTE_ADDRESS%","user_agent":"%REQ(USER-AGENT)%","host":"%REQ(:AUTHORITY)%","request":"%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%","request_time":"%DURATION%","status":"%RESPONSE_CODE%","status_details":"%RESPONSE_CODE_DETAILS%","bytes_received":"%BYTES_RECEIVED%","bytes_sent":"%BYTES_SENT%","upstream_address":"%UPSTREAM_HOST%","upstream_response_flags":"%RESPONSE_FLAGS%","upstream_response_time":"%RESPONSE_DURATION%","upstream_service_time":"%RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)%","upstream_cluster":"%UPSTREAM_CLUSTER%","x_forwarded_for":"%REQ(X-FORWARDED-FOR)%","request_method":"%REQ(:METHOD)%","request_path":"%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%","request_protocol":"%PROTOCOL%","tls_protocol":"%DOWNSTREAM_TLS_VERSION%","request_id":"%REQ(X-REQUEST-ID)%","sni_host":"%REQUESTED_SERVER_NAME%"}'

# download istio
curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=1.16.1 sh -

# verify
kubectl get all,cm,secrets,envoyfilters -n istio-system
kubectl get crds -n istio-system

istioctl verify-install

# install telemetry add-ons
kubectl apply -f istio-1.13.5/samples/addons
kubectl get pods -n istio-system

# istioctl dashboard prometheus --browser=false --address 0.0.0.0
# istioctl dashboard grafana --browser=false --address 0.0.0.0
# istioctl dashboard jaeger --browser=false --address 0.0.0.0
# istioctl dashboard kiali --browser=false --address 0.0.0.0

# prometheus 9090
kubectl port-forward -n istio-system svc/prometheus --address 0.0.0.0 9090:9090

# grafana 3000
kubectl port-forward -n istio-system svc/grafana --address 0.0.0.0 3000:3000

# jaeger 16686
$ kubectl port-forward -n istio-system svc/tracing --address 0.0.0.0 16686:16686
error: Service tracing does not have a service port 16686

$ kubectl port-forward -n istio-system svc/tracing --address 0.0.0.0 16686:80
Forwarding from 0.0.0.0:16686 -> 16686

# kiali 20001/kiali
$ kubectl port-forward -n istio-system svc/kiali --address 0.0.0.0 20001:20001

# useful istioctl commands
istioctl proxy-status
istioctl x revision list
istioctl pc listener deployment/istio-ingressgateway.istio-system
istioctl pc route deployment/istio-ingressgateway.istio-system
istioctl pc cluster deployment/istio-ingressgateway.istio-system
istioctl pc ep deployment/istio-ingressgateway.istio-system

# helm
# helm repo add istio https://istio-release.storage.googleapis.com/charts
# https://artifacthub.io/packages/helm/istio-official/gateway
# https://artifacthub.io/packages/search?org=istio&sort=relevance&page=1

# useful helm commands
helm show values istio/gateway


helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

###
istio chart version started from 1.12.0-alpha.0 11 Sep, 2021
###

# install istio/base
# https://artifacthub.io/packages/helm/istio-official/base
kubectl create namespace istio-system
helm install istio-base istio/base -n istio-system --version 1.12.4
[or] 
helm install istio-base istio/base -n istio-system --version 1.12.4 --set defaultRevision=1-12-4
# read more for defaultRevision https://istio.io/latest/docs/setup/install/helm/#optional-deleting-crds-installed-by-istio
helm ls -n istio-system

# install istio/istiod
# https://artifacthub.io/packages/helm/istio-official/istiod
helm install istiod istio/istiod -n istio-system --version 1.12.4
[or]
helm install istiod istio/istiod -n istio-system --version 1.12.4 --set revision=1-12-4

# install istio/gateway [ingress]
# https://artifacthub.io/packages/helm/istio-official/gateway
helm install istio-ingressgateway istio/gateway -n istio-system --version 1.12.4
[or]
helm install istio-ingressgateway manifests/charts/gateways/istio-ingress -n istio-system
[or]
helm install istio-ingressgateway manifests/charts/gateways/istio-ingress -n istio-system --set revision=1-12-4
[or]
helm install istio-ingressgateway-1-13-9 manifests/charts/gateways/istio-ingress -n istio-system --set revision=1-13-9 --set gateways.istio-ingressgateway.name=istio-ingressgateway-1-13-9

# install istio/gateway [egress]
helm install istio-egressgateway istio/gateway -n istio-system --version 1.12.4 --set service.type=ClusterIP
[or]
helm install istio-egressgateway manifests/charts/gateways/istio-egress -n istio-system
[or]
helm install istio-egressgateway manifests/charts/gateways/istio-egress -n istio-system --set revision=1-12-4
[or]
helm install istio-egressgateway-1-13-9 manifests/charts/gateways/istio-egress -n istio-system --set revision=1-13-9 --set gateways.istio-egressgateway.name=istio-egressgateway-1-13-9

# optional install istio/cni
# https://artifacthub.io/packages/helm/istio-official/cni

# uninstall istio
helm delete istio-egressgateway -n istio-system
helm delete istio-ingressgateway -n istio-system
helm delete istiod -n istio-system
helm delete istio-base -n istio-system
kubectl delete ns istio-system

# delete Istio CRDs
kubectl get crd -oname | grep --color=never 'istio.io' | xargs kubectl delete


======
************************************************************
************************************************************
As a final step, upgrade the istio base chart 

helm upgrade istio-base istio/base --version 1.13.9 --set defaultRevision=1-13-9 -n istio-system --skip-crds
************************************************************
************************************************************
======
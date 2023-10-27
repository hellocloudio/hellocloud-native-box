# working directory
cd $HOME/istio-cop/1-start-istio/

export ISTIO_VERSION=1.17.5
# export ISTIO_VERSION=1.18.2

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -

# curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=1.18.0-alpha.0 sh -
# curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=1.18.0 sh -


kubectl apply -f istio-1.17.5/samples/addons/

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

kubectl port-forward -n istio-system svc/tracing --address 0.0.0.0 16686:80
Forwarding from 0.0.0.0:16686 -> 16686

# kiali 20001/kiali
kubectl port-forward -n istio-system svc/kiali --address 0.0.0.0 20001:20001


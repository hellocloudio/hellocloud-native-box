# working directory
cd $HOME/istio-cop/1-start-istio/

kubectl create ns hellocloud

kubectl apply -n hellocloud -f sample-apps/web-api.yaml
kubectl apply -n hellocloud -f sample-apps/recommendation.yaml
kubectl apply -n hellocloud -f sample-apps/purchase-history-v1.yaml
kubectl apply -n hellocloud -f sample-apps/sleep.yaml

kubectl get pods -n hellocloud
kubectl get svc -n hellocloud

export GATEWAY_IP=$(kubectl get svc -n istio-system istio-ingressgateway -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
export INGRESS_PORT=80
export SECURE_INGRESS_PORT=443

>> Use the `Istio ingress gateway` to route traffic to microservices. 
>> Using Istio `Gateway` resource, you can configure `what ports` should be exposed, `what protocol` to use, etc. 
>> Using Istio `VirtualService` resource, you can configure `how to route traffic from the Istio ingress gateway` to your `web-api` service.

# Listen
cat ingress/web-api-gw.yaml
kubectl -n hellocloud apply -f ingress/web-api-gw.yaml

# Route
cat ingress/web-api-gw-vs.yaml
kubectl -n hellocloud apply -f ingress/web-api-gw-vs.yaml

istioctl proxy-config routes deploy/istio-ingressgateway.istio-system
istioctl proxy-config routes deploy/istio-ingressgateway.istio-system --name http.8080 -o json

# Test
curl -H "Host: hellocloud.io" http://$GATEWAY_IP:$INGRESS_PORT

    # fix if above doesn't work.
    # update host: web-api.default.svc.cluster.local to host: web-api.hellocloud.svc.cluster.local
    # kubectl -n hellocloud apply -f ingress/web-api-gw-vs.yaml


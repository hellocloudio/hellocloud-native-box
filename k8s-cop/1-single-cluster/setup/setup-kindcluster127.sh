#!/usr/bin/env bash

sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512

kind create cluster --config ../kindconfig/kindconfig-v127.yaml
sleep 1
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.9/config/manifests/metallb-native.yaml --context kind-127
pods_checking=false
# Loop until the pods are running
while ! $pods_checking; do
    # Check if metallb-system pods are running
    if kubectl get pods -n metallb-system | grep -i controller | grep -q 'Running' && kubectl get pods -n metallb-system | grep -i speaker | grep -q 'Running' ; then
        echo "Metallb-system pods are running, proceeding to next step..."
        sleep 5
        echo "[Creating metallb IP-Address Pool]"
        kubectl create -f ../kindconfig/metallb-v0139-ipaddress-pool-4.yaml --context kind-127
        # Set the flag to true to exit the loop
        pods_checking=true
    else
        echo "Metallb-system pods are not running, waiting for 5 seconds..."
        # Wait for 5 seconds before checking again
        sleep 5
    fi
done

sleep 0.5
kubectl get ipaddresspools.metallb.io -n metallb-system
kubectl get l2advertisements.metallb.io -n metallb-system
sleep 1
kubectl config rename-context kind-127 127
watch kubectl get pods -A --context 127

# istioctl install --set profile=demo -y --set meshConfig.accessLogFile=/dev/stdout --set meshConfig.accessLogEncoding=JSON --set meshConfig.accessLogFormat='{"start_time":"%START_TIME%","remote_address":"%DOWNSTREAM_DIRECT_REMOTE_ADDRESS%","user_agent":"%REQ(USER-AGENT)%","host":"%REQ(:AUTHORITY)%","request":"%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%","request_time":"%DURATION%","status":"%RESPONSE_CODE%","status_details":"%RESPONSE_CODE_DETAILS%","bytes_received":"%BYTES_RECEIVED%","bytes_sent":"%BYTES_SENT%","upstream_address":"%UPSTREAM_HOST%","upstream_response_flags":"%RESPONSE_FLAGS%","upstream_response_time":"%RESPONSE_DURATION%","upstream_service_time":"%RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)%","upstream_cluster":"%UPSTREAM_CLUSTER%","x_forwarded_for":"%REQ(X-FORWARDED-FOR)%","request_method":"%REQ(:METHOD)%","request_path":"%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%","request_protocol":"%PROTOCOL%","tls_protocol":"%DOWNSTREAM_TLS_VERSION%","request_id":"%REQ(X-REQUEST-ID)%","sni_host":"%REQUESTED_SERVER_NAME%"}'
# sleep 1
# kubectl apply -f ~/manifests/istio-1.13.5/samples/addons/

# install glooctl
# curl -sL https://run.solo.io/gloo/install | sh
# cd $HOME
# sudo cp ~/.gloo/bin/glooctl /usr/local/bin/

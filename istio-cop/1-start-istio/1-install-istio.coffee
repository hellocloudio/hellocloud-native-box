# pre-requisites
source .bash_profile
asdf list

# install istioctl of your choice if necessary
    # asdf install istioctl 1.18.2
    # asdf install istioctl 1.17.5
    # asdf install istioctl 1.16.7

# set the istio version
asdf global istioctl 1.17.5

export ISTIO_VERSION=1.17.5
# export ISTIO_VERSION=1.18.2

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -

# curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=1.18.0-alpha.0 sh -
# curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=1.18.0 sh -

# sudo cp istio-${ISTIO_VERSION}/bin/istioctl /usr/local/bin

istioctl x precheck

# istio profiles
istioctl profile list

# install demo profile
istioctl install --set profile=demo -y

kubectl get crds -n istio-system

# istioctl install --set profile=ambient -y

# istioctl install --set profile=demo -y --set meshConfig.accessLogFile=/dev/stdout --set meshConfig.accessLogEncoding=JSON --set meshConfig.accessLogFormat='{"start_time":"%START_TIME%","remote_address":"%DOWNSTREAM_DIRECT_REMOTE_ADDRESS%","user_agent":"%REQ(USER-AGENT)%","host":"%REQ(:AUTHORITY)%","request":"%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%","request_time":"%DURATION%","status":"%RESPONSE_CODE%","status_details":"%RESPONSE_CODE_DETAILS%","bytes_received":"%BYTES_RECEIVED%","bytes_sent":"%BYTES_SENT%","upstream_address":"%UPSTREAM_HOST%","upstream_response_flags":"%RESPONSE_FLAGS%","upstream_response_time":"%RESPONSE_DURATION%","upstream_service_time":"%RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)%","upstream_cluster":"%UPSTREAM_CLUSTER%","x_forwarded_for":"%REQ(X-FORWARDED-FOR)%","request_method":"%REQ(:METHOD)%","request_path":"%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%","request_protocol":"%PROTOCOL%","tls_protocol":"%DOWNSTREAM_TLS_VERSION%","request_id":"%REQ(X-REQUEST-ID)%","sni_host":"%REQUESTED_SERVER_NAME%"}'

# kubectl apply -f ~/manifests/istio-1.17.5/samples/addons/


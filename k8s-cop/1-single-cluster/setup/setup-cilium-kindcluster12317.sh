#!/usr/bin/env bash

sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512

kind create cluster --config ../kindconfig/cilium-kindconfig-v12317.yaml
# sleep 1
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.9/config/manifests/metallb-native.yaml --context kind-cluster1
# pods_checking=false
# # Loop until the pods are running
# while ! $pods_checking; do
#     # Check if metallb-system pods are running
#     if kubectl get pods -n metallb-system | grep -i controller | grep -q 'Running' && kubectl get pods -n metallb-system | grep -i speaker | grep -q 'Running' ; then
#         echo "Metallb-system pods are running, proceeding to next step..."
#         sleep 5
#         echo "[Creating metallb IP-Address Pool]"
#         kubectl create -f ../kindconfig/metallb-v0139-ipaddress-pool-1.yaml --context kind-cluster1
#         # Set the flag to true to exit the loop
#         pods_checking=true
#     else
#         echo "Metallb-system pods are not running, waiting for 5 seconds..."
#         # Wait for 5 seconds before checking again
#         sleep 5
#     fi
# done

# sleep 0.5
# kubectl get ipaddresspools.metallb.io -n metallb-system
# kubectl get l2advertisements.metallb.io -n metallb-system
sleep 1
kubectl config rename-context kind-123 123
watch kubectl get pods -A --context 123
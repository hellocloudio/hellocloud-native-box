#!/usr/bin/env bash

sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512

kind create cluster --config ~/manifests/kind-cluster/kindconfig-v1270.yaml
sleep 2
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.9/config/manifests/metallb-native.yaml
sleep 2
# cilium install
sleep 2
count=0
echo

pods_checking=false
# Loop until the pods are running
while ! $pods_checking; do
    # Check if metallb-system pods are running and daemonsets "READY" state and "DESIRED" state must be equal
    if kubectl get deployment controller -n metallb-system -o jsonpath='{.status.readyReplicas}' | \
    grep -q "$(kubectl get deployment controller -n metallb-system -o jsonpath='{.status.availableReplicas}')" && \
    kubectl get daemonsets -n metallb-system -o jsonpath='{.items[*].status.numberReady}' | \
    grep -q "$(kubectl get daemonsets -n metallb-system -o jsonpath='{.items[*].status.desiredNumberScheduled}')" ; then
        echo "Metallb-system deployment & daemonsets are running, proceeding to next step..."
        sleep 5
        echo "[Creating metallb IP-Address Pool]"
        kubectl apply -f $HOME/manifests/kind-cluster/ippool-metallb.yaml
        # Set the flag to true to exit the loop
        pods_checking=true
    else
        sleep 2
        while true; do
            echo "Metallb-system deployment and daemonsets are not running, waiting for $count seconds..."
            count=$((count + 1))
                if ((count >= 5)); then
                    break
                fi
            sleep 0.5
        done
    fi
done

sleep 0.5
kubectl get ipaddresspools.metallb.io -n metallb-system
kubectl get l2advertisements.metallb.io -n metallb-system
sleep 1
watch kubectl get pod -A

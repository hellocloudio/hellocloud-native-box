#!/usr/bin/env bash

echo "[Running tear-down.sh]"

kind delete clusters $(kind get clusters)
kubectl config delete-context $(kubectl config get-contexts -o name)
echo "====== Clean Up kubeconfig ====="
cp -ar ~/scripts/config ~/.kube/
cat ~/.kube/config
echo "====== verify kind cluters ======"
kind get clusters
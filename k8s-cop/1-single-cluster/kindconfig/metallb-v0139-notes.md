# references
https://kind.sigs.k8s.io/docs/user/loadbalancer/

https://computingforgeeks.com/deploy-metallb-load-balancer-on-kubernetes/

part 1
https://medium.com/@charled.breteche/kind-cluster-with-cilium-and-no-kube-proxy-c6f4d84b5a9d
part 2
https://medium.com/@charled.breteche/kind-cilium-metallb-and-no-kube-proxy-a9fe66ddfad6

# useful commands
kubectl get ipaddresspools.metallb.io -n metallb-system
kubectl get l2advertisements.metallb.io -n metallb-system

# testing the metallb
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

for _ in {1..10}; do
  curl ${LB_IP}:5678
done


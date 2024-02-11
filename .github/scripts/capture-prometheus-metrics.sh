set -e
sleep 5s
kubectl port-forward svc/kube-prometheus-stack-prometheus 9090:9090 --namespace monitoring --kubeconfig ~/.kube/config 2>&1 >/dev/null & 
while ! nc -z localhost 9090; do
    sleep 1
done
curl -sS "http://localhost:9090/api/v1/query\?query\=node_load5"
kubectl top node